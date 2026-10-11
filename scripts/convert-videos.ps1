# pre-commit에서 실행:
# 커밋에 포함된 노트의 ![[xxx.mp4]] 임베드를 R2에 업로드한 뒤 <video> 태그(R2 URL)로 치환하고 다시 stage한다.
# 이렇게 하면 로컬 mp4가 없는 기기(새 clone, iPad)에서도 Obsidian에서 영상이 보인다.

param(
  [string]$PublicBaseUrl = "https://pub-44e440a3a3094ebdb6410c42138d1732.r2.dev",
  [string]$Prefix = "videos",
  [string]$VideosDir = "content/assets/videos",
  # 커밋 대상이 아닌 전체 노트를 일괄 변환할 때 사용
  [switch]$All
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# 커밋 대상 노트 중 mp4 임베드가 있는 것만 처리
if ($All) {
  $staged = git -c core.quotepath=false ls-files -- "*.md"
} else {
  $staged = git -c core.quotepath=false diff --cached --name-only --diff-filter=ACMR -- "*.md"
}
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$embedRe = [regex]'!\[\[([^\]|]+?\.mp4)(\|[^\]]*)?\]\]'
$targets = @($staged | Where-Object { $_ -and (Test-Path -LiteralPath $_) -and $embedRe.IsMatch([IO.File]::ReadAllText($_, $utf8NoBom)) })
if ($targets.Count -eq 0) { exit 0 }

# Load .env from repo root if exists
$envFile = Join-Path (Get-Location) ".env"
if (Test-Path $envFile) {
  Get-Content $envFile | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith("#") -and $line.Contains("=")) {
      $k, $v = $line.Split("=", 2)
      $k = $k.Trim()
      $v = $v.Trim()
      if ($k) { Set-Item -Path "Env:$k" -Value $v }
    }
  }
}

# 필수 환경변수 체크 (키를 파일에 박지 말고 환경변수로 받음)
$required = @("AWS_ACCESS_KEY_ID","AWS_SECRET_ACCESS_KEY","R2_ACCOUNT_ID","R2_BUCKET")
$missing = @()
foreach ($name in $required) {
  $val = (Get-Item -Path "Env:$name" -ErrorAction SilentlyContinue).Value
  if (-not $val -or $val.Trim().Length -eq 0) {
    $missing += $name
  }
}
if ($missing.Count -gt 0) {
  throw "Missing env vars: $($missing -join ', ')"
}

# PATH가 갱신 안 된 프로세스(예: Obsidian)에서 실행될 때를 대비해 PATH에 AWS CLI 경로 추가
if (-not (Get-Command aws -ErrorAction SilentlyContinue)) {
  $awsDir = Join-Path $env:ProgramFiles "Amazon\AWSCLIV2"
  if (-not (Test-Path (Join-Path $awsDir "aws.exe"))) { throw "AWS CLI not found (PATH or $awsDir)" }
  $env:Path = "$env:Path;$awsDir"
}

$endpoint = "https://$($env:R2_ACCOUNT_ID).r2.cloudflarestorage.com"
$base = $PublicBaseUrl.TrimEnd("/")

# 영상 하나를 R2에 보장: 로컬에 있으면 업로드, 없으면 R2에 이미 있는지 확인
$ready = @{}
function Ensure-Uploaded([string]$fileName) {
  if ($ready.ContainsKey($fileName)) { return $ready[$fileName] }

  $local = Join-Path $VideosDir $fileName
  if (-not (Test-Path -LiteralPath $local)) {
    $found = Get-ChildItem -Path content -Recurse -File -Filter "*.mp4" | Where-Object { $_.Name -eq $fileName } | Select-Object -First 1
    if ($found) { $local = $found.FullName } else { $local = $null }
  }

  if ($local) {
    Write-Host "Uploading: $fileName"
    aws s3 cp $local "s3://$($env:R2_BUCKET)/$Prefix/$fileName" --endpoint-url $endpoint --content-type video/mp4 --only-show-errors
    if ($LASTEXITCODE -ne 0) { throw "Upload failed: $fileName" }
    $ready[$fileName] = $true
  } else {
    # 없으면 aws가 stderr에 404를 쓰므로 이 호출만 Stop을 풀어둔다
    $ErrorActionPreference = "Continue"
    aws s3api head-object --bucket $env:R2_BUCKET --key "$Prefix/$fileName" --endpoint-url $endpoint 2>$null | Out-Null
    $ErrorActionPreference = "Stop"
    $ready[$fileName] = ($LASTEXITCODE -eq 0)
    if (-not $ready[$fileName]) { Write-Warning "Video not found locally or on R2, left as-is: $fileName" }
  }
  return $ready[$fileName]
}

foreach ($path in $targets) {
  $text = [IO.File]::ReadAllText($path, $utf8NoBom)
  $newText = $embedRe.Replace($text, {
    param($m)
    # Obsidian에서 ![[폴더/파일.mp4]] 같이 쓸 수도 있어 방어
    $fileName = ($m.Groups[1].Value.Trim() -split "/")[-1]
    if (-not (Ensure-Uploaded $fileName)) { return $m.Value }
    $url = "$base/$Prefix/$([uri]::EscapeDataString($fileName))"
    # 한 줄로 둬야 HTML 블록이 되지 않아, 바로 아래 줄의 캡션(_..._)이 마크다운으로 렌더링된다
    return "<video controls preload=`"metadata`" style=`"width: 100%;`" playsinline><source src=`"$url`" type=`"video/mp4`" /></video>"
  })

  if ($newText -ne $text) {
    [IO.File]::WriteAllText($path, $newText, $utf8NoBom)
    git add -- $path
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    Write-Host "Converted: $path"
  }
}

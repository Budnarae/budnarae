param(
  [string]$VideosDir = "content/assets/videos",
  [string]$Prefix = "videos"
)

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

$ErrorActionPreference = "Stop"

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

if (-not (Test-Path $VideosDir)) {
  Write-Host "No videos directory: $VideosDir (skip)"
  exit 0
}

$endpoint = "https://$($env:R2_ACCOUNT_ID).r2.cloudflarestorage.com"
$dest = "s3://$($env:R2_BUCKET)/$Prefix"

Write-Host "Syncing: $VideosDir -> $dest"
Write-Host "Endpoint: $endpoint"

aws s3 sync $VideosDir $dest --endpoint-url $endpoint --delete
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Done."
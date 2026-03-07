param(
  [string[]]$Roots = @("content/notes", "content/translation"),
  [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Quote-Yaml([string]$Value) {
  return "'" + ($Value -replace "'", "''") + "'"
}

$modified = 0
$skipped = 0
$fallbackTitleUsed = 0

foreach ($root in $Roots) {
  if (-not (Test-Path -LiteralPath $root)) {
    continue
  }

  $files = Get-ChildItem -LiteralPath $root -Filter *.md -Recurse -File
  foreach ($file in $files) {
    $raw = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ([string]::IsNullOrWhiteSpace($raw)) {
      $skipped++
      continue
    }

    $newline = "`n"
    if ($raw.Contains("`r`n")) {
      $newline = "`r`n"
    }

    $lines = [regex]::Split($raw, "\r?\n")
    $start = $null
    for ($i = 0; $i -lt $lines.Length; $i++) {
      if ($lines[$i].Trim() -ne "") {
        $start = $i
        break
      }
    }

    if ($null -eq $start -or $lines[$start].Trim() -ne "---") {
      $skipped++
      continue
    }

    $end = $null
    for ($i = $start + 1; $i -lt $lines.Length; $i++) {
      if ($lines[$i].Trim() -eq "---") {
        $end = $i
        break
      }
    }

    if ($null -eq $end -or $end -le $start + 1) {
      $skipped++
      continue
    }

    $frontmatter = $lines[($start + 1)..($end - 1)]
    $hasKeyValue = $false
    foreach ($line in $frontmatter) {
      $trimmed = $line.Trim()
      if ($trimmed -eq "" -or $trimmed.StartsWith("#")) {
        continue
      }
      if ($trimmed -match "^[A-Za-z0-9_-]+\s*:") {
        $hasKeyValue = $true
        break
      }
    }

    if ($hasKeyValue) {
      $skipped++
      continue
    }

    $title = $null
    $tags = New-Object System.Collections.Generic.List[string]
    $seenTags = @{}

    foreach ($line in $frontmatter) {
      $trimmed = $line.Trim()
      if ($trimmed -eq "") {
        continue
      }

      $tagMatches = [regex]::Matches($trimmed, "#([^\s#]+)")
      foreach ($match in $tagMatches) {
        $tag = $match.Groups[1].Value.Trim()
        if ($tag -ne "" -and -not $seenTags.ContainsKey($tag)) {
          $seenTags[$tag] = $true
          [void]$tags.Add($tag)
        }
      }

      if ($null -eq $title -and $trimmed -match "^_(.+)_$") {
        $candidate = $Matches[1].Trim()
        if ($candidate -ne "") {
          $title = $candidate
        }
      }
    }

    if ($null -eq $title) {
      foreach ($line in $frontmatter) {
        $trimmed = $line.Trim()
        if ($trimmed -eq "" -or $trimmed.StartsWith("#")) {
          continue
        }
        if ($trimmed -match "^[A-Za-z0-9_-]+\s*:") {
          continue
        }
        $title = $trimmed
        break
      }
    }

    if ($null -eq $title -or $title.Trim() -eq "") {
      $title = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
      $fallbackTitleUsed++
    }

    $newFrontmatter = New-Object System.Collections.Generic.List[string]
    [void]$newFrontmatter.Add("---")
    [void]$newFrontmatter.Add("title: $(Quote-Yaml $title)")
    if ($tags.Count -gt 0) {
      [void]$newFrontmatter.Add("tags:")
      foreach ($tag in $tags) {
        [void]$newFrontmatter.Add("  - $(Quote-Yaml $tag)")
      }
    }
    [void]$newFrontmatter.Add("---")

    $bodyStart = $end + 1
    $bodyLines = @()
    if ($bodyStart -lt $lines.Length) {
      $bodyLines = $lines[$bodyStart..($lines.Length - 1)]
    }

    $newLines = @()
    $newLines += $newFrontmatter
    $newLines += $bodyLines

    $newRaw = [string]::Join($newline, $newLines)
    if ($raw -match "(\r?\n)$") {
      $newRaw += $newline
    }

    if (-not $WhatIf) {
      Set-Content -LiteralPath $file.FullName -Value $newRaw -NoNewline -Encoding UTF8
    }
    $modified++
  }
}

Write-Output "Modified: $modified"
Write-Output "Skipped: $skipped"
Write-Output "FallbackTitleUsed: $fallbackTitleUsed"

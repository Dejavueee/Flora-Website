$htmlFile = "index.html"

if (-not (Test-Path $htmlFile)) {
    Write-Host "index.html missing!"
    exit
}

$content = Get-Content $htmlFile -Raw

# Regex for assets
$pattern = 'href=["''](assets/[^"'']+)["'']|src=["''](assets/[^"'']+)["'']|url\(["'']?(assets/[^"'')]+)["'']?\)'

$matches = [regex]::Matches($content, $pattern, "IgnoreCase")
$seen = @{}
$missing = @()
$foundCount = 0

foreach ($match in $matches) {
    $path = $match.Groups[1].Value
    if (-not $path) { $path = $match.Groups[2].Value }
    if (-not $path) { $path = $match.Groups[3].Value }
    
    if ($path -and -not $seen.ContainsKey($path)) {
        $seen[$path] = $true
        
        # Clean path
        $cleanPath = $path -replace '\?.*$', '' -replace '#.*$', ''
        $localPath = $cleanPath -replace '/', '\'
        
        if (Test-Path $localPath) {
            $foundCount++
        }
        else {
            $missing += $cleanPath
        }
    }
}

Write-Host "Total assets referenced: $($seen.Count)"
Write-Host "Found locally: $foundCount"
Write-Host "Missing: $($missing.Count)"

if ($missing.Count -gt 0) {
    Write-Host "`nMissing Files:"
    $missing | ForEach-Object { Write-Host "- $_" }
}

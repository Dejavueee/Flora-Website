$baseUrl = "https://bracketweb.com/alefox-html/"
$htmlFile = "index.html"

if (-not (Test-Path $htmlFile)) {
    Write-Host "index.html not found!"
    exit
}

$content = Get-Content $htmlFile -Raw

# Regex to find href="assets/..." src="assets/..." url("assets/...")
# We use case-insensitive matching
$pattern = 'href=["''](assets/[^"'']+)["'']|src=["''](assets/[^"'']+)["'']|url\(["'']?(assets/[^"'')]+)["'']?\)'

$matches = [regex]::Matches($content, $pattern, "IgnoreCase")
$assets = @{}

foreach ($match in $matches) {
    # Extract the captured group (non-empty one)
    $path = $match.Groups[1].Value
    if (-not $path) { $path = $match.Groups[2].Value }
    if (-not $path) { $path = $match.Groups[3].Value }
    
    if ($path) {
        $assets[$path] = $true
    }
}

Write-Host "Found $($assets.Count) unique assets."

foreach ($path in $assets.Keys) {
    # Remove query string for local file system
    $cleanPath = $path -replace '\?.*$', '' -replace '#.*$', ''
    # Fix slashes for Windows
    $localPath = $cleanPath -replace '/', '\'
    
    # Create directory if needed
    $dir = Split-Path -Parent $localPath
    if ($dir -and -not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    
    $fullUrl = $baseUrl + $path
    if (-not (Test-Path $localPath)) {
        Write-Host "Downloading $path to $localPath..."
        try {
            Invoke-WebRequest -Uri $fullUrl -OutFile $localPath -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -ErrorAction Stop
        } catch {
            Write-Host "Failed to download $path : $_"
        }
    } else {
        Write-Host "Skipping $path (exists)"
    }
}

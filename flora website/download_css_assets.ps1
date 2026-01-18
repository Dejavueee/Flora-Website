$baseUrl = "https://bracketweb.com/alefox-html/"
$root = Get-Location

$cssFiles = Get-ChildItem -Path "assets" -Recurse -Filter *.css

foreach ($file in $cssFiles) {
    Write-Host "Scanning $($file.Name)..."
    $content = Get-Content $file.FullName -Raw
    
    # Pattern for url(...)
    # matches url('...') or url("...") or url(...)
    $matches = [regex]::Matches($content, 'url\(\s*["'']?([^"''\)]+)["'']?\s*\)')
    
    foreach ($match in $matches) {
        $url = $match.Groups[1].Value.Trim()
        
        # skip data: and http:
        if ($url -match '^data:' -or $url -match '^http') { continue }
        
        # Clean URL for filename (remove ?#)
        $cleanUrl = $url -replace '\?.*$', '' -replace '#.*$', ''
        
        # Calculate web URL
        # We need the path of the CSS file relative to web root
        # css path relative to local root: e.g. assets\css\style.css
        $relPath = $file.FullName.Substring($root.Path.Length + 1).Replace('\', '/')
        $cssWebDir = $relPath.Substring(0, $relPath.LastIndexOf('/'))
        
        # Base URL for this CSS file
        try {
            $cssBaseUri = New-Object System.Uri($baseUrl + $cssWebDir + "/")
            $assetUri = New-Object System.Uri($cssBaseUri, $url)
            $downloadUrl = $assetUri.AbsoluteUri
            
            # Local Path calculation
            # We resolve $cleanUrl relative to $file.DirectoryName
            $assetLocalPath = Join-Path $file.DirectoryName $cleanUrl
            $assetLocalPath = [System.IO.Path]::GetFullPath($assetLocalPath)
            
            if (-not (Test-Path $assetLocalPath)) {
                Write-Host "Downloading $url..."
                
                $destDir = Split-Path -Parent $assetLocalPath
                if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
                
                try {
                    Invoke-WebRequest -Uri $downloadUrl -OutFile $assetLocalPath -UserAgent "Mozilla/5.0" -ErrorAction Stop
                }
                catch {
                    Write-Host "Failed: $_"
                }
            }
        }
        catch {
            Write-Host ("Error processing " + $url + ": " + $_)
        }
    }
}

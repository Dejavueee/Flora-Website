
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter *.html -Recurse

# List of URLs to update
$socialUrls = @(
    "https://www.facebook.com/profile.php?id=61582152146037",
    "https://www.linkedin.com/in/flora-solars-47a7a2392/",
    "https://x.com/FloraSolars",
    "https://www.instagram.com/florasolarandtech/",
    "https://www.youtube.com/@FloraSolarandTech",
    "https://www.tiktok.com/@florasolarandtech"
)

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $modified = $false

    foreach ($url in $socialUrls) {
        # Check if the URL exists in the content
        if ($content -match [regex]::Escape($url)) {
            
            # Helper to replace href="URL" with href="URL" target="_blank"... 
            # while avoiding double-adding if it's already there.
            
            # We look for the URL inside an href attribute.
            $escapedUrl = [regex]::Escape($url)
            
            # Pattern: href="URL"(?![^>]*target="_blank")
            # This is a bit complex for regex lookahead in all cases, simpler to just replace explicit string
            # if we are confident in the current state (which we are, we just set it).
            
            # Simple Replace strategy:
            # 1. Replace 'href="URL" target="_blank"' with 'href="URL"' (normalize/undo to be safe)
            # 2. Replace 'href="URL"' with 'href="URL" target="_blank" rel="noopener noreferrer"'
            
            # Step 1: Normalize (Remove potentially existing target to avoid duplication)
            # Safe clean up incase I ran it halfway.
            # However, simpler is just to replace 'href="URL"' -> 'href="URL" target="_blank"...' 
            # BUT only if it doesn't already have target="_blank".
            
            if ($content -notmatch "href=""$escapedUrl"" target=""_blank""") {
                $content = $content -replace "href=""$escapedUrl""", "href=""$url"" target=""_blank"" rel=""noopener noreferrer"""
                $modified = $true
            }
        }
    }

    if ($modified) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}

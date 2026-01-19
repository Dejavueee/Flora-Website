
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter *.html -Recurse

# Gas Social Media Links
$links = @{
    "sc-fb" = "https://www.facebook.com/profile.php?id=61583505607155"
    "sc-tw" = "https://x.com/Flora_Gas"
    "sc-ig" = "https://www.instagram.com/floragaszw/"
    "sc-li" = "https://www.threads.com/@floragaszw"
    "sc-tt" = "https://www.tiktok.com/@floragas"
    "sc-yt" = "https://www.youtube.com/@FloraGaszw"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Target the gas-social block
    $pattern = '(<div class="footer-widget__social gas-social[^>]*>)([\s\S]*?)(<\/div>)'
    
    if ($content -match $pattern) {
        $updatedContent = [regex]::Replace($content, $pattern, {
                param($match)
                $header = $match.Groups[1].Value
                $innerHtml = $match.Groups[2].Value
                $footer = $match.Groups[3].Value
            
                $tempHtml = $innerHtml
                foreach ($key in $links.Keys) {
                    $url = $links[$key]
                    # Regex to replace href="#" or existing href with new URL AND add target="_blank"
                    # We expect formatting roughly like: <a href="#" class="sc-fb">
                
                    # Replace href="#" with new URL
                    # Note: We also need to handle if it already has target="_blank" (unlikely for original, but good practice)
                    # But since we are replacing the specific class, we can just rebuild the tag attributes.
                
                    # Simple approach: 
                    # 1. Update href
                    $tempHtml = $tempHtml -replace "href=""#"" class=""$key""", "href=""$url"" class=""$key"""
                    $tempHtml = $tempHtml -replace "class=""$key"" href=""#""", "class=""$key"" href=""$url"""
                
                    # 2. Add target="_blank" if not present
                    # Use a specific regex for the tag containing this url
                    $escapedUrl = [regex]::Escape($url)
                    if ($tempHtml -notmatch "href=""$escapedUrl""[^>]*target=""_blank""") {
                        $tempHtml = $tempHtml -replace "href=""$escapedUrl""", "href=""$url"" target=""_blank"" rel=""noopener noreferrer"""
                    }
                }
            
                return $header + $tempHtml + $footer
            })
        
        Set-Content -Path $file.FullName -Value $updatedContent
        Write-Host "Updated $($file.Name)"
    }
}

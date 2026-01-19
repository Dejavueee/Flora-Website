
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter *.html -Recurse

# Social Media Links
$links = @{
    "sc-fb" = "https://www.facebook.com/profile.php?id=61582152146037"
    "sc-li" = "https://www.linkedin.com/in/flora-solars-47a7a2392/"
    "sc-tw" = "https://x.com/FloraSolars"
    "sc-ig" = "https://www.instagram.com/florasolarandtech/"
    "sc-yt" = "https://www.youtube.com/@FloraSolarandTech"
    "sc-tt" = "https://www.tiktok.com/@florasolarandtech"
}

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # We need to find the solar-social div block and replace links ONLY inside it.
    # Pattern: <div class="footer-widget__social solar-social... to </div>
    # Using regex to capture the block is safer than line-by-line if formatted inconsistently,
    # but we can rely on the specific class name to locate the start.

    # Regex to find the block:
    # <div class="footer-widget__social solar-social[^>]*>([\s\S]*?)<\/div>
    
    $pattern = '(<div class="footer-widget__social solar-social[^>]*>)([\s\S]*?)(<\/div>)'
    
    if ($content -match $pattern) {
        $updatedContent = [regex]::Replace($content, $pattern, {
                param($match)
                $header = $match.Groups[1].Value
                $innerHtml = $match.Groups[2].Value
                $footer = $match.Groups[3].Value
            
                # Now replace the hrefs inside the innerHtml
                foreach ($key in $links.Keys) {
                    # Look for <a href="#" class="sc-fb"> or variations
                    # The class might be anywhere in the tag, but usually it's href="#" class="sc-fb" based on view_file
                    # We'll use regex to target the specific class and update its href
                
                    # Regex logic: find <a ... class="...sc-fb..." ... href="#" ... > or <a ... href="#" ... class="...sc-fb..." ...>
                    # Simpler: just replace href="#" with href="URL" if the tag contains the class
                
                    # Let's split by </a> to handle multiple tags
                    $tags = $innerHtml -split '</a>'
                    $newInnerHtml = ""
                
                    foreach ($tagPart in $tags) {
                        if ($tagPart.Trim().Length -gt 0) {
                            $tagPart = $tagPart + "</a>" # Add back the delimiter
                         
                            if ($tagPart -match $key) {
                                $url = $links[$key]
                                $tagPart = $tagPart -replace 'href="#"', "href=""$url"""
                            }
                            $newInnerHtml += $tagPart
                        }
                    }
                
                    # Update innerHtml for the next iteration of keys? 
                    # Be careful, splitting and rebuilding might mess up if whitespace is tricky.
                    # A better way: Replace directly on the string for each key.
                }
            
                # Re-do inner loop properly
                $tempHtml = $innerHtml
                foreach ($key in $links.Keys) {
                    $url = $links[$key]
                    # Regex to find the anchor tag with the specific class and replace its href
                    # This regex looks for <a [anything] class="[anything]key[anything]" [anything] href="#" [anything]>
                    # And also <a [anything] href="#" [anything] class="[anything]key[anything]" [anything]>
                
                    # Given the consistency: <a href="#" class="sc-fb">
                    # We can be specific.
                
                    $tempHtml = $tempHtml -replace "href=""#"" class=""$key""", "href=""$url"" class=""$key"""
                    $tempHtml = $tempHtml -replace "class=""$key"" href=""#""", "class=""$key"" href=""$url"""
                }
            
                return $header + $tempHtml + $footer
            })
        
        Set-Content -Path $file.FullName -Value $updatedContent
        Write-Host "Updated $($file.Name)"
    }
}

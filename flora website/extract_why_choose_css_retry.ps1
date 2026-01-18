$cssPath = "assets/css/soilux-custom.css"
$content = Get-Content -Raw $cssPath

# Regex pattern based on the grep results
# Start: /***     07. Why Choose Us css    ***/
# End: /***     08. Intro Video css    ***/
# Note spacing might be variable.

if ($content -match '(?s)(/\*+\s*/\*\*\*\s+07\. Why Choose Us css\s+\*\*\*/(\s|.)*?)(/\*+\s*/\*\*\*\s+08\. Intro Video css\s+\*\*\*/)') {
    $whyChooseCss = $matches[1]
    Set-Content -Path "assets/css/why_choose_us_snippet.css" -Value $whyChooseCss -Encoding UTF8
    Write-Host "Extracted Why Choose Us CSS (Section 07)."
}
else {
    # Try alternate spacing or without number? The grep showed it clearly.
    # Maybe header is "08. Intro Video css"
    Write-Host "Regex failed. Dumping context around '07. Why Choose Us css'"
    $idx = $content.IndexOf("07. Why Choose Us css")
    if ($idx -ge 0) {
        Write-Host $content.Substring($idx - 20, 100)
    }
    exit 1
}

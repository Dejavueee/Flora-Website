$cssPath = "assets/css/soilux-custom.css"
$content = Get-Content -Raw $cssPath

# Regex pattern - looking for the BLOCK not the index
# Start: /***     07. Why Choose Us css    ***/
# The index 1419 from grep confirms it exists.
# Pattern: \/\*\*\*+\s+07\. Why Choose Us css\s+\*\*\*\/

$startPattern = '\/\*\*\*+\s+07\. Why Choose Us css\s+\*\*\*\/'
$endPattern = '\/\*\*\*+\s+08\. Intro Video css\s+\*\*\*\/'

if ($content -match "(?s)($startPattern.*?)$endPattern") {
    $whyChooseCss = $matches[1]
    Set-Content -Path "assets/css/why_choose_us_snippet.css" -Value $whyChooseCss -Encoding UTF8
    Write-Host "Extracted Why Choose Us CSS."
}
else {
    Write-Error "Could not match CSS block."
    exit 1
}

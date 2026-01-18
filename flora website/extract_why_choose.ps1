$content = Get-Content "soilux_reference.html" -Raw

# Pattern: <!-- Why Choose Us Section Start --> ... <!-- Why Choose Us Section End -->
if ($content -match '(?s)(<!-- Why Choose Us Section Start -->.*?<!-- Why Choose Us Section End -->)') {
    $sectionHtml = $matches[1]
    
    # Fix image paths
    $sectionHtml = $sectionHtml -replace 'src="images/', 'src="assets/images/soilux/'
    
    # Save to file
    Set-Content -Path "why_choose_us_snippet.html" -Value $sectionHtml -Encoding UTF8
    Write-Host "Extracted Why Choose Us section."
}
else {
    Write-Error "Could not find Why Choose Us section in soilux_reference.html"
    exit 1
}

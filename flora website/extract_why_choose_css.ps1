$cssPath = "assets/css/soilux-custom.css"
$content = Get-Content -Raw $cssPath

# Matches: /**** 		 07. Why Choose Us css	      ****/ .... /**** 		 08. Intro Video css	      ****/
# or similar
# Based on index 2511-2533 in Step 463? No. Step 463 only showed Header/Footer indexes.
# Need to find the exact comment.
# I will use a regex to capture between section 07 and 08.

if ($content -match '(?s)(/\*+\s*/\*\*\*\s+07\. Why Choose Us css\s+\*\*\*/(\s|.)*?)(/\*+\s*/\*\*\*\s+08\. Intro Video css\s+\*\*\*/)') {
    $whyChooseCss = $matches[1]
    
    # Also grab tab/nav styles if they are separate?
    # Usually they are in "Why Choose Us css" if specific to that section.
    # But if standard Bootstrap nav-tabs are customized globally, they might be in General.
    # However, the user said "clone ... exactly as it is".
    
    # Save to file
    Set-Content -Path "assets/css/why_choose_us_snippet.css" -Value $whyChooseCss -Encoding UTF8
    Write-Host "Extracted Why Choose Us CSS."
}
else {
    Write-Error "Could not find Why Choose Us CSS section."
    exit 1
}

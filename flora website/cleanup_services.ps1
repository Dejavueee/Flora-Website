
$files_to_update = @(
    "service-details.html",
    "service-commercial.html",
    "service-equipment.html",
    "service-gas-refill.html",
    "service-bulk-gas.html",
    "service-cylinders.html",
    "service-maintenance.html",
    "service-delivery.html"
)

$base_dir = "c:/Users/Lenovo/Desktop/flora website/alefox-clone-index-2"

# Widget start and end markers to help locating it even if whitespace differs slightly
# We simply look for the content line by line or use a block replace if exact match works.
# Since Powershell matching multiline string can be tricky with formatting, 
# we will try to match the characteristic parts.

foreach ($fname in $files_to_update) {
    $fpath = Join-Path $base_dir $fname
    if (-not (Test-Path $fpath)) {
        Write-Host "Skipping $fname (not found)"
        continue
    }

    $content = Get-Content -Path $fpath -Raw
    $original_content = $content

    # 1. Remove Widget
    # We construct a regex that matches the widget block
    # Note: escape special chars
    $widget_regex = '(?ms)\s*<!-- Download Brochure Widget -->\s*<div class="service-details__download.*?Download PDF <i class="fas fa-download ms-2"></i></a>\s*</div>'
    
    if ($content -match $widget_regex) {
        $content = $content -replace $widget_regex, ""
        Write-Host "Removed widget from $fname"
    }
    else {
        Write-Host "Widget not found in $fname"
    }

    # 2. Fix extra div
    # Pattern: </div> whitespace </div> whitespace </div> whitespace <div class="col-xl-8
    # We want to replace it with 2 closing divs
    
    # (?ms) enables multiline mode
    $extra_div_pattern = '(?ms)(</div>\s*</div>)\s*</div>(\s*<div class="col-xl-8)'
    
    if ($content -match $extra_div_pattern) {
        $content = $content -replace $extra_div_pattern, '$1$2'
        Write-Host "Fixed extra div in $fname"
    }
    else {
        Write-Host "No extra div pattern found in $fname"
    }

    if ($content -ne $original_content) {
        $content | Set-Content -Path $fpath -NoNewline
        Write-Host "Saved $fname"
    }
    else {
        Write-Host "No changes for $fname"
    }
}


$files_to_update = @(
    "service-details.html",
    "service-commercial.html",
    "service-equipment.html",
    "service-gas-refill.html",
    "service-bulk-gas.html",
    "service-cylinders.html",
    "service-maintenance.html",
    "service-delivery.html",
    "service-gas-installation.html"
)

$base_dir = "c:/Users/Lenovo/Desktop/flora website/alefox-clone-index-2"

$widget_html = '
                            <!-- Download Brochure Widget -->
                            <div class="service-details__download wow fadeInUp" data-wow-delay="0.3s">
                                <div class="service-details__download-icon">
                                    <i class="fas fa-file-pdf"></i>
                                </div>
                                <h3 class="service-details__download-title">Company Profile</h3>
                                <p class="service-details__download-text">Download our latest company brochure to learn more about our services.</p>
                                <a href="assets/downloads/flora-profile.pdf" class="service-details__download-btn" download>Download PDF <i class="fas fa-download ms-2"></i></a>
                            </div>'

# We are looking for the closing sequence of the sidebar to insert *before* it closes.
# The structure is:
#   </div> (closes need-help-wrapper)
# </div> (closes sidebar)
# </div> (closes col-4)
# <div class="col-xl-8 ... (starts main content)

# We want to insert between the first and second </div> in that sequence.
# BUT, we need to be careful about whitespace.

foreach ($fname in $files_to_update) {
    $fpath = Join-Path $base_dir $fname
    if (-not (Test-Path $fpath)) {
        Write-Host "Skipping $fname (not found)"
        continue
    }

    $content = Get-Content -Path $fpath -Raw
    
    # Check if widget already exists to avoid duplication
    if ($content -match "Download Brochure Widget") {
        Write-Host "Widget already exists in $fname, skipping."
        continue
    }

    # Regex search for the boundary.
    # We look for: </div> [whitespace] </div> [whitespace] </div> [whitespace] <div class="col-xl-8
    # We capture the first </div> (closing need help) as group 1.
    # We capture the rest (closing sidebar + closing col + opening next col) as group 2.
    
    $pattern = '(?ms)(</div>\s*?)(</div>\s*?</div>\s*?<div class="col-xl-8)'
    
    if ($content -match $pattern) {
        # We replace with: $1 + widget + $2
        $content = $content -replace $pattern, ('$1' + $widget_html + '$2')
        $content | Set-Content -Path $fpath -NoNewline
        Write-Host "Success: Added widget to $fname"
    }
    else {
        Write-Host "Error: Could not find insertion point in $fname"
        # Debug: check what the end looks like
        # $content | Select-String "col-xl-8" -Context 3,0
    }
}

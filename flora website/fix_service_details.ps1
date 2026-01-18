
$path = "c:/Users/Lenovo/Desktop/flora website/alefox-clone-index-2/service-details.html"
$content = Get-Content -Path $path -Raw

# We look for the specific indentation and context
$target = '                        </div>
                    <div class="col-xl-8 col-lg-7">'

$replacement = '                        </div>
                    </div>
                    <div class="col-xl-8 col-lg-7">'

# Normalize line endings just in case
$content = $content -replace "`r`n", "`n"
$target = $target -replace "`r`n", "`n"
$replacement = $replacement -replace "`r`n", "`n"

if ($content.Contains($target)) {
    $content = $content.Replace($target, $replacement)
    $content | Set-Content -Path $path -NoNewline
    Write-Host "Success: Patched service-details.html"
}
else {
    Write-Host "Error: Target string not found. Checking nearby content..."
    $content | Select-String "col-xl-8" -Context 5, 5
}

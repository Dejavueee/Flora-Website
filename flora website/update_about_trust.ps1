
$file = "c:\Users\Lenovo\Desktop\flora website\flora website\about.html"
$content = Get-Content $file -Raw -Encoding UTF8

# Define the pattern to find
# We match loosely across newlines
$pattern = '(?s)<!-- Comapany Support Content Start -->\s*<div class="company-supports-content">.*?</div>\s*<!-- Comapany Support Content End -->'

# Define the replacement
$replacement = '<!-- Comapany Support Content Start -->
                            <div class="company-supports-content" style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 15px;">
                                <p style="white-space: nowrap; margin: 0; font-size: 20px; font-weight: 600;">Trusted By More Than 100+ Companies</p>
                                <div class="stars" style="color: #ffc107; font-size: 16px;">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                            <!-- Comapany Support Content End -->'

if ($content -match $pattern) {
    $content = $content -replace $pattern, $replacement
    Set-Content -Path $file -Value $content -Encoding UTF8
    Write-Host "about.html updated successfully."
}
else {
    Write-Host "Pattern not found!"
}

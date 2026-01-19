
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    # Regex to match <a href="#" class="sc-li">...</a> handling multiline content
    $pattern = '<a href="#" class="sc-li">[\s\S]*?</a>'
    $replacement = '<a href="#" class="sc-li"><img src="assets/images/threads-icon.png" alt="Threads" style="width: 14px; height: 14px; filter: brightness(0) invert(1);"></a>'
    
    if ($content -match $pattern) {
        $content = [regex]::Replace($content, $pattern, $replacement)
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}

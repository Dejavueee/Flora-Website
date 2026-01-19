
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter *.html -Recurse

foreach ($file in $files) {
    if ($file.Name -ne "index.html") {
        $content = Get-Content $file.FullName -Raw
        # Regex to match the Threads content
        $pattern = '<a href="#" class="sc-li">[\s\S]*?</a>'
        $replacement = '<a href="#" class="sc-li"><i class="fab fa-linkedin"></i></a>'
        
        if ($content -match 'assets/images/threads-icon.png') {
            $content = [regex]::Replace($content, $pattern, $replacement)
            Set-Content -Path $file.FullName -Value $content
            Write-Host "Reverted $($file.Name)"
        }
    }
}


$files = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding utf8
    $originalContent = $content
    
    # Replace Shop Links directly to products.html with query params
    $content = $content -replace 'href="shop.html"', 'href="products.html?category=solar"'
    $content = $content -replace 'href="shop-gas.html"', 'href="products.html?category=gas"'
    $content = $content -replace 'href="shop-all.html"', 'href="products.html?category=all"'
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding utf8
        Write-Host "Fixed navbar links in $($file.Name)"
    }
}

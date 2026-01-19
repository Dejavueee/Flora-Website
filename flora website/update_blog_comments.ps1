
$files = Get-ChildItem -Path "c:\Users\Lenovo\Desktop\flora website\flora website" -Filter "blog-details*.html" -Recurse

$newImageSrc = "assets/images/testimonials/user-7.png"
$pattern = '(<div class="comments-one__card__image">\s*)<img[^>]*>(\s*</div>)'
$replacement = '${1}<img src="assets/images/testimonials/user-7.png" alt="User Image">${2}'

$styleBlock = @"
<style>
.comments-one__card__image {
    width: 50px !important;
    height: 50px !important;
    min-width: 50px !important;
    margin-right: 15px !important; 
}
.comments-one__card__image img {
    width: 100% !important;
    height: 100% !important;
    border-radius: 50%;
    object-fit: cover;
}
</style>
</head>
"@

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $modified = $false
    
    # 1. Update Image (from previous step, ensuring it runs if not done)
    if ($content -match "comments-one__card__image") {
        $updatedContent = [regex]::Replace($content, $pattern, $replacement)
        
        # 2. Inject CSS if not already present
        if ($updatedContent -notmatch "\.comments-one__card__image \{") {
            if ($updatedContent -match "</head>") {
                $updatedContent = $updatedContent -replace "</head>", $styleBlock
                $modified = $true
                Write-Host "Injected CSS into $($file.Name)"
            }
        }
        
        if ($updatedContent -ne $content) {
            $modified = $true
        }

        if ($modified) {
            Set-Content -Path $file.FullName -Value $updatedContent
            Write-Host "Updated $($file.Name)"
        }
        else {
            Write-Host "Skipped $($file.Name) (No changes needed)"
        }
    }
    else {
        Write-Host "Skipped $($file.Name) (No comments section)"
    }
}

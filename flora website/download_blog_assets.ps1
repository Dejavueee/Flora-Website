
$baseUrl = "https://bracketweb.com/alefox-html/assets/images/blog/"
$targetDir = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\images\blog"
$images = @(
    "blog-1-1.jpg",
    "blog-1-2.jpg",
    "blog-1-3.jpg",
    "blog-1-4.jpg",
    "blog-1-5.jpg",
    "blog-1-6.jpg",
    "blog-details-1-1.jpg",
    "lp-1-1.jpg",
    "lp-1-2.jpg",
    "lp-1-3.jpg"
)

# Ensure directory exists
if (-not (Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

foreach ($img in $images) {
    $url = "$baseUrl$img"
    $output = Join-Path -Path $targetDir -ChildPath $img
    Write-Host "Downloading $img..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $output
        Write-Host "Downloaded $img"
    }
    catch {
        Write-Error "Failed to download $img : $_"
    }
}

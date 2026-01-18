$baseUrl = "https://templates.themekit.dev/execoore/media"
$destDir = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\images\testimonials"
New-Item -ItemType Directory -Force -Path $destDir

$images = @("user-1.jpg", "user-5.jpg", "user-3.jpg", "user-4.jpg")

foreach ($img in $images) {
    try {
        Invoke-WebRequest -Uri "$baseUrl/$img" -OutFile "$destDir\$img"
        Write-Host "Downloaded $img"
    }
    catch {
        Write-Error "Failed to download $img"
    }
}

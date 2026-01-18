
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# 1. Remove the old absolute header
$content = $content -replace '<div class="testimonials-one__header-static">Testimonials</div>', ''

# 2. Add it inside the Right Panel (at the top)
# Find <div class="testimonials-one__right-panel">
# Change to <div class="testimonials-one__right-panel"><div class="testimonials-one__header-static">Testimonials</div>
$content = $content -replace '<div class="testimonials-one__right-panel">', '<div class="testimonials-one__right-panel"><div class="testimonials-one__header-static">Testimonials</div>'

# 3. Update CSS to be relative/static instead of absolute
# We will do this in the next step via Add-Content or we can rely on CSS cascade if we append new rules.

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Moved Testimonials Heading inside Right Panel."

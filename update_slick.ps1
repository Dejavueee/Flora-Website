
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Update Thumb Options
# Pattern: data-slick-options='{...}' on ul.testimonials-one__carousel-thumb
# We want to change it to have autoplaySpeed: 10000
$thumbOptionsOldPattern = '(?s)<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''.*?'''
$thumbOptionsNew = '<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''{
				"slidesToShow": 3,
				"slidesToScroll": 1,
				"autoplay": true,
				"autoplaySpeed": 10000,
				"speed": 1000,
				"centerMode": true,
				"asNavFor": ".testimonials-one__carousel",
				"focusOnSelect": true,
				"vertical": true,
				"verticalSwiping": true,
				"dots": false,
				"centerPadding": 0,
				"arrows": false
				}'''

$content = $content -replace $thumbOptionsOldPattern, $thumbOptionsNew

# Update Main Options
# Pattern: data-slick-options='{...}' on div.testimonials-one__carousel
$mainOptionsOldPattern = '(?s)<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''.*?'''
$mainOptionsNew = '<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''{
				"slidesToShow": 1,
				"slidesToScroll": 1,
				"autoplay": true,
				"autoplaySpeed": 10000,
				"speed": 1000,
				"fade": true,
				"asNavFor": ".testimonials-one__carousel-thumb",
				"dots": false,
				"centerPadding": 0,
				"arrows": false
				}'''

$content = $content -replace $mainOptionsOldPattern, $mainOptionsNew

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Updated slick options for smooth 10s transition."

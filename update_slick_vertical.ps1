
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Update Thumb Options (Left List)
# Change speed to 1000 (faster/crisper).
# Maintain centerMode: false.
$thumbOptionsOldPattern = '(?s)<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''.*?'''
$thumbOptionsNew = '<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 3, 
                            "slidesToScroll": 1,
                            "asNavFor": ".testimonials-one__carousel",
                            "focusOnSelect": true,
                            "vertical": true,
                            "verticalSwiping": true,
                            "arrows": false,
                            "dots": false,
                            "centerMode": false,
                            "infinite": true,
                            "autoplay": true,
                            "autoplaySpeed": 5000, 
                            "speed": 1000,
                            "cssEase": "cubic-bezier(0.645, 0.045, 0.355, 1)"
                        }'''
# Updated speed to 1000.

$content = $content -replace $thumbOptionsOldPattern, $thumbOptionsNew

# Update Main Options (Right Content)
# CHANGE FADE TO FALSE (SOLVE GHOSTING)
# SYNC VERTICAL SCROLL
$mainOptionsOldPattern = '(?s)<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''.*?'''
$mainOptionsNew = '<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 1,
                            "slidesToScroll": 1,
                            "arrows": false,
                            "dots": false,
                            "fade": false,
                            "vertical": true,
                            "verticalSwiping": true,
                            "asNavFor": ".testimonials-one__carousel-thumb",
                            "autoplay": true,
                            "autoplaySpeed": 5000,
                            "speed": 1000,
                            "cssEase": "cubic-bezier(0.645, 0.045, 0.355, 1)",
                            "infinite": true
                        }'''

$content = $content -replace $mainOptionsOldPattern, $mainOptionsNew

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Updated Slick: Slide Animation (Vertical) & Speed 1000ms."

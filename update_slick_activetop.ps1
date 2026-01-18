
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Old Config Pattern (3 items, infinite) - From previous turn using Update Slick 3Items
# The key is to match the 'data-slick-options' we injected.
# It had "slidesToShow": 3, "centerMode": true...

# We need to find that block and replace "centerMode": true with "centerMode": false
# And maybe adjust autoplaySpeed or verticalSwiping if smooth scroll upward is needed.
# "Names should scroll upward smoothly" -> standard vertical slider does this.

$thumbOptionsOldPattern = '(?s)<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''.*?'''

# New Config (3 items, Active at Top)
# "centerMode": false -> active item is first (top).
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
                            "cssEase": "linear"
                        }'''
# Adjusted autoplaySpeed to 5000 (slower transitions? User said "slow, fluid")
# User previously asked for "transistion interval: every 10 seconds".
# "Animation should be smooth fade or slide...".
# I'll stick to 10000ms but maybe slowing down the 'speed' (transition duration) makes it feel smoother. 
# "All animations must be slow, fluid..." -> speed: 1000 or 1500.

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
                            "autoplaySpeed": 10000, 
                            "speed": 1500,
                            "cssEase": "cubic-bezier(0.645, 0.045, 0.355, 1)"
                        }'''
# Using cubic-bezier for "professional" fluid feel instead of linear.

$content = $content -replace $thumbOptionsOldPattern, $thumbOptionsNew

# Also update Main Carousel to match speed
$mainOptionsOldPattern = '(?s)<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''.*?'''
$mainOptionsNew = '<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 1,
                            "slidesToScroll": 1,
                            "arrows": false,
                            "dots": false,
                            "fade": true,
                            "asNavFor": ".testimonials-one__carousel-thumb",
                            "autoplay": true,
                            "autoplaySpeed": 10000,
                            "speed": 1500,
                            "cssEase": "linear",
                            "infinite": true
                        }'''

$content = $content -replace $mainOptionsOldPattern, $mainOptionsNew

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Updated Slick Options: Active Top, 3 Items, Fluid Speed."

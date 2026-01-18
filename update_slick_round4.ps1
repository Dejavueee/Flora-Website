
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# 1. Update Left List (Left Column)
# Requirement: "Does NOT scroll independently", "Active name reflects currently visible".
# We keep it as a slider for sync, but disable interactions.
# Keep 3 items visible.
$thumbOptionsOldPattern = '(?s)<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''.*?'''
$thumbOptionsNew = '<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 3, 
                            "slidesToScroll": 1,
                            "asNavFor": ".testimonials-one__carousel",
                            "focusOnSelect": true, 
                            "vertical": true,
                            "verticalSwiping": false, 
                            "draggable": false,
                            "swipe": false,
                            "arrows": false,
                            "dots": false,
                            "centerMode": false,
                            "infinite": true
                        }'''
# removed autoplay from thumb, let main drive it? Or both? Usually main drives.

$content = $content -replace $thumbOptionsOldPattern, $thumbOptionsNew

# 2. Update Main Content (Right Column)
# Requirement: "Single-testimonial viewport", "Transitions vertically (Slide)".
# "transitions vertically" -> vertical: true.
# "Single viewport" -> slidesToShow: 1.
$mainOptionsOldPattern = '(?s)<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''.*?'''
$mainOptionsNew = '<div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 1,
                            "slidesToScroll": 1,
                            "arrows": false,
                            "dots": false,
                            "fade": false, 
                            "vertical": true,
                            "verticalSwiping": false,
                            "asNavFor": ".testimonials-one__carousel-thumb",
                            "autoplay": true,
                            "autoplaySpeed": 5000,
                            "speed": 1000,
                            "cssEase": "cubic-bezier(0.645, 0.045, 0.355, 1)",
                            "infinite": true
                        }'''
# fade: false + vertical: true = Vertical Slide.

$content = $content -replace $mainOptionsOldPattern, $mainOptionsNew

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Updated Slick: Left Fixed-Feel, Right Vertical Single Slide."


$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Old Config Pattern (6 items)
$thumbOptionsOldPattern = '(?s)<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''.*?'''

# New Config (3 items, infinite)
$thumbOptionsNew = '<ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options=''{
                            "slidesToShow": 3, 
                            "slidesToScroll": 1,
                            "asNavFor": ".testimonials-one__carousel",
                            "focusOnSelect": true,
                            "vertical": true,
                            "arrows": false,
                            "dots": false,
                            "centerMode": true,
                            "centerPadding": "0",
                            "infinite": true,
                            "autoplay": true,
                            "autoplaySpeed": 10000,
                            "speed": 1000,
                            "cssEase": "linear"
                        }'''

$content = $content -replace $thumbOptionsOldPattern, $thumbOptionsNew

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Updated Testimonial Thumbnails to 3 visible items with infinite loop."

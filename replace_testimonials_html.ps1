
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# Start and End markers for the Testimonials section
# We will replace the whole <section class="testimonials-one"> ... </section>
# But we need to keep the "Promo" section intact.

# Define the new HTML Structure matching Flowbite
# Left Side: List of items (Img + Name + Role)
# Right Side: Quote
# Note: Slick Slider 'dots' or 'customPaging' can be used, but since we have a separate UL acting as nav, we'll stick to that but enrich the content.

$newTestimonialsHTML = @"
        <section class="testimonials-one">
            <div class="container">
                <div class="testimonials-one__wrapper">
                    
                    <!-- Left Side: Author List (Navigation) -->
                    <div class="testimonials-one__left-panel">
                        <ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options='{
                            "slidesToShow": 5, 
                            "slidesToScroll": 1,
                            "asNavFor": ".testimonials-one__carousel",
                            "focusOnSelect": true,
                            "vertical": true,
                            "arrows": false,
                            "dots": false,
                            "centerMode": false,
                            "infinite": true
                        }'>
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-1.jpg" alt="Joseph">
                                    <div class="testi-author-info">
                                        <h5>Joseph Kennedy</h5>
                                        <span>Founder</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-2.jpg" alt="Mike">
                                    <div class="testi-author-info">
                                        <h5>Mike Hardson</h5>
                                        <span>Manager</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-3.jpg" alt="Steve">
                                    <div class="testi-author-info">
                                        <h5>Steve Smith</h5>
                                        <span>Reviewer</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-4.jpg" alt="Jerome">
                                    <div class="testi-author-info">
                                        <h5>Jerome Taylor</h5>
                                        <span>Developer</span>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-5.jpg" alt="Mark">
                                    <div class="testi-author-info">
                                        <h5>Mark Wood</h5>
                                        <span>Customer</span>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <!-- Right Side: Main Content (Quote) -->
                    <div class="testimonials-one__right-panel">
                        <div class="testimonials-one__carousel alefox-slick__carousel" data-slick-options='{
                            "slidesToShow": 1,
                            "slidesToScroll": 1,
                            "arrows": false,
                            "dots": false,
                            "fade": true,
                            "asNavFor": ".testimonials-one__carousel-thumb",
                            "autoplay": true,
                            "autoplaySpeed": 10000,
                            "speed": 1000,
                            "infinite": true
                        }'>
                            <!-- Item 1 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__item__icon"><i class="fas fa-quote-left"></i></div>
                                    <h3 class="testimonials-one__item__title">Exceptional Quality</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Continued at up to zealously necessary we retar this surrounded sir motionless of this she end literature. Gay direction this food neglected but supported sociable not pretended."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 2 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__item__icon"><i class="fas fa-quote-left"></i></div>
                                    <h3 class="testimonials-one__item__title">Great Experience</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Continued at up to zealously necessary we retar this surrounded sir motionless of this she end literature. Gay direction this food neglected but supported sociable not pretended."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 3 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__item__icon"><i class="fas fa-quote-left"></i></div>
                                    <h3 class="testimonials-one__item__title">Highly Recommended</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Continued at up to zealously necessary we retar this surrounded sir motionless of this she end literature. Gay direction this food neglected but supported sociable not pretended."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 4 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__item__icon"><i class="fas fa-quote-left"></i></div>
                                    <h3 class="testimonials-one__item__title">Professional Team</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Continued at up to zealously necessary we retar this surrounded sir motionless of this she end literature. Gay direction this food neglected but supported sociable not pretended."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 5 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__item__icon"><i class="fas fa-quote-left"></i></div>
                                    <h3 class="testimonials-one__item__title">Best Service</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Continued at up to zealously necessary we retar this surrounded sir motionless of this she end literature. Gay direction this food neglected but supported sociable not pretended."
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /.container -->
        </section><!-- /.testimonials-one -->
"@

# Regex replace
$pattern = '(?s)<section class="testimonials-one">.*?</section><!-- /.testimonials-one -->'
$content = $content -replace $pattern, $newTestimonialsHTML

Set-Content $path -Value $content -Encoding UTF8
Write-Host "Replaced Testimonials Layout successfully."

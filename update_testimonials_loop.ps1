
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# New HTML Structure for Testimonials
# - Header: absolute positioned or flex item? "Static" -> inside container but clearly separated.
# - 6 Items in list and carousel.
# - Name above content.
# - Quote icon.

$newTestimonialsHTML = @"
        <section class="testimonials-one">
            <div class="testimonials-one__header-static">Testimonials</div>
            <div class="container">
                <div class="testimonials-one__wrapper">
                    
                    <!-- Left Side: Author List (Navigation) -->
                    <div class="testimonials-one__left-panel">
                        <ul class="testimonials-one__carousel-thumb alefox-slick__carousel" data-slick-options='{
                            "slidesToShow": 6, 
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
                            <li>
                                <div class="testi-author-card">
                                    <img src="assets/images/resources/testi-1-1.jpg" alt="Sarah">
                                    <div class="testi-author-info">
                                        <h5>Sarah Jenkins</h5>
                                        <span>Designer</span>
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
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Joseph Kennedy</h3>
                                    <div class="testimonials-one__item__quote">
                                        "This service exceeded my expectations and delivered outstanding results. The team was professional, efficient, and a pleasure to work with from start to finish."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 2 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Mike Hardson</h3>
                                    <div class="testimonials-one__item__quote">
                                        "I was blown away by the quality of the work. They truly understood my vision and brought it to life in ways I hadn't even imagined. Highly recommended!"
                                    </div>
                                </div>
                            </div>
                            <!-- Item 3 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Steve Smith</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Professionalism at its finest. The attention to detail was impeccable, and the final product was delivered on time and within budget."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 4 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Jerome Taylor</h3>
                                    <div class="testimonials-one__item__quote">
                                        "A fantastic experience! Their expertise and dedication are evident in every aspect of their work. I will definitely be using their services again."
                                    </div>
                                </div>
                            </div>
                            <!-- Item 5 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Mark Wood</h3>
                                    <div class="testimonials-one__item__quote">
                                        "The customer service was exceptional. They were always available to answer my questions and ensure I was completely satisfied with the outcome."
                                    </div>
                                </div>
                            </div>
                             <!-- Item 6 -->
                            <div class="item">
                                <div class="testimonials-one__item__content">
                                    <div class="testimonials-one__quote-icon"><i class="fas fa-quote-right"></i></div>
                                    <h3 class="testimonials-one__item__name-display">Sarah Jenkins</h3>
                                    <div class="testimonials-one__item__quote">
                                        "Creativity and technical skill combined perfectly. They took my vague ideas and turned them into something truly spectacular."
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
Write-Host "Updated Testimonials to 6 items, added heading, fixed structure."

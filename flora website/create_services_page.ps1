$templatePath = "service-commercial.html"
$outputPath = "services.html"

$content = Get-Content $templatePath -Raw

# 1. Update Title
$content = $content -replace '<title>Service Details \|\| Flora \|\| Solar & Gas Solutions</title>', '<title>Our Services || Flora || Solar & Gas Solutions</title>'

# 2. Update Header/Hero
$heroSection = @"
        <!--Page Header Start-->
        <section class="page-header">
            <div class="page-header__bg"
                style="background-image: url(assets/images/backgrounds/page-header-bg-1-1.jpg);">
            </div>
            <div class="container">
                <ul class="page-header__breadcrumb list-unstyled">
                    <li><a href="index.html">Home</a></li>
                    <li><span>Our Services</span></li>
                </ul>
                <h2 class="page-header__title">Our Services</h2>
            </div>
        </section>
        <!--Page Header End-->
"@
# Replace existing page header (it might match the one above, but doing it to be sure)
$content = $content -replace '(?s)<!--Page Header Start-->.*?<!--Page Header End-->', $heroSection

# 3. Create Services Grid Content
$servicesGrid = @"
        <!--Services Page Grid Start-->
        <section class="services-page-grid" style="padding: 80px 0; background-color: #f5f7fa;">
            <div class="container">
                <div class="row">
                    <!-- Service 1: Residential Solar -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-solar-panel"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-details.html">Residential Solar</a></h3>
                                <p>Custom hybrid and off-grid solar systems for reliable home energy.</p>
                                <a href="service-details.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 2: Commercial Solutions -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-industry"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-commercial.html">Commercial Solutions</a></h3>
                                <p>Large-scale 3-phase power systems for business continuity.</p>
                                <a href="service-commercial.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 3: Solar Equipment Sales -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-charging-station"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-equipment.html">Solar Equipment Sales</a></h3>
                                <p>Direct sales of Tier-1 inverters, batteries, and panels.</p>
                                <a href="service-equipment.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 4: Rapid Gas Refills -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-burn"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-gas-refill.html">Rapid Gas Refills</a></h3>
                                <p>Instant digital-scale refills for 3kg to 48kg cylinders.</p>
                                <a href="service-gas-refill.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 5: Bulk Gas Supply -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-truck-moving"></i> <!-- fa-tank not standard in 5, using truck-moving or similar -->
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-bulk-gas.html">Bulk Gas Supply</a></h3>
                                <p>Wholesale LPG supply for restaurants, hotels, and industry.</p>
                                <a href="service-bulk-gas.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 6: Cylinders & Accessories -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-fire"></i> <!-- stove -->
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-cylinders.html">Cylinders & Accessories</a></h3>
                                <p>Retail supply of SAZ-approved cylinders, regulators, and hoses.</p>
                                <a href="service-cylinders.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 7: Certified Gas Installation -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-user-hard-hat"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-gas-installation.html">Certified Gas Installation</a></h3>
                                <p>COC-certified installations for stoves, geysers, and heaters.</p>
                                <a href="service-gas-installation.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 8: Maintenance & Repair -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-tools"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-maintenance.html">Maintenance & Repair</a></h3>
                                <p>Technical support, panel cleaning, and system diagnostics.</p>
                                <a href="service-maintenance.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Service 9: Doorstep Delivery -->
                    <div class="col-xl-4 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="service-card-soilux">
                            <div class="service-card-icon">
                                <i class="fas fa-truck"></i>
                            </div>
                            <div class="service-card-content">
                                <h3><a href="service-delivery.html">Doorstep Delivery</a></h3>
                                <p>Safe logistics and transport for gas and solar equipment.</p>
                                <a href="service-delivery.html" class="read-more-btn">Read More <i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        <!--Services Page Grid End-->
"@

# Replace the existing Service Details Section
# Matches <!--Service Details Start--> ... <!--Service Details End-->
$content = $content -replace '(?s)<!--Service Details Start-->.*?<!--Service Details End-->', $servicesGrid

# 4. Ensure sidebar/extras from old file are removed if they existed in the regex block (they did)

Set-Content -Path $outputPath -Value $content -Encoding UTF8
Write-Host "Created services.html"


# Paths
$aboutPage = "about.html"
$servicesPage = "services.html"
$indexPage = "index.html"
$soiluxPage = "soilux_reference.html"

# 1. Get Header from services.html
$servicesContent = Get-Content $servicesPage
$headerEndLine = 0
for ($i = 0; $i -lt $servicesContent.Count; $i++) {
    if ($servicesContent[$i] -like "*<!--Page Header End-->*") {
        $headerEndLine = $i
        break
    }
}
$header = $servicesContent[0..$headerEndLine]

# Modify Header for About Us
$header = $header -replace "Our Services", "About Us"
$header = $header -replace '<li class="active">', '<li>' # Remove active class check
$header = $header -replace '<a href="about.html">About Us</a>', '<li class="active"><a href="about.html">About Us</a></li>'
# Wait, the logic above for active class needs to be precise.
# In services.html:
# <li class="active"><a href="services.html">Services</a></li>
# <li><a href="about.html">About Us</a></li>
# I want:
# <li><a href="services.html">Services</a></li>
# <li class="active"><a href="about.html">About Us</a></li>

# Let's simple string replace for nav
$headerString = $header -join "`n"
$headerString = $headerString.Replace('<li class="active">
                            <a href="services.html">Services</a>
                        </li>', '<li>
                            <a href="services.html">Services</a>
                        </li>')
$headerString = $headerString.Replace('<li>
                            <a href="about.html">About Us</a>
                        </li>', '<li class="active">
                            <a href="about.html">About Us</a>
                        </li>')
$header = $headerString -split "`n"


# 2. Get Footer from services.html
$footerStartLine = 0
for ($i = 0; $i -lt $servicesContent.Count; $i++) {
    if ($servicesContent[$i] -like "*<footer class=*main-footer*") {
        $footerStartLine = $i
        break
    }
}
$footer = $servicesContent[$footerStartLine..($servicesContent.Count - 1)]

# 3. Get About-Two from index.html
$indexContent = Get-Content $indexPage
$aboutStart = 0
$aboutEnd = 0
for ($i = 0; $i -lt $indexContent.Count; $i++) {
    if ($indexContent[$i] -like "*<section class=*about-two*") {
        $aboutStart = $i
    }
    if ($indexContent[$i] -like "*</section>*" -and $i -gt $aboutStart -and $aboutStart -ne 0) {
        $aboutEnd = $i
        break
    }
}
$aboutSection = $indexContent[$aboutStart..$aboutEnd]

# 4. Get How-It-Works (Mission) from soilux_reference.html
$soiluxContent = Get-Content $soiluxPage
$howStart = 0
$howEnd = 0
for ($i = 0; $i -lt $soiluxContent.Count; $i++) {
    if ($soiluxContent[$i] -like "*<div class=*how-it-work*") {
        $howStart = $i
    }
    if ($soiluxContent[$i] -like "*<!-- How It Work Section End -->*") {
        $howEnd = $i
        break
    }
}
$missionSection = $soiluxContent[$howStart..$howEnd]

# Modify Mission Section Content
$missionString = $missionSection -join "`n"
$missionString = $missionString -replace "How It Works", "Our Mission & Values"
$missionString = $missionString -replace "See how we bring fresh, organic goodness straight to you", "Guided by principles that power our success"
$missionString = $missionString -replace "01", "01"
$missionString = $missionString -replace "Soil Assessment & Planning", "Our Mission"
$missionString = $missionString -replace "We analyze the soil.*", "To provide affordable, reliable, and sustainable energy solutions to every home and business in Zimbabwe."
$missionString = $missionString -replace "images/how-it-work-image-1.jpg", "assets/images/resources/process-consultation.png"
$missionString = $missionString -replace "images/how-it-work-image-2.jpg", "assets/images/resources/process-design.png"
$missionString = $missionString -replace "images/how-it-work-image-3.jpg", "assets/images/resources/process-installation.png"
$missionString = $missionString -replace "images/how-it-work-image-4.jpg", "assets/images/resources/process-support.png"

# Update text for other steps
$missionString = $missionString -replace "Seed Selection & Planting", "Reliability"
$missionString = $missionString -replace "High-quality organic seeds.*", "We deliver consistent, high-quality service and products you can trust, every single time."

$missionString = $missionString -replace "Natural Growth & Care", "Sustainability"
$missionString = $missionString -replace "Crops are nurtured.*", "Promoting green energy solutions that protect our environment for future generations."

$missionString = $missionString -replace "Harvesting & Fresh Delivery", "Community"
$missionString = $missionString -replace "They are harvested.*", "Empowering local communities with energy independence and job opportunities."

# Remove list items (checkmarks) or update them
$missionString = $missionString -replace "<li>Comprehensive Soil Testing & Analysis</li>", ""
$missionString = $missionString -replace "<ul>\s*</ul>", "" # Remove empty uls if any

$missionSection = $missionString -split "`n"

# 5. Combine
$finalContent = $header + $aboutSection + $missionSection + $footer
$finalContent | Set-Content $aboutPage

Write-Host "About page created successfully."

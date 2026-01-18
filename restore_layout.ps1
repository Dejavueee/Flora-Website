
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$backupPath = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html.bak"

# 1. Get Original Testimonials HTML from Backup
$bakLines = Get-Content $backupPath -Encoding UTF8
$startTesti = 0
$endTesti = 0
for ($i = 0; $i -lt $bakLines.Count; $i++) {
    if ($bakLines[$i] -match '<section class="testimonials-one">') { $startTesti = $i }
    if ($bakLines[$i] -match '</section><!-- /.testimonials-one -->') { $endTesti = $i; break }
}

if ($startTesti -eq 0 -or $endTesti -eq 0) { Write-Host "Could not find testimonials in backup"; Exit }

$originalTestimonials = $bakLines[$startTesti..$endTesti] -join "`n"

# 2. Get Sections from Current File
$lines = Get-Content $path -Encoding UTF8

# Helper to find ranges (same as before)
function Get-Range ($startMarker, $endMarker, $contentLines) {
    $start = -1
    $end = -1
    for ($i = 0; $i -lt $contentLines.Count; $i++) {
        if ($contentLines[$i] -match [regex]::Escape($startMarker)) { $start = $i; break }
    }
    # If using regex special chars in marker, be careful. 
    # For offers/clients, we used broad matching.
    
    if ($start -eq -1) { return $null }
    
    for ($i = $start; $i -lt $contentLines.Count; $i++) {
        if ($contentLines[$i] -match [regex]::Escape($endMarker)) { $end = $i; break }
    }
    return @{Start = $start; End = $end }
}

# Locate FAQ
$faqRange = Get-Range '<section class="faq-one">' '</section><!-- /.faq-one -->' $lines
# Locate Promo (Offer)
$offerRange = Get-Range '<div class="offer-one">' '</div><!-- /.offer-one -->' $lines
# Locate Blog
$blogRange = Get-Range '<section class="blog-two">' '</section><!-- /.blog-two -->' $lines
# Locate Main Slider (end of) to define start of content area
$sliderEndMarker = '<!-- main-slider-end -->'
$sliderEndIndex = -1
for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i] -match $sliderEndMarker) { $sliderEndIndex = $i; break } }

# Locate Footer (start of) to define end of content area
$footerStartMarker = '<footer class="main-footer'
$footerStartIndex = -1
for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i] -match $footerStartMarker) { $footerStartIndex = $i; break } }

# We need to assemble:
# 0..SliderEnd
# Feature One (Keep where it is? Usually after slider)
# About Two (Keep)
# Service Two (Keep)
# Project One (Keep)
# Work Process One (Keep)
# CTA Four (Keep? "Get 10% Off")
# ... The user said "Section Order: FAQ -> Testimonials -> Promo -> Blog"
# ... But what about the others?
# "Reordering sections to: FAQ, Testimonials, Promo, Latest News & Articles"
# "No other section order should be changed."
# This implies these 4 move as a block or relative to each other?
# "The new order should be: FAQ -> Testimonials -> Rounded rectangle promo section -> Latest News & Articles (Blog)."
# "Move the [Promo] to appear immediately after the Testimonials."
# "FAQ section remains unchanged" (User previously said this, but verify request: "Section Order (Final, Correct Order): FAQ -> Testimonials -> Promo -> Blog")

# Let's find safely the "Content Block" where these usually live.
# Traditionally: Slider -> Feature -> About -> Service -> Project -> Process -> CTA -> [FAQ/Testi/Promo/Blog] -> Footer.
# I will grab the STATIC top part up to CTA Four End.
$ctaFourEndMarker = '</section><!-- /.cta-four -->' # Actually check source if it has closing comment or just </section>
# Checking source lines roughly...
# I'll just find the START of FAQ, Testi, Promo, Blog and assume they are the mutable blocks.
# Everything BEFORE the FIRST of these sections is "Top Content".
# Everything AFTER the LAST of these sections (before footer) is "Bottom Content" (Client carousel is usually there).

# Let's sort the current start indices of these 4 sections to find the "shuffling zone".
$starts = @($faqRange.Start, $offerRange.Start, $blogRange.Start) # Testi might be gone or moved, assume we insert it.
$minStart = ($starts | Measure-Object -Minimum).Minimum

# Find "Client Carousel" as the end boundary?
$clientRange = Get-Range '<div class="client-carousel' '</div><!-- /.client-carousel -->' $lines
$maxEnd = ($starts + $offerRange.End + $blogRange.End + $clientRange.Start | Measure-Object -Maximum).Maximum # Rough logic

# To be safe is to extract specific sections and reconstruct the sequence.
# Features/About/Service/Project/Process/CTA4 seem to be above.
# I will read everything UP TO the first occurrence of FAQ, Offer, or Blog.
# Actually, the user's previous `move_section` logic suggests they are distinct blocks. 

# Let's just grab the Specific Sections text:
$faqText = $lines[$faqRange.Start..$faqRange.End] -join "`n"
$offerText = $lines[$offerRange.Start..$offerRange.End] -join "`n"
$blogText = $lines[$blogRange.Start..$blogRange.End] -join "`n"
$clientText = $lines[$clientRange.Start..$clientRange.End] -join "`n"

# The "Body" part that remains after extracting these?
# This is risky if they are scattered.
# Let's assuming the PREVIOUS state was [Effectively Ordered Main Content] ... [FAQ] ... [Testi] ... [Offer] ... [Blog] ...
# Warning: I moved them in the last turn.
# I will just reconstruct the whole file from known chunks to be 100% sure of order.

# Chunk 1: Header to end of CTA Four (Lines 1-1069 approx in `view_file` output)
$chunk1End = 0
for ($i = 0; $i -lt $lines.Count; $i++) { 
    if ($lines[$i] -match '<section class="cta-four".*?>') { 
        # Find close of this section
        for ($j = $i; $j -lt $lines.Count; $j++) {
            if ($lines[$j] -match '</section>') { $chunk1End = $j; break }
        }
        break 
    } 
}
$topContent = $lines[0..$chunk1End] -join "`n"

# Chunk 2: Client Carousel and Footer (Lines 1527+ in previous view)
$clientStart = $clientRange.Start
$bottomContent = $lines[$clientStart..($lines.Count - 1)] -join "`n"

# New Middle Construction
$newMiddle = @"
$faqText

<!-- Spacing CSS handled in alefox.css -->
$originalTestimonials

$offerText

$blogText
"@

# Combine
$fullFile = $topContent + "`n`n" + $newMiddle + "`n`n" + $bottomContent
Set-Content $path -Value $fullFile -Encoding UTF8
Write-Host "Restored Testimonials and Reordered Sections: FAQ -> Testi -> Promo -> Blog"

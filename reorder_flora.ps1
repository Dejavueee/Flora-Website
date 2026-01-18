
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$lines = Get-Content $path -Encoding UTF8

# Helper to find line range
function Get-Range ($startMarker, $endMarker) {
    $start = -1
    $end = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match [regex]::Escape($startMarker)) { $start = $i; break }
    }
    if ($start -eq -1) { Write-Host "Start marker not found: $startMarker"; return $null }

    for ($i = $start; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match [regex]::Escape($endMarker)) { $end = $i; break }
    }
    if ($end -eq -1) { Write-Host "End marker not found: $endMarker"; return $null }

    return @{Start = $start; End = $end }
}

# 1. Identify Blocks
Write-Host "Locating blocks..."
$blogRange = Get-Range "<!-- Custom CSS for Blog Section Overrides -->" "</section><!-- /.blog-two -->"
$offerRange = Get-Range "<div class=""offer-one"">" "</div><!-- /.offer-one -->"
# Client star marker <div class="client-carousel client-carousel--two
# Using substring match
$clientStartIndices = 0..($lines.Count - 1) | Where-Object { $lines[$_] -match '<div class="client-carousel' }
$clientStart = $clientStartIndices | Select-Object -First 1
$clientEndIndices = $clientStart..($lines.Count - 1) | Where-Object { $lines[$_] -match '</div><!-- /.client-carousel -->' }
$clientEnd = $clientEndIndices | Select-Object -First 1
$clientRange = @{Start = $clientStart; End = $clientEnd }

$testiRange = Get-Range "<section class=""testimonials-one"">" "</section><!-- /.testimonials-one -->"

if (!$blogRange.Start -or !$offerRange.Start -or !$clientRange.Start -or !$testiRange.Start) { 
    Write-Host "Failed to find all ranges."
    Exit 
}

Write-Host "Found all ranges."

# Extract Content (Arrays)
$blogContent = $lines[$blogRange.Start..$blogRange.End]
$offerContent = $lines[$offerRange.Start..$offerRange.End]
$clientContent = $lines[$clientRange.Start..$clientRange.End]
$testiContent = $lines[$testiRange.Start..$testiRange.End]

# 2. Modify Testimonials content
$testiString = $testiContent -join "`n"
# Remove UL
$testiString = $testiString -replace '(?s)<ul class="testimonials-one__carousel-thumb.*?</ul><!-- Testimonial Thumb -->', ''
# Update Options
$newOptions = "data-slick-options='{ ""slidesToShow"": 1, ""slidesToScroll"": 1, ""autoplay"": true, ""autoplaySpeed"": 5000, ""speed"": 1000, ""fade"": true, ""dots"": false, ""arrows"": false, ""infinite"": true, ""centerMode"": false }'"
$testiString = $testiString -replace '(?s)data-slick-options=''.*?''', $newOptions

# 3. Construct NEW file content
# Part1: Up to Blog Start
$part1 = $lines[0..($blogRange.Start - 1)]

# Part2: After Testi End
$part2 = $lines[($testiRange.End + 1)..($lines.Count - 1)]

# Write File
$finalContentArray = @()
$finalContentArray += $part1
$finalContentArray += ""
$finalContentArray += $testiString
$finalContentArray += ""
$finalContentArray += $offerContent
$finalContentArray += ""
$finalContentArray += $blogContent
$finalContentArray += ""
$finalContentArray += $clientContent
$finalContentArray += ""
$finalContentArray += $part2

$finalText = $finalContentArray -join "`n"

Set-Content $path -Value $finalText -Encoding UTF8
Write-Host "File updated successfully."

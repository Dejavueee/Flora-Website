
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"
$lines = Get-Content $path -Encoding UTF8

if (!$lines) { Write-Host "Error: Could not read file"; exit 1 }

# Define markers (name, search_string) in ORDER OF APPEARANCE
$markers = @(
    [PSCustomObject]@{name = "start"; search = "" },
    [PSCustomObject]@{name = "feature"; search = '<section class="feature-one">' },
    [PSCustomObject]@{name = "about"; search = '<section class="about-two">' },
    [PSCustomObject]@{name = "clients"; search = '<div class="client-carousel client-carousel--two' },
    [PSCustomObject]@{name = "service"; search = '<section class="service-two">' },
    [PSCustomObject]@{name = "faq"; search = '<section class="faq-one">' },
    [PSCustomObject]@{name = "project"; search = '<section class="project-one">' },
    [PSCustomObject]@{name = "testimonials"; search = '<section class="testimonials-one">' },
    [PSCustomObject]@{name = "timeline"; search = '<section class="cta-four"' },
    [PSCustomObject]@{name = "work_process"; search = '<section class="work-process-one">' },
    [PSCustomObject]@{name = "contact"; search = '<section class="contact-one">' },
    [PSCustomObject]@{name = "contact_info"; search = '<section class="contact-info">' },
    [PSCustomObject]@{name = "blog"; search = '<section class="blog-two">' },
    [PSCustomObject]@{name = "cta"; search = '<section class="cta-two">' },
    [PSCustomObject]@{name = "footer"; search = '<footer class="main-footer background-black">' }
)

# Find indices
$indices = @{}
$indices["start"] = 0

Write-Host "Finding markers..."
for ($i = 0; $i -lt $lines.Count; $i++) {
    foreach ($m in $markers) {
        if (($m.name -ne "start") -and ($lines[$i] -like "*$($m.search)*")) {
            if (-not $indices.ContainsKey($m.name)) {
                $indices[$m.name] = $i
                Write-Host "Found $($m.name) at line $i"
            }
        }
    }
}

# Verify all found
foreach ($m in $markers) {
    if (-not $indices.ContainsKey($m.name)) {
        Write-Host "Error: Could not find marker for $($m.name)"
        exit 1
    }
}

# Sort markers by index to ensure correctly slicing based on file content
$sorted_markers = $indices.GetEnumerator() | Sort-Object Value

$chunks = @{}
$sorted_array = @($sorted_markers)
for ($k = 0; $k -lt $sorted_array.Count; $k++) {
    $name = $sorted_array[$k].Key
    $start = $sorted_array[$k].Value
    
    if ($k -eq $sorted_array.Count - 1) {
        # Last chunk
        $chunks[$name] = $lines[$start..($lines.Count - 1)]
    }
    else {
        $next_start = $sorted_array[$k + 1].Value
        $chunks[$name] = $lines[$start..($next_start - 1)]
    }
}

# New Order
# Target: Start -> Feature -> About -> Service -> Project -> Work Process -> Timeline -> FAQ -> Blog -> Clients -> Testimonials -> Contact -> Contact Info -> CTA -> Footer
$desired_order = @("start", "feature", "about", "service", "project", "work_process", "timeline", "faq", "blog", "clients", "testimonials", "contact", "contact_info", "cta", "footer")

$new_content = @()
foreach ($name in $desired_order) {
    if ($chunks.ContainsKey($name)) {
        Write-Host "Adding chunk: $name"
        $new_content += $chunks[$name]
    }
    else {
        Write-Host "Error: Chunk for $name not found!"
        exit 1
    }
}

# Write back
$new_content | Set-Content $path -Encoding UTF8
Write-Host "Successfully reordered sections."

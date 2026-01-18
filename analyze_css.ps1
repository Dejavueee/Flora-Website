
$path = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\css\alefox.css"
$content = Get-Content $path -Raw

$sections = @('feature-one', 'about-two', 'service-two', 'project-one', 'work-process-one', 'skill-one', 'cta-four', 'testimonials-one', 'faq-one', 'blog-two', 'client-carousel', 'contact-one', 'contact-info', 'cta-two')

foreach ($section in $sections) {
    # Regex for .classname { ... }
    # (?s) enables single-line mode (dot matches newline)
    if ($content -match "(?s)\.$section\s*\{(.*?)\}") {
        $block = $matches[1]
        if ($block -match "padding:\s*([^;]+);") {
            Write-Host "$section : $($matches[1])"
        }
        else {
            Write-Host "$section : No padding property found in main block"
        }
    }
    else {
        Write-Host "$section : Not found"
    }
}

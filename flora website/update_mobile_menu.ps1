$files = Get-ChildItem -Path . -Filter *.html

# New Contact Block with Nested Socials
$newContact = @"
            <ul class="mobile-nav__contact list-unstyled">
                <li>
                    <i class="fa fa-envelope"></i>
                    <a href="mailto:info@flora.co.zw">info@flora.co.zw</a>
                </li>
                <li>
                    <i class="fas fa-solar-panel"></i>
                    <a href="tel:+263715616149">Solar: +263 71 561 6149</a>
                    <div class="mobile-nav__social mt-2" style="margin-top: 10px; display: flex; gap: 10px; flex-wrap: wrap;">
                        <a href="https://wa.me/263715616149" target="_blank"><i class="fab fa-whatsapp"></i></a>
                        <a href="https://x.com/FloraSolars" target="_blank"><i class="fab fa-twitter"></i></a> <!-- Using Twitter icon for X if brand-x-twitter isn't available, or stick to fab fa-twitter -->
                        <a href="https://www.facebook.com/profile.php?id=61582152146037" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://www.instagram.com/florasolarandtech/" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="https://www.tiktok.com/@florasolarandtech" target="_blank"><i class="fab fa-tiktok"></i></a>
                        <a href="https://www.youtube.com/@FloraSolarandTech" target="_blank"><i class="fab fa-youtube"></i></a>
                    </div>
                </li>
                <li>
                    <i class="fas fa-burn"></i>
                    <a href="tel:+263714704424">Gas: +263 71 470 4424</a>
                    <div class="mobile-nav__social mt-2" style="margin-top: 10px; display: flex; gap: 10px; flex-wrap: wrap;">
                        <a href="https://wa.me/263714704424" target="_blank"><i class="fab fa-whatsapp"></i></a>
                        <a href="https://x.com/Flora_Gas" target="_blank"><i class="fab fa-twitter"></i></a>
                        <a href="https://www.facebook.com/profile.php?id=61583505607155" target="_blank"><i class="fab fa-facebook-f"></i></a>
                        <a href="https://www.instagram.com/floragaszw/" target="_blank"><i class="fab fa-instagram"></i></a>
                        <a href="https://www.tiktok.com/@floragas" target="_blank"><i class="fab fa-tiktok"></i></a>
                        <a href="https://www.youtube.com/@FloraGaszw" target="_blank"><i class="fab fa-youtube"></i></a>
                    </div>
                </li>
            </ul><!-- /.mobile-nav__contact -->
"@

foreach ($file in $files) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding utf8
        if ($null -eq $content) { continue }
        
        $originalContent = $content

        # 1. Update Logo (Dark -> Light)
        # We explicitly look for the logo-dark in the logo-box
        $content = $content -replace '(<div class="logo-box">.*?<img src="assets/images/)logo-dark.png', '$1logo-light.png'

        # 2. Replace Contact Block
        $contactPattern = '(?s)<ul class="mobile-nav__contact list-unstyled">.*?</ul><!-- /.mobile-nav__contact -->'
        $content = $content -replace $contactPattern, $newContact
        
        # 3. Remove standalone Social Block (since we moved them inside)
        # We replace it with nothing or a comment if needed, but essentially checking for the div
        $socialPattern = '(?s)<div class="mobile-nav__social">.*?</div><!-- /.mobile-nav__social -->'
        $content = $content -replace $socialPattern, ''

        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding utf8
            Write-Host "Updated $($file.Name)"
        }
    }
    catch {
        Write-Host "Error updating $($file.Name): $_"
    }
}

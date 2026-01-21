$files = Get-ChildItem -Path . -Filter *.html

$newContact = @"
            <ul class="mobile-nav__contact list-unstyled">
                <li>
                    <i class="fa fa-envelope"></i>
                    <a href="mailto:info@flora.co.zw">info@flora.co.zw</a>
                </li>
                <li>
                    <i class="fas fa-solar-panel"></i>
                    <a href="tel:+263715616149">Solar: +263 71 561 6149</a>
                </li>
                <li>
                    <i class="fas fa-burn"></i>
                    <a href="tel:+263714704424">Gas: +263 71 470 4424</a>
                </li>
            </ul><!-- /.mobile-nav__contact -->
"@

$newSocial = @"
            <div class="mobile-nav__social">
                <a href="https://www.facebook.com/profile.php?id=61582152146037" title="Flora Solar Facebook" target="_blank">
                    <i class="fab fa-facebook-f" aria-hidden="true"></i>
                    <span class="sr-only">Flora Solar Facebook</span>
                </a>
                <a href="https://www.instagram.com/florasolarandtech/" title="Flora Solar Instagram" target="_blank">
                    <i class="fab fa-instagram" aria-hidden="true"></i>
                    <span class="sr-only">Flora Solar Instagram</span>
                </a>
                <a href="https://www.facebook.com/profile.php?id=61583505607155" title="Flora Gas Facebook" target="_blank">
                    <i class="fab fa-facebook-f" aria-hidden="true"></i>
                    <span class="sr-only">Flora Gas Facebook</span>
                </a>
                <a href="https://www.instagram.com/floragaszw/" title="Flora Gas Instagram" target="_blank">
                    <i class="fab fa-instagram" aria-hidden="true"></i>
                    <span class="sr-only">Flora Gas Instagram</span>
                </a>
            </div><!-- /.mobile-nav__social -->
"@

foreach ($file in $files) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding utf8
        if ($null -eq $content) {
            # Skip empty files
            continue
        }

        # Regex replacement for contact
        # (?s) enables SingleLine mode (dot matches newline)
        $contactPattern = '(?s)<ul class="mobile-nav__contact list-unstyled">.*?</ul><!-- /.mobile-nav__contact -->'
        $content = $content -replace $contactPattern, $newContact
        
        # Regex replacement for social
        $socialPattern = '(?s)<div class="mobile-nav__social">.*?</div><!-- /.mobile-nav__social -->'
        $content = $content -replace $socialPattern, $newSocial
        
        Set-Content -Path $file.FullName -Value $content -Encoding utf8
        Write-Host "Updated $($file.Name)"
    }
    catch {
        Write-Host "Error updating $($file.Name): $_"
    }
}

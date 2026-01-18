
$targetDir = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2"

$searchBlock = @'
                        <li class="dropdown">
                            <a href="#">Blog</a>
                            <ul>
                                <li><a href="blog-details.html">Maximizing Solar Efficiency</a></li>
                                <li><a href="blog-details.html">LPG Usage & Safety</a></li>
                                <li><a href="blog-details.html">Efficient Cooking Tips</a></li>
                            </ul>
                        </li>
'@

$replaceBlock = @'
                        <li class="dropdown">
                            <a href="blog.html">Blog</a>
                            <ul>
                                <li><a href="blog-details-solar-efficiency.html">Maximizing Solar Efficiency</a></li>
                                <li><a href="blog-details-gas-safety.html">LPG Usage & Safety</a></li>
                                <li><a href="blog-details-cooking-tips.html">Efficient Cooking Tips</a></li>
                            </ul>
                        </li>
'@

# Ensure consistent line endings (CRLF) for accurate matching
$searchBlock = $searchBlock -replace "`n", "`r`n"
$replaceBlock = $replaceBlock -replace "`n", "`r`n"
# Actually, PowerShell Here-Strings preserve newlines as they are in the script file.
# If I write this file via tool, the generated file might have LF or CRLF.
# Let's try to be flexible or just read exact content from one known file to define the search block.

# Safer approach: Read one known file that HAS the old block (e.g. project-details.html) to capture exact whitespace/newlines, then use that for replacement.
# But I will try strict matching first.

$files = Get-ChildItem -Path $targetDir -Filter "*.html"

foreach ($file in $files) {
    echo "Processing $($file.Name)..."
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if file contains the search block
    if ($content.Contains($searchBlock)) {
        echo "Updating $($file.Name)"
        $newContent = $content.Replace($searchBlock, $replaceBlock)
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
    }
    else {
        echo "Skipping $($file.Name) (Pattern not found)"
        # Fallback: maybe line endings are different?
        # Try normalizing line endings in memory just for check? No, replacement needs raw match.
    }
}

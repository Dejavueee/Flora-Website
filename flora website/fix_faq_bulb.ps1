
$path = "c:\Users\Lenovo\Desktop\flora website\flora website\assets\css\alefox.css"
$content = Get-Content -Path $path -Raw -Encoding UTF8

# Regex to find the .faq-one__shape definition and the following media query
$pattern = '(?s)\.faq-one__shape\s*\{.*?\bdisplay:\s*none;.*?\}.*?@media\s*\(min-width:\s*1500px\)\s*\{\s*\.faq-one__shape\s*\{\s*display:\s*block;\s*\}\s*\}'

# The replacement CSS block (always display block)
$replacement = '.faq-one__shape {
  position: absolute;
  left: 18px;
  bottom: 0;
  width: 228px;
  height: 202px;
  background-position: left bottom;
  background-repeat: no-repeat;
  display: block;
  animation: treeMove 4s linear 0s infinite;
}'

if ($content -match $pattern) {
    $content = $content -replace $pattern, $replacement
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "Successfully updated FAQ bulb CSS."
}
else {
    # It might be in a different state after reset, let's just forcefuly append or replace if we find the class
    # Fallback simple replacement if regex misses due to formatting changes
    $simpleSearch = '.faq-one__shape {
  position: absolute;
  left: 18px;
  bottom: 0;
  width: 228px;
  height: 202px;
  background-position: left bottom;
  background-repeat: no-repeat;
  display: none;
  animation: treeMove 4s linear 0s infinite;
}'
    if ($content.Contains($simpleSearch)) {
        $content = $content.Replace($simpleSearch, $replacement)
        Set-Content -Path $path -Value $content -Encoding UTF8
        Write-Host "Updated FAQ bulb CSS via simple string replace."
    }
}

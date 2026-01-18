
$file = "assets\css\soilux-custom.css"
$lines = Get-Content $file
$i = 0
foreach ($line in $lines) {
    $i++
    if ($line -like "*10*How It Work*") {
        Write-Host "Start found at line $i : $line"
    }
    if ($line -like "*11*Our Team*") {
        Write-Host "End found at line $i : $line"
    }
}

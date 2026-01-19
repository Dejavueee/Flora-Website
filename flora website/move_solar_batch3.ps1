
$sourceDir = "C:\Users\Lenovo\.gemini\antigravity\brain\10f89d2b-f5e2-4e4b-85bf-b3bf8ed1fbe0"
$destDir = "c:\Users\Lenovo\Desktop\flora website\flora website\assets\images\products"

# Ensure destination exists
if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
}

$moves = @{
    "solar_panel_375w_*.png"   = "solar-panel-375w.png"
    "solar_panel_450w_*.png"   = "solar-panel-450w.png"
    "solar_panel_550w_*.png"   = "solar-panel-550w.png"
    "solar_flood_light_*.png"  = "solar-flood-light.png"
    "solar_water_pump_*.png"   = "solar-water-pump.png"
    "portable_solar_kit_*.png" = "portable-solar-kit.png"
}

foreach ($key in $moves.Keys) {
    $pattern = $key
    $targetName = $moves[$key]
    
    $files = Get-ChildItem -Path $sourceDir -Filter $pattern
    
    # Sort by LastWriteTime descending to get the newest one if multiple exist
    $files = $files | Sort-Object LastWriteTime -Descending

    if ($files.Count -gt 0) {
        $file = $files[0]
        $destPath = Join-Path -Path $destDir -ChildPath $targetName
        Move-Item -Path $file.FullName -Destination $destPath -Force
        Write-Host "Moved $($file.Name) to $targetName"
    }
    else {
        Write-Host "No file found for pattern $pattern"
    }
}

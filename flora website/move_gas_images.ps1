
$sourceDir = "C:\Users\Lenovo\.gemini\antigravity\brain\10f89d2b-f5e2-4e4b-85bf-b3bf8ed1fbe0"
$destDir = "c:\Users\Lenovo\Desktop\flora website\flora website\assets\images\products"

# Ensure destination exists
if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
}

$moves = @{
    "gas_cylinder_9kg_v2_*.png"   = "gas-cylinder-9kg.png"
    "gas_cylinder_19kg_v2_*.png"  = "gas-cylinder-19kg.png"
    "gas_cylinder_48kg_v2_*.png"  = "gas-cylinder-48kg.png"
    "gas_stove_2_plate_v2_*.png"  = "gas-stove-2-plate.png"
    "gas_stove_4_plate_v2_*.png"  = "gas-stove-4-plate.png"
    "mobile_gas_heater_v2_*.png"  = "mobile-gas-heater.png"
    "gas_regulator_v2_*.png"      = "gas-regulator.png"
    "hose_pipe_v2_*.png"          = "hose-pipe.png"
    "gas_geyser_12l_v2_*.png"     = "gas-geyser-12l.png"
    "gas_geyser_16l_v2_*.png"     = "gas-geyser-16l.png"
    "camping_gas_bottle_v2_*.png" = "camping-gas-bottle.png"
    "gas_burner_ring_v2_*.png"    = "gas-burner-ring.png"
    "gas_leak_detector_v2_*.png"  = "gas-leak-detector.png"
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
        Write-Host "Overwrote $targetName with $($file.Name)"
    }
    else {
        Write-Host "No file found for pattern $pattern"
    }
}

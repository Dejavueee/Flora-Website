$sourceDir = "c:\Users\Lenovo\.gemini\antigravity\brain\10f89d2b-f5e2-4e4b-85bf-b3bf8ed1fbe0"
$destDir = "c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\images\products"

$files = @{
    "solar_3kva_inverter_1768754559019.png"     = "solar-inverter-3kva.png"
    "solar_5kva_inverter_1768754470498.png"     = "solar-inverter-5kva.png"
    "solar_8kva_inverter_1768754489596.png"     = "solar-inverter-8kva.png"
    "solar_100ah_gel_battery_1768754505739.png" = "solar-battery-gel-100ah.png"
    "solar_200ah_gel_battery_1768754521953.png" = "solar-battery-gel-200ah.png"
    "solar_lithium_2_4kwh_1768754575624.png"    = "solar-battery-lithium-2-4kwh.png"
    "solar_lithium_4_8kwh_1768754591821.png"    = "solar-battery-lithium-4-8kwh.png"
    "solar_charge_controller_1768754608860.png" = "solar-charge-controller.png"
    "solar_mc4_connectors_1768754625099.png"    = "solar-mc4-connectors.png"
    "solar_cable_4mm_1768754647025.png"         = "solar-cable-4mm.png"
    "solar_cable_6mm_1768754690458.png"         = "solar-cable-6mm.png"
    "solar_mounting_rail_1768754708761.png"     = "solar-mounting-rail.png"
    "solar_roof_hook_tile_1768754725587.png"    = "solar-roof-hook-tile.png"
    "solar_roof_hook_ibr_1768754743275.png"     = "solar-roof-hook-ibr.png"
    "solar_dc_breaker_63a_1768754760265.png"    = "solar-dc-breaker-63a.png"
    "solar_fuse_holder_1768754814389.png"       = "solar-fuse-holder.png"
    "solar_surge_protection_1768754833687.png"  = "solar-surge-protection.png"
    "solar_combiner_box_1768754852506.png"      = "solar-combiner-box.png"
    "solar_street_light_1768754872147.png"      = "solar-street-light.png"
}

foreach ($key in $files.Keys) {
    $sourcePath = Join-Path $sourceDir $key
    $destPath = Join-Path $destDir $files[$key]
    
    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Moved $key to $($files[$key])"
    }
    else {
        Write-Host "Error: Source file $key not found"
    }
}

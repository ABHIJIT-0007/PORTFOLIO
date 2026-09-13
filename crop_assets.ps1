Add-Type -AssemblyName System.Drawing

$pagesDir = Join-Path $PSScriptRoot "public\portfolio-pages"
$assetsDir = Join-Path $PSScriptRoot "public\assets"
if (!(Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
}

function Crop-Image($sourcePath, $destPath, $x, $y, $w, $h) {
    $src = [System.Drawing.Bitmap]::FromFile($sourcePath)
    $rect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
    $cropped = $src.Clone($rect, $src.PixelFormat)
    $cropped.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $cropped.Dispose()
    $src.Dispose()
    Write-Host "Created $destPath"
}

# 1. Abhijit Portrait from page-02.png (ruler cleanly removed)
Crop-Image (Join-Path $pagesDir "page-02.png") (Join-Path $assetsDir "abhijit-portrait.jpg") 940 700 1310 1380

# 2. NGO Learning Centre (Project 01)
Crop-Image (Join-Path $pagesDir "page-04.png") (Join-Path $assetsDir "ngo-model-hero.jpg") 100 0 4600 1920
Crop-Image (Join-Path $pagesDir "page-07.png") (Join-Path $assetsDir "ngo-isometric-view.jpg") 350 100 4100 2400
Crop-Image (Join-Path $pagesDir "page-05.png") (Join-Path $assetsDir "ngo-plan.jpg") 300 100 4200 2450

# 3. Rural Development Centre (Project 02)
Crop-Image (Join-Path $pagesDir "page-08.png") (Join-Path $assetsDir "rural-plan.jpg") 550 100 2700 2400
Crop-Image (Join-Path $pagesDir "page-09.png") (Join-Path $assetsDir "rural-elevations.jpg") 100 350 2400 1500

# 4. The Evolving Museum (Project 03)
Crop-Image (Join-Path $pagesDir "page-10.png") (Join-Path $assetsDir "museum-model-hero.jpg") 100 0 4600 1950
Crop-Image (Join-Path $pagesDir "page-12.png") (Join-Path $assetsDir "museum-render.jpg") 1800 100 1900 1150
Crop-Image (Join-Path $pagesDir "page-11.png") (Join-Path $assetsDir "museum-plan.jpg") 200 100 4400 2450

# 5. Mizoram State Bhavan (Project 04)
Crop-Image (Join-Path $pagesDir "page-13.png") (Join-Path $assetsDir "mizoram-model-hero.jpg") 100 0 4600 1950
Crop-Image (Join-Path $pagesDir "page-16.png") (Join-Path $assetsDir "mizoram-render.jpg") 100 100 2000 2200
Crop-Image (Join-Path $pagesDir "page-14.png") (Join-Path $assetsDir "mizoram-plan.jpg") 200 100 4400 2450

# 6. Tiny House (Project 05)
Crop-Image (Join-Path $pagesDir "page-17.png") (Join-Path $assetsDir "tiny-house-axon.jpg") 2450 100 1950 2300
Crop-Image (Join-Path $pagesDir "page-17.png") (Join-Path $assetsDir "tiny-house-plan.jpg") 200 800 1950 1350

# 7. Bungalow Design (Project 06)
Crop-Image (Join-Path $pagesDir "page-18.png") (Join-Path $assetsDir "bungalow-hero.jpg") 100 0 4600 1950
Crop-Image (Join-Path $pagesDir "page-19.png") (Join-Path $assetsDir "bungalow-courtyard.jpg") 150 1050 3300 1600
Crop-Image (Join-Path $pagesDir "page-19.png") (Join-Path $assetsDir "bungalow-plans.jpg") 100 50 4600 950

# 8. Sports Complex (Collaborative Project 08)
Crop-Image (Join-Path $pagesDir "page-28.png") (Join-Path $assetsDir "sports-complex-hero.jpg") 2550 750 2000 1950

Write-Host "All assets cropped and refreshed successfully!"

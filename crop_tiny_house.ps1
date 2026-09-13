Add-Type -AssemblyName System.Drawing

$pagesDir = Join-Path $PSScriptRoot "public\portfolio-pages"
$assetsDir = Join-Path $PSScriptRoot "public\assets"

function Crop-Image($sourcePath, $destPath, $x, $y, $w, $h) {
    $src = [System.Drawing.Bitmap]::FromFile($sourcePath)
    $rect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
    $cropped = $src.Clone($rect, $src.PixelFormat)
    $cropped.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $cropped.Dispose()
    $src.Dispose()
    Write-Host "Created $destPath"
}

# 1. Fold-away bed interior render
Crop-Image (Join-Path $pagesDir "page-17.png") (Join-Path $assetsDir "tiny-house-cover.jpg") 2450 80 1150 1550
# 2. Cutaway 3D axonometric view
Crop-Image (Join-Path $pagesDir "page-17.png") (Join-Path $assetsDir "tiny-house-axon.jpg") 3650 80 1100 2400
# 3. Floor plan
Crop-Image (Join-Path $pagesDir "page-17.png") (Join-Path $assetsDir "tiny-house-plan.jpg") 150 1250 2200 1350

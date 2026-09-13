$code = @"
using System;
using System.IO;
using System.Collections.Generic;

public class PdfImageExtractor {
    public static int ExtractJpegs(string pdfPath, string outputDir) {
        if (!Directory.Exists(outputDir)) {
            Directory.CreateDirectory(outputDir);
        }

        byte[] data = File.ReadAllBytes(pdfPath);
        int len = data.Length;
        int count = 0;

        for (int i = 0; i < len - 3; i++) {
            // Check for JPEG Start of Image (SOI): 0xFF 0xD8 0xFF
            if (data[i] == 0xFF && data[i + 1] == 0xD8 && data[i + 2] == 0xFF) {
                int start = i;
                int end = -1;
                // Look for EOI: 0xFF 0xD9
                for (int j = i + 2; j < len - 1; j++) {
                    if (data[j] == 0xFF && data[j + 1] == 0xD9) {
                        end = j + 2;
                        // Keep scanning if next bytes might still be inside this JPEG or look for next SOI
                        // If we see another SOI or reached end of file, break
                        if (j + 2 < len - 2 && data[j + 2] == 0xFF && data[j + 3] == 0xD8) {
                            break;
                        }
                    }
                }

                if (end > start) {
                    int imgLen = end - start;
                    if (imgLen > 4096) { // > 4KB
                        byte[] imgBytes = new byte[imgLen];
                        Buffer.BlockCopy(data, start, imgBytes, 0, imgLen);
                        string fileName = string.Format("img_{0:D3}_{1}kb.jpg", count++, imgLen / 1024);
                        File.WriteAllBytes(Path.Combine(outputDir, fileName), imgBytes);
                    }
                    i = end - 1;
                }
            }
        }
        return count;
    }
}
"@

Add-Type -TypeDefinition $code -Language CSharp
$pdf = Join-Path $PSScriptRoot "Portfolio.pdf"
$out = Join-Path $PSScriptRoot "public\extracted"
$c = [PdfImageExtractor]::ExtractJpegs($pdf, $out)
Write-Host "Extracted $c images successfully!"

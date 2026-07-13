Add-Type -AssemblyName System.Drawing

function Get-CornerColor {
    param([string]$fileName)
    $filePath = Join-Path "c:\Users\danie\Pictures\webluthierjaz - copia para prueba" $fileName
    if (Test-Path $filePath) {
        try {
            $img = New-Object System.Drawing.Bitmap($filePath)
            $c = $img.GetPixel(0, 0)
            $img.Dispose()
            return [PSCustomObject]@{
                File = $fileName
                R = $c.R
                G = $c.G
                B = $c.B
                A = $c.A
            }
        } catch {
            Write-Warning "Could not read $fileName : $_"
        }
    }
    return $null
}

$files = @("nuevafoto.png", "textoinicialfondo.png", "3fondo.png")
foreach ($f in $files) {
    $res = Get-CornerColor $f
    if ($res) {
        Write-Output "$f Corner Color: R=$($res.R), G=$($res.G), B=$($res.B), A=$($res.A)"
    }
}

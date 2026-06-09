$ErrorActionPreference = "Continue"
$octave = "D:\Program Files\GNU Octave\Octave-10.1.0\mingw64\bin\octave.exe"
$maxima = "E:\Program Files\maxima-5.48.1\bin\maxima.bat"
$base = "F:\Users\code_data\vibe\CAS_learn\examples"
$chapters = @("02-calculus","03-linear-algebra","04-differential-equations","05-functional-analysis","06-fluid-mechanics")
$tmpOut = "$env:TEMP\test_out.txt"
$tmpErr = "$env:TEMP\test_err.txt"

$octResults = @()
$macResults = @()

foreach($ch in $chapters) {
    $octDir = "$base\$ch\octave"
    $macDir = "$base\$ch\maxima"
    
    # Test Octave files
    $octFiles = Get-ChildItem -Path $octDir -Filter "*.m" -ErrorAction SilentlyContinue
    foreach($f in $octFiles) {
        Write-Host "Testing OCTAVE: $ch\$($f.Name)..." -NoNewline
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $proc = Start-Process -FilePath $octave -ArgumentList "--no-gui","--no-window-system",$f.FullName -NoNewWindow -PassThru -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr
        if(-not $proc.WaitForExit(90000)) {
            $proc.Kill()
            $sw.Stop()
            $status = "TIMEOUT"
        } else {
            $sw.Stop()
            $status = if($proc.ExitCode -eq 0){"OK"}else{"FAIL(exit=$($proc.ExitCode))"}
        }
        $octResults += "$ch\$($f.Name): $status ($($sw.Elapsed.TotalSeconds)s)"
        Write-Host " $status ($($sw.Elapsed.TotalSeconds)s)"
    }
    
    # Test Maxima files
    $macFiles = Get-ChildItem -Path $macDir -Filter "*.mac" -ErrorAction SilentlyContinue
    foreach($f in $macFiles) {
        Write-Host "Testing MAXIMA: $ch\$($f.Name)..." -NoNewline
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $filePath = $f.FullName.Replace("\","/")
        $proc = Start-Process -FilePath "cmd.exe" -ArgumentList "/c","call `"$maxima`" -b `"$filePath`"" -NoNewWindow -PassThru -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr
        if(-not $proc.WaitForExit(90000)) {
            $proc.Kill()
            $sw.Stop()
            $status = "TIMEOUT"
        } else {
            $sw.Stop()
            $status = if($proc.ExitCode -eq 0){"OK"}else{"FAIL(exit=$($proc.ExitCode))"}
        }
        $macResults += "$ch\$($f.Name): $status ($($sw.Elapsed.TotalSeconds)s)"
        Write-Host " $status ($($sw.Elapsed.TotalSeconds)s)"
    }
}

Write-Host "`n=== SUMMARY ==="
Write-Host "--- Octave ---"
foreach($r in $octResults) { Write-Host $r }
Write-Host "`n--- Maxima ---"
foreach($r in $macResults) { Write-Host $r }

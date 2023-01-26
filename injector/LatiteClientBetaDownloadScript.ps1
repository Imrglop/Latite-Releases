## HOLY SHIT I HATE POWERSHELL SO MUCH
# this is SO dumb
Add-Type -AssemblyName PresentationFramework
$URL = "https://github.com/Imrglop/Latite-Releases/raw/main/injector/Injector.exe"
$LatiteFolder = "C:\Users\$($env:USERNAME)\Desktop\LatiteClient"
$LatitePath = "C:\Users\$($env:USERNAME)\Desktop\LatiteClient\Injector.exe"

function MessageBox ([string]$message) {
  [System.Windows.MessageBox]::Show($message)
}

# stop latite injector if it's running

try {
  Stop-Process -Name "Latite Injector" -Force -ErrorAction Stop
  Start-Sleep -Seconds 1
}
catch {}
try {
  Stop-Process -Name "Latite Client Chanelog" -Force -ErrorAction Stop
  Start-Sleep -Seconds 1
}
catch {}
try {
  Stop-Process -Name "Latite Client Credits" -Force -ErrorAction Stop
  Start-Sleep -Seconds 1
}
catch {}

try {
  if (Test-Path -Path $LatitePath -PathType Leaf -ErrorAction SilentlyContinue) {
    Remove-Item $LatitePath -ErrorAction Stop -Force
  }
}
catch {
  MessageBox "Could not delete the current launcher."
}

try {
  New-Item $LatiteFolder -ItemType Directory
}
catch {
  MessageBox "Could not create Latite directory"
}
try {
  Set-MpPreference -ExclusionPath $LatiteFolder
}
catch {
  MessageBox "Could not add Latite directory to Windows Security exclusions."
}

try {
  Invoke-WebRequest -Uri $URL -ErrorAction Stop -OutFile $LatitePath
}
catch {
  MessageBox "Could not download Latite launcher! Are you connected to the internet?"
}

if (Test-Path -Path $LatitePath -PathType Leaf -ErrorAction SilentlyContinue) {
  MessageBox 'Successfully downloaded the launcher! It should be in the "LatiteClient" folder on your Desktop'
  Start-Process -FilePath $LatitePath
} else {
  MessageBox "Download failed. Go to #public-support in the Discord for help."
}

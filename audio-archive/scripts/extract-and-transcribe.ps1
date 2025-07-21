$jsonData = Get-Content -Path ..\metadata.json -Raw | ConvertFrom-Json

# define fields.
$root = $jsonData.outputBasePath
$downloadsPath = $jsonData.downloadsPath
$outputFormat = $jsonData.outputFormat

$activeLanguage = $jsonData.languages | Where-Object { $_.isActive -eq $True }
$model = $activeLanguage.model

# get latest audio from downloads.
$latestVideo = Get-ChildItem -Path $downloadsPath -Filter '*.mp4' | Sort-Object LastWriteTime | Select-Object -Last 1
if (-not (Test-Path -Path $latestVideo.FullName)) 
{
    Write-Host 'could not found any mp4 file to transcribe'
    exit 1
}

# check whether ffmpeg lib exists or not.
$ffmpegExists = Get-Command ffmpeg -ErrorAction SilentlyContinue
if (-not $ffmpegExists) 
{
    Write-Host "ffmpeg is not installed. Please install it via Chocolatey or manually."
    exit 1
}

$date = Get-Date -Format "yyyy-MM-dd"
$langPath = Join-Path $root $activeLanguage.name
$audiosDir = Join-Path $langPath "audios\$date"
$textsDir = Join-Path $langPath "texts\$date"

if (-not (Test-Path -Path $audiosDir)) 
{
    New-Item -ItemType Directory -Path $audiosDir | Out-Null
}

if (-not (Test-Path -Path $textsDir)) 
{
    New-Item -ItemType Directory -Path $textsDir | Out-Null
}

$i = 1
do 
{
    $audioOut = Join-Path $audiosDir "audio_$i.wav"
    $i++
} while (Test-Path $audioOut)


ffmpeg -loglevel quiet -i $latestVideo.FullName -vn -acodec pcm_s16le -ar 44100 -ac 2 "$audioOut" 2>&1 | Out-Null
whisper $audioOut --model small --language Kazakh --output_format $outputFormat --output_dir $textsDir

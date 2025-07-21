$jsonData = Get-Content -Path ..\metadata.json -Raw | ConvertFrom-Json
$root = $jsonData.outputBasePath

if (-not (Test-Path -Path $root)) 
{
    New-Item -ItemType Directory -Path $root | Out-Null
}

foreach ($lang in $jsonData.languages) `
{
    $langPath = Join-Path $root $lang.name

    if (-not (Test-Path -Path $langPath)) 
    {
        New-Item -ItemType Directory -Path $langPath | Out-Null
    }

    $audiosPath = Join-Path $langPath "audios"
    $textsPath = Join-Path $langPath "texts"

    if (-not (Test-Path -Path $audiosPath)) 
    {
        New-Item -ItemType Directory -Path $audiosPath | Out-Null
    }

    if (-not (Test-Path -Path $textsPath)) 
    {
        New-Item -ItemType Directory -Path $textsPath | Out-Null
    }
}
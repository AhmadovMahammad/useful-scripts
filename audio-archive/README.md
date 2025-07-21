# AudioArchive

A PowerShell-based tool for extracting audio from video files and transcribing them using OpenAI's Whisper model. Designed for automatic processing of downloaded media files with organized output structure.

## Features

- Automatic audio extraction from MP4 files
- Speech-to-text transcription using Whisper AI
- Organized output structure by language and date
- Configurable language models and output formats
- Batch processing support

## Prerequisites

- Windows PowerShell 5.1 or later
- FFmpeg (for audio extraction)
- OpenAI Whisper (for transcription)

## Installation

[Reference](https://deepgram.com/learn/how-to-run-openai-whisper-in-command-line)

1. Install OpenAI Whisper:

   ```bash
   pip install git+https://github.com/openai/whisper.git

   # on Ubuntu or Debian
   sudo apt update && sudo apt install ffmpeg

   # on Arch Linux
   sudo pacman -S ffmpeg

   # on MacOS using Homebrew (https://brew.sh/)
   brew install ffmpeg

   # on Windows using Chocolatey (https://chocolatey.org/)
   choco install ffmpeg

   # on Windows using Scoop (https://scoop.sh/)
   scoop install ffmpeg
   ```

2. Clone this repository:
   ```bash
   git clone <repository-url>
   cd AudioArchive
   ```

## Configuration

1. Copy `metadata_example.json` to `metadata.json`
2. Edit `metadata.json` with your settings:

```json
{
  "outputBasePath": "C:/Users/username/Documents/ChatTranscripts",
  "downloadsPath": "C:/Users/username/Downloads/",
  "languages": [
    {
      "name": "kazakh",
      "isActive": true,
      "model": "medium"
    },
    {
      "name": "english",
      "isActive": false,
      "model": "small"
    }
  ],
  "outputFormat": "txt"
}
```

### Configuration Options

- `outputBasePath`: Directory where transcribed files will be saved
- `downloadsPath`: Directory to monitor for new MP4 files
- `languages`: Array of language configurations
  - `name`: Language identifier
  - `isActive`: Whether this language is currently active
  - `model`: Whisper model size (tiny, base, small, medium, large)
- `outputFormat`: Output format for transcriptions (txt, json, srt, vtt)

## Usage

### Initial Setup

Run the initialization script to create the directory structure:

```powershell
.\init.ps1
```

### Process Latest Video

Run the extraction and transcription script:

```powershell
.\extract-and-transcribe.ps1
```

## How It Works

1. **File Detection**: Scans the downloads directory for the latest MP4 file
2. **Audio Extraction**: Uses FFmpeg to extract audio as WAV format
3. **Transcription**: Processes the audio file through Whisper AI
4. **Organization**: Saves results in date-organized folders

## Directory Structure

The tool creates an organized folder structure:

```
OutputBasePath/
├── kazakh/
│   ├── audios/
│   │   └── 2025-07-17/
│   │       └── audio_1.wav
│   └── texts/
│       └── 2025-07-17/
│           └── audio_1.txt
└── english/
    ├── audios/
    └── texts/
```

## Instagram Audio Chat Download

To download Instagram audio chats:

1. Open Instagram in your browser
2. Go to Developer Tools (F12)
3. Navigate to Network tab
4. Filter by "Media"
5. Play the audio chat you want to download
6. Right-click on the audio file in Network tab
7. Select "Open in new tab" - this will automatically download the file

## Error Handling

The script includes validation for:

- Missing MP4 files in downloads directory
- FFmpeg installation verification
- Directory creation permissions
- File naming conflicts (automatic incrementing)

## Troubleshooting

**No MP4 files found**: Ensure MP4 files are present in the configured downloads directory.

**FFmpeg not found**: Install FFmpeg using Chocolatey or manually add it to your PATH.

**Permission errors**: Run PowerShell as Administrator if directory creation fails.

**Whisper errors**: Ensure Python and Whisper are properly installed and accessible from PATH.

## Credits

Thanks to Ulpan for motivating me to create this project.

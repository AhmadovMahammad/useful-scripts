## Project Structure Generator

This PowerShell script creates a clean text-based structure of your current project folder and
saves it into `project-structure.txt`.

### What It Does

- Walks through all folders and subfolders in your project.
- Excludes common build and temp folders like `bin`, `obj`, `.git`, `node_modules`, etc.
- Ignores useless files like `.dll`, `.log`, `.tmp`, `.exe`, `.pdb`, etc.

### Why I Made It

I was generating project folder structure by using 'tree /f' command,
but they included a lot of unwanted files like `bin`, `obj`, and other trash.
This script fixes that by filtering them out.

### How to Use

1. Open PowerShell in your project folder.
2. Run the script.
3. You'll get a `project-structure.txt` file with the cleaned-up structure.

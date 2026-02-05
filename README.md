# Copilot Instructions

A utility for sharing GitHub Copilot instructions across multiple repositories on Windows using symbolic links.

## Overview

This tool allows you to maintain a single source of truth for your Copilot instructions and share them across all your projects.

## Files

- `copilot-instructions.md` - Your centralized Copilot instructions
- `add.ps1` - PowerShell script to create symbolic links in target repositories

## Usage

Run the `add.ps1` script to create a symbolic link to `copilot-instructions.md` in any repository:

```powershell
.\add.ps1
```

This creates a symlink in your target repository that points back to the centralized instructions file, ensuring all repos use the same Copilot configuration.

## Benefits

- Single source of truth for Copilot instructions
- Easy updates - modify once, applies everywhere
- Consistent AI assistance across all projects

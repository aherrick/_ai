# add.ps1
# Creates/refreshes .github\copilot-instructions.md as a symlink to your shared file.
# Run from repo root.

$target = "C:\code\aherrick\_ai\copilot-instructions.md"
$link   = ".github\copilot-instructions.md"

if (-not (Test-Path $target))
{
    throw "Target file not found: $target"
}

New-Item -ItemType Directory -Force -Path ".github" | Out-Null

# Remove existing file/link if present
if (Test-Path $link)
{
    Remove-Item $link -Force
}

New-Item -ItemType SymbolicLink -Path $link -Target $target | Out-Null

# Verify
Get-Item $link | Select-Object FullName, LinkType, Target

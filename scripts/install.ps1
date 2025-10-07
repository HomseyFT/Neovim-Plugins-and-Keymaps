param(
  [ValidateSet("copy","junction")]
  [string]$Mode = "junction"
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot  = Split-Path $ScriptDir

# detects layout: either repo IS nvim or repo contains nvim/
$RootLooksLikeNvim = (Test-Path (Join-Path $RepoRoot "init.lua")) -or (Test-Path (Join-Path $RepoRoot "lua"))
if ($RootLooksLikeNvim) {
  $Src = $RepoRoot
} elseif (Test-Path (Join-Path $RepoRoot "nvim\init.lua")) {
  $Src = Join-Path $RepoRoot "nvim"
} else {
  throw "Could not find an nvim config at repo root or repo\ nvim\ ."
}

$Dst    = Join-Path $HOME "AppData\Local\nvim"
$Backup = Join-Path $HOME ("nvim_backup_{0:yyyyMMdd_HHmmss}" -f (Get-Date))

# if you're running this from the live path on local machine, don't nuke yourself
if ((Resolve-Path $Src).Path -eq (Resolve-Path $Dst).Path) {
  Write-Warning "Source and destination are the same ($Dst). Nothing to install here."
  Write-Host   "Use this script when setting up another machine, or migrate to Path B below."
  exit 0
}

if (Test-Path $Dst) {
  New-Item -ItemType Directory -Path $Backup -Force | Out-Null
  Write-Host "Backing up existing config to $Backup"
  Move-Item $Dst $Backup
}

switch ($Mode) {
  "copy"     { Write-Host "Copying $Src -> $Dst"; Copy-Item $Src $Dst -Recurse }
  "junction" { Write-Host "Creating junction: $Dst -> $Src"; New-Item -ItemType Junction -Path $Dst -Target $Src | Out-Null }
}

Write-Host "Done. Open Neovim and run :checkhealth"

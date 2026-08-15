$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$venvPath = Join-Path $repoRoot '.venv'
$pythonPath = Join-Path $venvPath 'Scripts\python.exe'

if (-not (Test-Path -LiteralPath $pythonPath)) {
    $pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
    if ($null -ne $pythonLauncher) {
        & $pythonLauncher.Source -3.11 -m venv $venvPath
    } else {
        $pythonCommand = Get-Command python -ErrorAction Stop
        & $pythonCommand.Source -m venv $venvPath
    }
}

& $pythonPath -m pip install --upgrade pip
& $pythonPath -m pip install --editable "${repoRoot}[dev]"

Write-Host "Installazione completata. Avvia con scripts\run-local.ps1"

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pythonPath = Join-Path $repoRoot '.venv\Scripts\python.exe'

if (-not (Test-Path -LiteralPath $pythonPath)) {
    throw 'Ambiente locale non trovato. Esegui prima scripts\install-local.ps1.'
}

& $pythonPath -m streamlit run (Join-Path $repoRoot 'src\heatpumps\hp_dashboard.py')

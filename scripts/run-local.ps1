$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pythonPath = Join-Path $repoRoot '.venv\Scripts\python.exe'

if (-not (Test-Path -LiteralPath $pythonPath)) {
    throw 'Ambiente locale non trovato. Esegui prima scripts\install-local.ps1.'
}

# Keep existing Streamlit sessions untouched and pick the first free local port.
$port = 8501
while (Get-NetTCPConnection -State Listen -LocalPort $port -ErrorAction SilentlyContinue) {
    $port++
}

Set-Location -LiteralPath $repoRoot
& $pythonPath -m streamlit run (Join-Path $repoRoot 'src\heatpumps\hp_dashboard.py') `
    --server.address localhost `
    --server.port $port

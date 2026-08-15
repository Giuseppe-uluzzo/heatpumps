# heatpumps

Simulazione stazionaria del dimensionamento e del funzionamento a carico
parziale di un'ampia raccolta di topologie di pompe di calore.

## Funzionalita principali

- Simulazioni di dimensionamento e carico parziale basate su [TESPy](https://github.com/oemof/tespy)
- Dashboard [Streamlit](https://github.com/streamlit/streamlit) con interfaccia italiana, inglese e tedesca
- Pompe di calore acqua-acqua e aria-acqua
- Topologie industriali e configurazioni in fase di ricerca e sviluppo
- Processi subcritici e transcritici
- Ampia scelta di refrigeranti grazie a [CoolProp](https://github.com/CoolProp/CoolProp)

## Installazione locale

Per lavorare sul codice in modo iterativo, usa Python 3.11 e installa il progetto
in modalita editable:

```powershell
conda create -n my_new_env python=3.11
conda activate my_new_env
python -m pip install -e .[dev]
```

In alternativa, lo script `scripts\install-local.ps1` crea automaticamente
l'ambiente `.venv` e installa il progetto editable.

### Avvio della dashboard

```powershell
heatpumps-dashboard
```

Oppure usa `scripts\run-local.ps1`. Le modifiche ai file Python vengono caricate
al riavvio della dashboard senza dover ricreare un eseguibile.

### Using the heat pump model classes

To use the heat pump model classes in your own scripts, you can import them as follows:

```python
from heatpumps.models import HeatPumpSimple, HeatPumpEconIHX
from heatpumps.parameters import get_params

# Simple cycle model
params = get_params('HeatPumpSimple')

params['setup']['refrig'] = 'R1234yf'
params['fluids']['wf'] = 'R1234yf'

params['C3']['T'] = 85  # feed flow temperature of heat sink
params['C1']['T'] = 50  # return flow temperature of heat sink

hp = HeatPumpSimple(params=params)

hp.run_model()
hp.generate_state_diagram(diagram_type='logph', savefig=True, open_file=True)

# Serial compression with closed economizer and internal heat exchanger
econ_type = 'closed'
params = get_params('HeatPumpEconIHX', econ_type=econ_type)

params['ihx']['dT_sh'] = 7.5  # superheating by internal heat exchanger

hp = HeatPumpEconIHX(params=params, econ_type=econ_type)

hp.run_model()
hp.perform_exergy_analysis(print_results=True)
```

## License

Copyright (c) 2021-2026 Jonas Freißmann and Malte Fritz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[![Streamlit App](https://static.streamlit.io/badges/streamlit_badge_black_white.svg)](https://heatpumps.streamlit.app/)

# heatpumps

Simulazione stazionaria del dimensionamento e del funzionamento a carico
parziale di un'ampia raccolta di topologie di pompe di calore.

## Funzionalita principali

- Simulazione stazionaria di dimensionamento e carico parziale basata su
  [TESPy](https://github.com/oemof/tespy)
- Parametrizzazione e visualizzazione dei risultati tramite dashboard
  [Streamlit](https://github.com/streamlit/streamlit)
- Supporto di topologie standard industriali e di configurazioni ancora in
  fase di ricerca e sviluppo
- Processi subcritici e transcritici
- Ampia scelta di refrigeranti grazie all'integrazione di
  [CoolProp](https://github.com/CoolProp/CoolProp)

## Per iniziare

Di seguito trovi le istruzioni essenziali per iniziare rapidamente con
*heatpumps*. Per maggiori informazioni consulta la
[documentazione online](https://heatpumps.readthedocs.io).

### Installazione

L'installazione di *heatpumps* e semplice con pip. Se usi
[Miniforge](https://github.com/conda-forge/miniforge), puoi creare e attivare
un ambiente pulito cosi:

```bash
conda create -n my_new_env python=3.11
```

```bash
conda activate my_new_env
```

Installa quindi *heatpumps* con:

```bash
python -m pip install heatpumps
```

Se vuoi lavorare su una versione modificabile del pacchetto, ad esempio per
contribuire al progetto o testare modifiche locali, clona il repository da
GitHub e usa:

```bash
python -m pip install -e .[dev]
```

Il flag `-e` rende effettive direttamente le modifiche locali; l'opzione
`[dev]` installa anche le dipendenze opzionali per lo sviluppo.

### Avviare la dashboard

Il pacchetto include un comando per avviare direttamente la dashboard:

```bash
heatpumps-dashboard
```

### Usare le classi dei modelli

Puoi importare le classi dei modelli di pompe di calore nei tuoi script in
questo modo:

```python
from heatpumps.models import HeatPumpSimple, HeatPumpEconIHX
from heatpumps.parameters import get_params

# Modello a ciclo semplice
params = get_params('HeatPumpSimple')

params['setup']['refrig'] = 'R1234yf'
params['fluids']['wf'] = 'R1234yf'

params['C3']['T'] = 85  # temperatura di mandata del pozzo termico
params['C1']['T'] = 50  # temperatura di ritorno del pozzo termico

hp = HeatPumpSimple(params=params)

hp.run_model()
hp.generate_state_diagram(diagram_type='logph', savefig=True, open_file=True)

# Compressione in serie con economizzatore chiuso e scambiatore interno
econ_type = 'closed'
params = get_params('HeatPumpEconIHX', econ_type=econ_type)

params['ihx']['dT_sh'] = 7.5  # surriscaldamento tramite scambiatore interno

hp = HeatPumpEconIHX(params=params, econ_type=econ_type)

hp.run_model()
hp.perform_exergy_analysis(print_results=True)
```

## Licenza

Copyright (c) 2021-2026 Jonas Freissmann and Malte Fritz

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

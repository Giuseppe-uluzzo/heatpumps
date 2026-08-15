"""Optional REFPROP integration for CoolProp-backed heat pump models."""

import os
from pathlib import Path

from CoolProp.CoolProp import ALTERNATIVE_REFPROP_PATH, set_config_string


_DEFAULT_ROOTS = (
    Path(r"C:\REFPROP"),
    Path(r"C:\Program Files\REFPROP"),
    Path(r"C:\Program Files (x86)\REFPROP"),
)


def find_refprop_root():
    """Return a REFPROP root from the environment or common Windows paths."""
    configured = os.environ.get("REFPROP_ROOT") or os.environ.get(
        "COOLPROP_REFPROP_ROOT"
    )
    candidates = (Path(configured),) if configured else _DEFAULT_ROOTS
    for root in candidates:
        if (root / "REFPRP64.DLL").is_file():
            return root
    return None


def configure_refprop():
    """Configure CoolProp to find REFPROP when a local installation exists."""
    root = find_refprop_root()
    if root is not None:
        set_config_string(ALTERNATIVE_REFPROP_PATH, str(root))
    return root


REFPROP_ROOT = configure_refprop()

# `data/` — input datasets

This directory holds the upstream `.rda` files consumed by the Quarto notebooks.
**These files are not committed to the repository** (they may be large and are
subject to redistribution restrictions). Each contributor must obtain them
locally.

## Expected files

| File | Used by | Description |
|:---|:---|:---|
| `asmr_nac.rda` | `index.qmd`, `es/A1`, `en/A1` | National age-standardised mortality rates |
| `asmr_cause.rda` | `es/A2`, `en/A2` | ASMR disaggregated by cause |
| `asmr_sc.rda` | `es/A3`, `en/A3` | ASMR for specific causes |
| `ratepopbycause.rda` | `es/A2` | Rates / population by cause |
| `top10_sc.rda` | `es/A3`, `en/A3` | Top-10 specific causes |
| `deces.rda` / `deces.rds` | `es/A5` | Deaths profile by cause |

## How to load them

Place the files here, then in each notebook's setup chunk use the relative path:

```r
load("data/asmr_nac.rda")
```

> ⚠️ Several source files currently call `load("H:/Mon Drive/...")`. Replace those
> hard-coded paths with the `data/...` relative form before rendering. See
> [CONTRIBUTING.md §2](../CONTRIBUTING.md#2-data--portable-loading-pattern).

## Sources

- **INEGI** — Instituto Nacional de Estadística y Geografía (SINAIS)
- **Secretaría de Salud / DGE** — Dirección General de Epidemiología

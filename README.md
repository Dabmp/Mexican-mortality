# Mortality in Mexico · Mexican-mortality

Multidimensional analysis of mortality in Mexico — a Quarto website presenting a
systematic, progressive exploration of mortality from 1990 to 2024, built on
administrative records (INEGI / Secretaría de Salud).

The site is **bilingual** (Spanish / English) and organised in three complementary
analytical blocks:

| Block | Theme | Levels |
|:---:|:---|:---|
| **A** | Epidemiological & temporal analysis | 5 — from global trends to maximum disaggregation |
| **B** | Regional disparities (spatial) | 3 — states, state clusters, municipalities |
| **C** | Life expectancy | 3 — national, by state, by municipality |

> Blocks **B** and **C** are currently under development; their entries are
> commented out in the navigation (`_quarto.yml`).

---

## Live site

The rendered site is published directly from the `docs/` directory of this
repository (static HTML, no server required). Open `docs/index.html` locally, or
serve it with any static file server.

---

## Repository structure

```
.
├── _quarto.yml                 # Quarto project config (website, navbar, sidebars, format)
├── index.qmd                  # Spanish landing page (root)
├── ES/                         # Spanish content (.qmd sources)
│   ├── index.qmd
│   ├── A1_descriptivo_general.qmd   … A5_maxima_desagregacion.qmd
│   ├── B1_regional.qmd              … B3_espacial_municipios.qmd
│   └── C1_regional_description.qmd  … C3_espacial_municipios.qmd
├── EN/                         # English content (.qmd sources)
│   ├── index.qmd
│   └── A1_descriptive_general.qmd … A5_maximum_disaggregation.qmd
├── assets/
│   └── custom.scss             # Theme overrides (fonts, colours, callouts)
├── docs/                       # Rendered website (HTML output, committed)
├── Mexican mortality.Rproj     # RStudio project file
└── .gitignore
```

### Source vs. rendered output

- **`.qmd`** files in `ES/`, `EN/` and the root are the **source** of the site.
- **`docs/`** contains the **rendered HTML** and supporting `site_libs/`
  assets. It is committed so the site can be viewed without rebuilding.

---

## Prerequisites

| Tool | Purpose | Install |
|:---|:---|:---|
| **R** ≥ 4.2 | Statistical computing | <https://cloud.r-project.org/> |
| **Quarto** ≥ 1.4 | Render `.qmd` → website | <https://quarto.org/docs/download/> |
| **RStudio** *(optional)* | Convenient editor; opens `Mexican mortality.Rproj` | <https://posit.co/downloads/> |

### R packages

The notebooks rely on the following packages. From an R session:

```r
install.packages(c(
  "tidyverse", "scales", "knitr", "kableExtra",
  "ggrepel", "patchwork", "RColorBrewer", "paletteer",
  "sf", "rnaturalearth", "tmap", "spdep"
))
```

> `rnaturalearth` may additionally require the `rnaturalearthdata` package for
> high-resolution geometries.

---

## Data

The notebooks load data from `.rda` files produced upstream (ASMR and cause-of-death
aggregations). The expected file names are:

- `asmr_nac.rda` — national ASMR
- `asmr_cause.rda` — by cause
- `asmr_sc.rda` — specific causes
- `ratepopbycause.rda`, `top10_sc.rda`, `deces.rda` / `deces.rds`

> ⚠️ **Important — portable data path.** Several source files currently contain a
> **hard-coded Windows path**, e.g.
> `load("H:/Mon Drive/Broni/Projet R Mortality/.../asmr_nac.rda")`.
>
> These paths are **machine-specific** and will not work for other contributors.
> To build the site locally, place the `.rda` files under a `data/` directory at the
> project root and switch each `load(...)` call to the relative form, e.g.:
>
> ```r
> load("data/asmr_nac.rda")
> ```
>
> The placeholder `load("data/asmr_nac.rda")` lines are already present (commented)
> in most setup chunks for reference. See [CONTRIBUTING.md](CONTRIBUTING.md) for
> the recommended approach.

---

## Build the site

From the project root:

```bash
# Render the whole website into docs/
quarto render
```

Or, to preview locally with live reload:

```bash
quarto preview
```

In RStudio, open `Mexican mortality.Rproj` then use the **Render** / **Serve**
button on any `.qmd` file.

The output is written to `docs/` (configured via `output-dir: docs` in
`_quarto.yml`).

---

## Project conventions

See **[CONTRIBUTING.md](CONTRIBUTING.md)** for:

- development setup & package installation,
- the recommended portable data-loading pattern,
- case-sensitivity notes on the `ES/` / `EN/` directories,
- bilingual content rules,
- rendering & commit conventions.

---

## Tech stack

- **Quarto** — document/website engine
- **R** + `{tidyverse}`, `{sf}`, `{tmap}` — analysis & cartography
- **SCSS** — theme customisation (`assets/custom.scss`)
- **Bootstrap** — provided by Quarto's `cosmo` theme

## Data sources

- **INEGI** — Instituto Nacional de Estadística y Geografía (SINAIS)

---

## License

See the repository metadata / `LICENSE` file if present. Data remain the property
of their respective producers (INEGI, Secretaría de Salud) and are used here for
analytical purposes.

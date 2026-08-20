# Contributing to Mexican-mortality

Thanks for your interest in improving this project. This document describes how to
set up the project locally, how the site is built, and the conventions to follow
when editing the content.

---

## 1. Development setup

### 1.1 Tools

| Tool | Minimum | Notes |
|:---|:---|:---|
| **R** | 4.2 | <https://cloud.r-project.org/> |
| **Quarto** | 1.4 | <https://quarto.org/docs/download/> |
| RStudio | *(optional)* | Open `Mexican mortality.Rproj` |

### 1.2 R packages

Install all required packages in one go:

```r
install.packages(c(
  "tidyverse", "scales", "knitr", "kableExtra",
  "ggrepel", "patchwork", "RColorBrewer", "paletteer",
  "sf", "rnaturalearth", "tmap", "spdep"
))
```

For `sf` on Linux you may need system libraries (GDAL, GEOS, PROJ). On Debian/Ubuntu:

```bash
sudo apt-get install -y libgdal-dev libgeos-dev libproj-dev
```

For high-resolution maps, also install the data companion:

```r
install.packages("rnaturalearthdata")
```

---

## 2. Data — portable loading pattern

### 2.1 The recommended pattern

1. Create a `data/` directory at the project root (it is `.gitignore`-d for large
   files — see below).
2. Place the upstream `.rda` files there:

   ```
   data/
   ├── asmr_nac.rda
   ├── asmr_cause.rda
   ├── asmr_sc.rda
   └── deces.rda
   ```

3. In every setup chunk, use the **relative** path:

   ```r
   load("data/asmr_nac.rda")
   ```

   The commented `# load("data/asmr_nac.rda")` lines already present in most setup
   chunks show the intended form — just uncomment and remove the `H:/...` line.

### 2.3 Why `data/` is not committed for the moment

Microdata and pre-computed aggregations can be large or subject to redistribution
restrictions. Keep `data/` local and document the expected file names in
[README.md](README.md#data) so others know which files to obtain.

---

## 3. Building the site

### 3.1 Render the whole website

```bash
quarto render
```

Output is written to `docs/` (configured in `_quarto.yml` → `output-dir: docs`).

### 3.2 Preview with live reload

```bash
quarto preview
```

### 3.3 Render a single page

```bash
quarto render es/A1_descriptivo_general.qmd
```

### 3.4 In RStudio

Open `Mexican mortality.Rproj`, then use the **Render** button on any `.qmd` file.
Use the **Serve** / **Preview** option to get a live site preview.

---

## 4. Bilingual content

The site is maintained in two parallel trees:

| Language | Directory | Landing page |
|:---|:---|:---|
| Spanish | `es/` | `es/index.qmd` (also mirrored at root `index.qmd`) |
| English | `en/` | `en/index.qmd` |

### 4.1 Keep both languages in sync

When you add or edit a section, **update both the `es/` and `en/` versions**.
Keep the same chunk labels and figure captions translated, so the rendered figures
match between languages.

### 4.2 Page metadata

Each `.qmd` starts with a YAML header. Set `lang` correctly:

- Spanish pages → `lang: es`
- English pages → `lang: en`

> ⚠️ Some Spanish pages currently declare `lang: en` in their YAML header (e.g.
> `es/A1_descriptivo_general.qmd`). Set it to `lang: es` for Spanish content.

---

## 5. Directory naming — `es/` / `en/`

The source directories use **lowercase** names: **`es/`** (Spanish) and **`en/`**
(English). The navigation in `_quarto.yml` references them with matching lowercase
hrefs:

```yaml
- href: es/index.qmd
- href: en/index.qmd
```

This is consistent with the rendered output in `docs/es/` and `docs/en/`, and works
on all filesystems (including case-sensitive Linux/CI). When adding new pages:

- Add new Spanish pages to `es/` and reference them as `es/<file>.qmd` in `_quarto.yml`.
- Add new English pages to `en/` and reference them as `en/<file>.qmd`.

Keep the directory casing **lowercase** to stay consistent with the existing
structure and the rendered output.

---

## 6. Theme & assets

The site theme is customised in [`assets/custom.scss`](assets/custom.scss).
It overrides:

- fonts (Source Sans 3, Playfair Display, JetBrains Mono — loaded via Google Fonts
  in `_quarto.yml` → `include-in-header`),
- colours (`$primary: #1a2744`, `$secondary: #2a7a8c`, `$accent: #e84855`),
- callout border colours,
- table and sidebar styling.

When changing colours, keep them consistent with the `palette_sexo` /
`palette_sex` vectors defined in the setup chunks (`#2a7a8c` men, `#e84855` women).

---

## 7. Conventions for figures & code

The global knitr options in `_quarto.yml` apply:

```yaml
knitr:
  opts_chunk:
    fig.width: 9
    fig.height: 5.5
    dpi: 150
    out.width: "100%"

execute:
  echo: false      # code hidden by default
  warning: false
  message: false
  cache: false
```

- **Code is folded** (`code-fold: true`) and the **code-tools** menu is enabled,
  so readers can inspect the source.
- Use **`fig.cap`** on every figure chunk — captions render below the figure.
- Use **`df-print: paged`** for interactive tables (already set globally).
- Use the `palette_sexo` (ES) / `palette_sex` (EN) vectors for sex colours so the
  site stays visually consistent.

---

## 8. Committing rendered output

The `docs/` directory **is committed** to the repository so the site can be viewed
without rebuilding. Therefore:

1. Re-render the site (`quarto render`) **after** changing any `.qmd` source.
2. Commit **both** the source (`.qmd`) and the rendered output (`docs/`) together.

```bash
quarto render
git add es/ en/ docs/
git commit -m "docs: update <page> in ES and EN"
```

Do not hand-edit files under `docs/` — regenerate them with Quarto.

---

## 9. Commit message style

Use a short, descriptive prefix in **English**:

- `docs:` — documentation / content changes
- `feat:` — new analytical page or section
- `fix:` — bug fix in a chunk or figure
- `style:` — theme / SCSS changes
- `chore:` — config, `.gitignore`, tooling

Example:

```
docs: add life-expectancy subsection to A5 (es/en)
```

---

## 10. Blocks status

| Block | Status |
|:---|:---|
| **A** (epidemiological) | Active — 5 levels rendered (ES + EN) |
| **B** (spatial) | Partial — ES pages exist; commented out in nav |
| **C** (life expectancy) | Stub pages only (placeholder `.qmd`) |

When un-commenting a block in `_quarto.yml`, make sure the referenced `.qmd` files
exist and render before committing.

---

## 11. Need help?

- Rendering issues → check Quarto version (`quarto --version`) and re-run
  `quarto render`.
- Missing R packages → see [§1.2](#12-r-packages).
- `load()` errors → you are hitting the hard-coded path; switch to `data/` (see
  [§2](#2-data--portable-loading-pattern)).

Thank you for contributing. 🇲🇽

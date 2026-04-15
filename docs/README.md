# Mortalidad en México — Site Quarto

Análisis multidimensional de la mortalidad en México.  
Architecture Quarto multi-pages, déployable sur GitHub Pages.

## Structure des fichiers

```
mortalidad-mexico/
├── _quarto.yml                    # Configuration globale du site
├── index.qmd                      # Page d'accueil + données simulées
│
├── assets/
│   └── custom.scss                # Thème académique sobre
│
├── A1_descriptivo_general.qmd     # Bloc A · Niveau 1
├── A2_causas.qmd                  # Bloc A · Niveau 2  ← exemple complet
├── A3_causas_especificas.qmd      # Bloc A · Niveau 3
├── A4_territorial.qmd             # Bloc A · Niveau 4
├── A5_maxima_desagregacion.qmd    # Bloc A · Niveau 5
│
├── B2_espacial_estados.qmd        # Bloc B · Niveau 2bis ← exemple complet
└── B3_espacial_municipios.qmd     # Bloc B · Niveau 3bis
```

## Prérequis R

```r
install.packages(c(
  "tidyverse", "scales", "knitr", "kableExtra",
  "ggrepel", "patchwork",
  "sf", "tmap", "RColorBrewer",
  "spdep"            # autocorrélation spatiale (optionnel)
))

# Pour télécharger les géométries officielles :
install.packages("rnaturalearth")
```

## Données réelles (INEGI / SSA)

Remplacez le chunk de données simulées dans `index.qmd` par :

```r
mort <- read_csv("data/mortalidad_mexico.csv")
```

Sources recommandées :
- **SINAIS** (Sistema Nacional de Información en Salud) : https://sinais.salud.gob.mx
- **INEGI** — Estadísticas de mortalidad : https://www.inegi.org.mx
- **Shapefiles** états : `rnaturalearth::ne_states(country="Mexico")`
- **Shapefiles** municipios : Marco Geoestadístico INEGI

## Rendu local

```bash
quarto render          # rend tout le site → docs/
quarto preview         # serveur local avec rechargement automatique
```

## Déploiement GitHub Pages

1. Dans `_quarto.yml` : `output-dir: docs`
2. Commit + push le dossier `docs/`
3. Dans GitHub → Settings → Pages → Source : `docs/`

```bash
quarto render
git add docs/
git commit -m "Render site"
git push
```

# agrobiodivR

Package R pour l'analyse de la biodiversité agraire et la connectivité des habitats dans les paysages agricoles.

## Table des matières

- [Description](#description)
- [Installation](#installation)
- [Sources de données](#sources-de-données)
- [Workflow complet](#workflow-complet)
- [Exemples détaillés et outputs](#exemples-détaillés-et-outputs)
- [Fonctions disponibles](#fonctions-disponibles)
- [Dépendances](#dépendances)
- [Références](#références)

---

## Description

**agrobiodivR** est un package R dédié à l'évaluation agroécologique des paysages agricoles. Il couvre l'ensemble de la chaîne analytique, depuis l'import des données de biodiversité terrain et d'occupation du sol jusqu'à la production de cartes, modèles prédictifs et rapports automatiques.

**Cas d'usage typique** : évaluation de la biodiversité, de la fragmentation et de la connectivité écologique d'un territoire agricole à partir de relevés de terrain (espèces, abondance, coordonnées GPS), de données d'occupation du sol (Corine Land Cover, ESA) et d'imagerie satellite (Sentinel-2).

---

## Installation

Depuis le dépôt GitHub :

```r
devtools::install_github("israeabm-dev/agrobiodivR")
```

Ou en mode développement (sans installation), depuis le dossier local du package :

```r
devtools::load_all()
```

---

## Sources de données

| Source | Données | Fonction |
|---|---|---|
| Terrain CSV / Excel | Espèces, abondance, parcelle, coordonnées GPS | `import_biodiversity_data()` |
| Corine Land Cover / ESA WorldCover | Occupation du sol (agriculture, forêt, prairie, urbain) | `import_landcover()` |
| Sentinel-2 / satellite | Imagerie pour analyse paysagère | `download_satellite_data()` |
| Raster occupation du sol | Distance aux habitats (forêt, haies) | `calculate_distance_to_habitat()` |

---

## Workflow complet

```text
import_biodiversity_data()       # import terrain : especes, abondance, GPS
import_landcover()                # occupation du sol (Corine / ESA / OSM)
download_satellite_data()         # imagerie satellite (optionnel)
|
calculate_diversity_indices()     # Shannon, Simpson, richesse par parcelle
calculate_landscape_metrics()     # fragmentation, diversite paysagere
calculate_distance_to_habitat()   # distances aux habitats naturels
|
analyze_connectivity()            # indice de connectivite, zones isolees
identify_ecological_corridors()   # corridors ecologiques potentiels
cluster_landscapes()              # classification des paysages (K-means)
|
train_rf_model()                  # Random Forest : biodiversite ~ paysage
evaluate_model()                  # RMSE, R2, importance des variables
|
plot_biodiversity_map()           # cartes biodiversite
plot_connectivity_map()           # cartes connectivite / corridors
generate_recommendations()        # recommandations de gestion
generate_agroeco_report()         # rapport HTML / PDF automatique
```

---

## Exemples détaillés et outputs

Tous les exemples ci-dessous utilisent le jeu de données d'exemple `biodiversity_sample`, fourni avec le package (6 parcelles, 10 espèces, coordonnées GPS situées dans la région de Rabat, Maroc).

### 1. Import des données de biodiversité

```r
library(agrobiodivR)

data("biodiversity_sample")
result <- import_biodiversity_data(data = biodiversity_sample)

head(biodiversity_sample)
```

Output :

```
 espece  abondance parcelle     lat     lon
 Trefle          8       P1 33.9299 -6.7779
   Pois         24       P1 33.9299 -6.7779
    Ble          3       P1 33.9299 -6.7779
 Sorgho         22       P1 33.9299 -6.7779
Luzerne         21       P1 33.9299 -6.7779
   Mais          2       P1 33.9299 -6.7779
```

```r
nrow(biodiversity_sample)
```

```
[1] 36
```

```r
class(result$spatial)
```

```
[1] "sf"         "data.frame"
```

---

### 2. Matrice communautés (parcelle x espece)

```r
head(result$community_matrix)
```

Output :

```
parcelle Avoine Ble Feverole Luzerne Mais Orge Pois Sorgho Tournesol Trefle
      P1      0   3        0      21    2    0   24     22         0      8
      P2     10   0       15       0   16    0   19     15         0      0
      P3      0   0       21      14    0    0    0      0         9     18
      P4      0  10        0       4   22    4    0      2         6     22
      P5     24  18       21       0   16   21   13     15         0      0
```

---

### 3. Indices de biodiversité (Shannon, Simpson, richesse)

```r
indices <- calculate_diversity_indices(result$community_matrix)
print(indices)
```

Output :

```
parcelle shannon simpson richness
      P1   1.513   0.753        6
      P2   1.590   0.793        5
      P3   1.342   0.729        4
      P4   1.645   0.767        7
      P5   1.926   0.852        7
      P6   1.608   0.758        7
```

---

### 4. Métriques paysagères

```r
metrics <- calculate_landscape_metrics(indices)
print(metrics)
```

Output :

```
mean_shannon sd_shannon mean_richness fragmentation
       1.604      0.191             6         0.211
```

---

### 5. Analyse de connectivité

```r
connectivity <- analyze_connectivity(result$spatial, max_distance = 8000)
print(connectivity)
```

Output :

```
parcelle connectivity isolated
      P1          0.6    FALSE
      P2          0.4    FALSE
      P3          0.6    FALSE
      P4          0.2     TRUE
      P5          0.4    FALSE
      P6          0.2     TRUE
```

Les parcelles **P4** et **P6** sont identifiées comme isolées (connectivité < 0.3).

---

### 6. Corridors écologiques potentiels

```r
corridors <- identify_ecological_corridors(result$spatial, max_distance = 8000)
nrow(corridors)
```

Output :

```
[1] 6
```

Corridors identifiés (distance entre centroïdes de parcelles) :

```
P1 -- P3 :   501.1 m
P4 -- P6 :  2320.1 m
P1 -- P2 :  6184.9 m
P2 -- P3 :  6073.3 m
P1 -- P5 :  6309.9 m
P3 -- P5 :  6585.1 m
```

---

### 7. Classification des paysages (K-means)

```r
clusters <- cluster_landscapes(metrics, k = 2)
print(clusters)
```

Output :

```
parcelle shannon richness connectivity cluster
      P1   1.513        6          0.6       1
      P2   1.590        5          0.4       0
      P3   1.342        4          0.6       0
      P4   1.645        7          0.2       1
      P5   1.926        7          0.4       1
      P6   1.608        7          0.2       1
```

Le clustering distingue un groupe de parcelles à diversité plus faible (P2, P3 — cluster 0) d'un groupe à diversité plus élevée (P1, P4, P5, P6 — cluster 1).

---

### 8. Modélisation Random Forest

```r
rf_result <- train_rf_model(
  data       = merged_data,
  target     = "shannon",
  predictors = c("fragmentation", "distance_habitat", "landcover_diversity")
)

rf_result$importance
```

Output :

```
           variable importance
   distance_habitat      0.442
      fragmentation      0.435
landcover_diversity      0.123
```

---

### 9. Évaluation du modèle

```r
performance <- evaluate_model(rf_result$model, test_data)
performance$performance
```

Output :

```
  RMSE     R2
 0.221  0.318
```

---

### 10. Recommandations de gestion

```r
recommendations <- generate_recommendations(metrics, connectivity)
recommendations
```

Output :

```
[1] "Fragmentation moderee (0.211) : surveiller l'evolution et maintenir les habitats semi-naturels existants."
[2] "Zones isolees detectees (2 parcelle(s)) : prioriser la creation de corridors vers ces zones."
[3] "Diversite moyenne (Shannon = 1.604) : diversifier les assolements pour ameliorer la biodiversite."
```

---

### 11. Cartographie

```r
plot_biodiversity_map(result$spatial, indices, index = "shannon")
plot_connectivity_map(result$spatial, connectivity, corridors = corridors)
```

Fichiers produits (si exportés via `ggplot2::ggsave()`) :

```
outputs/maps/biodiversity_shannon.png
outputs/maps/connectivity.png
```

---

### 12. Génération du rapport

```r
report_path <- generate_agroeco_report(
  indices, metrics, connectivity, corridors, recommendations,
  output_format = "html"
)
report_path
```

Output :

```
[1] "outputs/report.html"
```

---

## Fonctions disponibles

### Importation et préparation des données

| Fonction | Description |
|---|---|
| `import_biodiversity_data()` | Import des données de biodiversité terrain (CSV/Excel) : espèces, abondance, parcelle, GPS |
| `import_landcover()` | Import et reclassification des rasters d'occupation du sol (Corine, ESA, OSM) |
| `download_satellite_data()` | Téléchargement et préparation d'imagerie satellite pour la zone d'étude |

### Analyse de la biodiversité

| Fonction | Description |
|---|---|
| `calculate_diversity_indices()` | Calcul des indices Shannon, Simpson et richesse spécifique par parcelle |

### Analyse paysagère

| Fonction | Description |
|---|---|
| `calculate_landscape_metrics()` | Calcul des métriques paysagères simples (fragmentation, diversité) |
| `calculate_distance_to_habitat()` | Calcul des distances aux habitats naturels (forêt, haies) |
| `cluster_landscapes()` | Classification des paysages agricoles par K-means |

### Connectivité écologique

| Fonction | Description |
|---|---|
| `analyze_connectivity()` | Analyse de connectivité fonctionnelle et détection des zones isolées |
| `identify_ecological_corridors()` | Identification de corridors écologiques potentiels entre patches proches |

### Modélisation

| Fonction | Description |
|---|---|
| `train_rf_model()` | Entraînement d'un modèle Random Forest reliant biodiversité et paysage |
| `evaluate_model()` | Évaluation des performances du modèle (RMSE, R², importance des variables) |

### Aide à la décision et outputs

| Fonction | Description |
|---|---|
| `plot_biodiversity_map()` | Cartographie des indices de biodiversité |
| `plot_connectivity_map()` | Cartographie de la connectivité et des corridors |
| `generate_recommendations()` | Recommandations de gestion agroécologique automatiques |
| `generate_agroeco_report()` | Rapport HTML / PDF automatique (indices, métriques, corridors, recommandations) |

---

## Dépendances

```r
install.packages(c("sf", "ggplot2", "dplyr", "reshape2",
                   "vegan", "randomForest", "terra", "rmarkdown"))
```

---

## Références

- Shannon, C.E. & Weaver, W. (1949). The Mathematical Theory of Communication.
- Simpson, E.H. (1949). Measurement of diversity. Nature.
- Forman, R.T.T. (1995). Land Mosaics: The Ecology of Landscapes and Regions.
- McGarigal, K. & Marks, B.J. (1995). FRAGSTATS: Spatial Pattern Analysis Program for Quantifying Landscape Structure.
- Bennett, A.F. (2003). Linkages in the Landscape: The Role of Corridors and Connectivity in Wildlife Conservation.
- Office Européen Copernicus (Corine Land Cover, ESA WorldCover) — données d'occupation du sol.

---

Package développé par **Israe Ait Oubrahim** — projet académique, analyse de la biodiversité agraire et de la connectivité des habitats, 2026.

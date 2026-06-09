# agrobiodivR

## Overview

agrobiodivR is an R package developed for agricultural biodiversity analysis and habitat connectivity assessment.

The package provides tools to:

* Import biodiversity and land cover data
* Calculate biodiversity indices (Shannon, Simpson, Species Richness)
* Analyze agricultural landscapes
* Measure habitat fragmentation
* Assess ecological connectivity
* Identify potential ecological corridors
* Produce biodiversity and connectivity maps
* Generate ecological recommendations
* Create automated HTML reports
* Perform landscape clustering
* Train and evaluate Random Forest models

## Installation

```r
devtools::load_all()
```

## Example Dataset

```r
data("biodiversity_example")

head(biodiversity_example)
```

## Example

```r
data("biodiversity_example")

calculate_diversity_indices(
  biodiversity_example
)
```

## Main Functions

| Function                        | Description                         |
| ------------------------------- | ----------------------------------- |
| import_biodiversity_data()      | Import biodiversity data            |
| calculate_diversity_indices()   | Compute biodiversity indices        |
| import_landcover()              | Import land cover data              |
| calculate_landscape_metrics()   | Compute landscape metrics           |
| calculate_distance_to_habitat() | Measure ecological distances        |
| analyze_connectivity()          | Assess habitat connectivity         |
| identify_ecological_corridors() | Detect ecological corridors         |
| plot_biodiversity_map()         | Produce biodiversity maps           |
| plot_connectivity_map()         | Produce connectivity maps           |
| generate_recommendations()      | Generate ecological recommendations |
| generate_report()               | Create automated reports            |
| cluster_landscapes()            | Landscape clustering                |
| train_rf_model()                | Train Random Forest model           |
| evaluate_model()                | Evaluate model performance          |

## Data Sources

The package can be used with data from:

* ESA WorldCover
* Corine Land Cover
* OpenStreetMap
* Field biodiversity surveys

## Author

Israe Ait Oubrahim

## Project

Agricultural Biodiversity Analysis and Habitat Connectivity Assessment.


## Auteur

Israe Ait Oubrahim

## Projet

Analyse de la biodiversité agraire et connectivité des habitats.

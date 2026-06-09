# agrobiodivR

## Description

agrobiodivR est un package R dédié à l'analyse de la biodiversité agraire et à l'étude de la connectivité écologique des habitats.

Le package permet :

* l'importation de données biodiversité ;
* le calcul d'indices de diversité ;
* l'analyse paysagère ;
* l'évaluation de la connectivité écologique ;
* l'identification de corridors écologiques ;
* la visualisation cartographique ;
* la génération de recommandations ;
* la création de rapports automatiques ;
* l'analyse par clustering ;
* l'utilisation de modèles Random Forest.

## Installation

```r
devtools::load_all()
```

## Jeu de données d'exemple

```r
data("biodiversity_example")
head(biodiversity_example)
```

## Exemple d'utilisation

```r
data("biodiversity_example")

calculate_diversity_indices(
  biodiversity_example
)
```

## Auteur

Israe Ait Oubrahim

## Projet

Analyse de la biodiversité agraire et connectivité des habitats.

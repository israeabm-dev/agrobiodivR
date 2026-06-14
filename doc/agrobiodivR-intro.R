## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  fig.width  = 7,
  fig.height = 4
)

## ----load---------------------------------------------------------------------
library(agrobiodivR)

## ----import-biodiv------------------------------------------------------------
# Utilisation des données d'exemple intégrées
bd <- import_biodiversity_data()

# Structure retournée
str(bd, max.level = 1)

# Aperçu des données brutes
head(bd$raw_data)

## ----community-matrix---------------------------------------------------------
# Matrice de communautés (sites x espèces)
bd$community_matrix[1:5, 1:4]

## ----diversity-indices--------------------------------------------------------
indices <- calculate_diversity_indices(bd$community_matrix)
print(indices)

## ----plot-shannon-------------------------------------------------------------
library(ggplot2)
ggplot(indices, aes(x = reorder(parcelle, shannon), y = shannon, fill = shannon)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_viridis_c(option = "D") +
  labs(title  = "Indice de Shannon par parcelle",
       x      = "Parcelle",
       y      = "H' (Shannon)",
       fill   = "H'") +
  theme_minimal()

## ----import-lc----------------------------------------------------------------
# Raster simulé directement dans la vignette
library(terra)
lc <- rast(nrows=20, ncols=20, xmin=-5.5, xmax=-1.0, ymin=33.0, ymax=36.0)
set.seed(42)
values(lc) <- sample(1:5, ncell(lc), replace=TRUE, prob=c(0.5,0.2,0.15,0.1,0.05))
names(lc) <- "landcover"
terra::plot(lc, main = "Occupation du sol (exemple simulé)",
            col = c("gold", "darkgreen", "lightgreen", "grey60", "steelblue"))

## ----landscape-metrics--------------------------------------------------------
metrics <- calculate_landscape_metrics(lc)
knitr::kable(metrics, digits = 3, caption = "Métriques paysagères globales")

## ----distance-----------------------------------------------------------------
dist_result <- calculate_distance_to_habitat(lc, bd$sf_object)
terra::plot(dist_result$distance_raster,
            main = "Distance aux habitats naturels (m)",
            col  = hcl.colors(100, "YlOrRd", rev = TRUE))

## ----connectivity-------------------------------------------------------------
conn <- analyze_connectivity(lc, max_distance_m = 300)
cat("Indice de connectivité :", conn$connectivity_index, "\n")
print(conn$summary)

## ----cluster------------------------------------------------------------------
# Créer plusieurs zones simulées pour le clustering
set.seed(42)
metrics_multi <- data.frame(
  zone           = paste0("Z", 1:20),
  fragmentation  = runif(20, 0.1, 2.0),
  shannon_paysage = runif(20, 0.5, 1.5),
  prop_naturel   = runif(20, 0.05, 0.60),
  prop_agriculture = runif(20, 0.20, 0.70),
  prop_urbain    = runif(20, 0.01, 0.20)
)

clustered <- cluster_landscapes(metrics_multi, n_clusters = 3)

ggplot(clustered, aes(x = prop_naturel, y = shannon_paysage,
                       color = factor(cluster), size = fragmentation)) +
  geom_point(alpha = 0.8) +
  labs(title  = "Clusters de paysages agricoles",
       x      = "Proportion habitats naturels",
       y      = "Shannon paysager",
       color  = "Cluster",
       size   = "Fragmentation") +
  theme_minimal()

## ----rf-model-----------------------------------------------------------------
# Construire un jeu de données complet pour la modélisation
set.seed(42)
model_data <- data.frame(
  shannon        = indices$shannon[match(paste0("Z", 1:20), clustered$zone)] %||% runif(20, 0.3, 2.0),
  fragmentation  = clustered$fragmentation,
  prop_naturel   = clustered$prop_naturel,
  prop_agriculture = clustered$prop_agriculture,
  shannon_paysage = clustered$shannon_paysage
)
model_data$shannon <- runif(20, 0.3, 2.0)  # données simulées

rf_result <- train_rf_model(model_data, target = "shannon", ntree = 200)
print(rf_result$importance)

## ----session------------------------------------------------------------------
sessionInfo()


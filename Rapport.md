# Rapport

## Introduction

## Le choix du sujet

Paradoxalement, l'étape qui s'est avérée la plus difficile est celle-ci, le choix du sujet. C'est l'une des rares fois où nous avons la lattitude de choisir le sujet sur lequel on va travailler et cette expérience était pour le moins troublante. En effet, c'est un choix qui selon nous était crucial/déterminant dans la qualité de notre rendu final. Il nous fallait d'abord un dataset pour lequel une implémentation graphe était pertinente. Aussi, ce dataset devait être assez dense, parlant et vivant pour que l'on puisse utiliser l'analytique de graphe. Nous ne voulions pas utiliser des algorithmes de graphes pour le simple plaisir de les utiliser mais on voulait plutôt que ça ait du sens, qu'on réponde à de réelles questions. Pour ces raisons, et d'autres encore, cette étape est celle qui a été la plus difficile. 

## Netflix Movie Rating Dataset

Après des journées de recherche de sujets un peu partout sur le web, notre attention s'est concentrée sur les datasets qui permettraient de faire des recommandations. Au final, nous avons choisi le Netflix Movie Rating Dataset sur Kaggle. C'est un dérivé du dataset qui a été utilisé dans le Netflix Prize, une compétition ouverte où il fallait trouver le meilleur algorithme possible pour prédire les ratings qu'un utilisateur donné allait donner à un film. 

Ce dataset est disponible ici : https://www.kaggle.com/datasets/rishitjavia/netflix-movie-rating-dataset?select=Netflix_Dataset_Movie.csv 


## Pistes 

### Enrichissement du dataset 

- [] Générer des noms/prénoms pour les utilisateurs
- [] Trouver les genres, acteurs, producteurs, des différents films pour pouvoir les inclure dans notre analyse 


### Machine Learning 

#### Apprentissage non-supervisé

- [] Essayer de grouper les utilisateurs en fonctions de leurs "goûts". (k-means, etc)
- [] Trouver les films qu'un utilisateur est susceptible d'aimer

#### Apprentissage supervisé

- [] Essayer de prédire la note donnée par un utilisateur à un certain film (découpage préalable du dataset) (k-nn, etc)

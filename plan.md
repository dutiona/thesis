Rappel sur les commentaires/questions :

1. Comment mesurer/évaluer l'utilisabilité de la bibliothèque
2. Le modèle WebAssembly peut-il être intéressant dans un contexte dynamique avec des performances requises


Plan

1. ~~Remerciements~~ (uniquement dans le version finale)
2. Résumé
3. Sommaire
4. Indexes/Liste des abbrv/glossaire


Contenu

# Contexte et motivaton

1. Domaines du TI et besoins par domaine
2. Profils des utilisateurs et besoins en fonction des profils
   Intégrateur/Développeur vs Praticien
3. Contexte du LRDE (Expériences de Olena & spécialisation en Morph. Math, Topo. Discrète), définitions de nos besoins spécifiques
   (outils pour l'expérimentation, outils pour l'éducation, outils pour le logiciel de production)
4. Définitions du périmètre de la bibliothèque et de ses objectifs:

    * Performance
    * Facile d'utilisation (UX client)
    * Facile de développement (Core developer xp)
    * Versatilité des types d'images
    * Utilisable depuis Python,Orientée MM)


# Etat de l'art

1. Les différentes façon d'atteindre la généricité

   * Approches de la généricité dans les bibliothèques
   * Approches de la généricité dans les langages


2. La généricité en C++ pre-11

    * SCOOP

3. La généricité en Modern C++


4. Les templates C++ dans un monde dynamique

   * SWILENA
   * VCSN
   * VIGRA
   * Cython
   * cppyy


# Taxonomie des images/algo

* Définitions des types/catégories de types/propriétés de types
* Value/Ref semantics des images
* Relation Image (n) <-> Implem (m)
  avec n >> m
  * Plusieurs algos pour le même opérateur
  * Plusieurs implems pour le même algo
* Vision ensembliste des types d'images/algo

# Les vues d'images

* Comment préserver les propriétés
* Évaluation paresseuse
* Composabilité
* ...
* Performances + Bench

# Pont statique dynamique

* ...


# Conclusion









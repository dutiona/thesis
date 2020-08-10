# Plan manuscrit

## Rappel sur les commentaires/questions

1. Comment mesurer/évaluer l'utilisabilité de la bibliothèque
2. Le modèle WebAssembly peut-il être intéressant dans un contexte dynamique avec des performances requises

## Chapitres

1. ~~Remerciements~~ (uniquement dans le version finale)
2. Résumé
3. Sommaire
4. Indexes/Liste des abbrv/glossaire
5. Introduction
6. Contexte et motivation
7. La Généricité (état de l'art)
8. Taxonomie des images et algorithmes
9. Les vues d'image
10. Pont statique-dynamique
11. Discussion + Conclusion
12. Bibliographie + annexes

## Contenu

### Introduction

* Définition, sujet, contexte d'étude -> reprendre texte de ma thèses en 3 mn
* Question de départ, problématique -> généricité + traitement d'images
* Présentation rapide de la méthodologie -> génie logiciel bas niveau dans le but de remonter haut niveau pour utilisateur TI
* Objectif et plan
* Justification de l'étude

### Contexte et motivaton

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
    * Utilisable depuis Python, Orientée MM

### La Généricité (état de l'art)

1. Les différentes façon d'atteindre la généricité

   * Approches de la généricité dans les bibliothèques
   * Approches de la généricité dans les langages

2. La généricité en C++ pre-11

    * explications techniques bas niveau, SFINAE
    * aboutissement à SCOOP -> synthèse et explication des travaux précédents sur SCOOP

3. La généricité en Modern C++, C++11 et C++20 (concepts)

   * post C++11 :
      * simplification d'écriture du SFINAE (variadic, traits)
      * if constexpr (c++14), lambda auto
      * apports du C++17 pour simplifier encore : folds, template deduction guides, visit/overload for variant, any, template <auto V> struct S
      * apports du C++20 : concepts, ranges
   * montrer des exemples de simplification de code
   * faire des bench de temps de compilation (flagrant quand passage du SFINAE aux concepts)

4. Les templates C++ dans un monde dynamique

   * rapide rappel pros./cons. language compilés vs. languages interprétés
   * rappel template C++ -> pas de binaire
   * faire un topo sur la problématique de distribution de binaire et/ou de compilation chez le client pour un code générique
   * passer en revue les solutions existantes :
      * SWILENA
      * VCSN
      * VIGRA
      * Cython
      * cppyy

### Taxonomie des images et algorithmes

* Définitions des types/catégories de types/propriétés de types
* Value/Ref semantics des images
* Conceptualisation expliquer par l'exemple (papier rrpr) la relation Image (n) <-> Implem (m) avec n >> m
  * Concepts déduis des algorithmes et non des types
  * Plusieurs algos pour le même opérateur
  * Plusieurs implems pour le même algo
* Vision ensembliste des types d'images/algo
  * versions d'algorithmes
  * spécialisations d'algorithmes
* canvas d'algorithmes
  * factorisation
  * opportunités d'optimisation (utilisation de propriétés, parallélisation)
* listing et explications des concepts de la bibliothèque (images, élément structurant)

### Les vues d'images

* origine, parallèle avec range-v3
* Comment préserver les propriétés
* Évaluation paresseuse
* Composabilité/chaînage
* ...
* Performances + Bench

### Pont statique-dynamique

* rappel de la problématique (backward ref depuis Généricité/4.)
* expliquer l'approche hybride (son design et les techniques de dispatch n*n avec variants)
* bench, trade-off
* continuité sur JIT avec autowig, cppyy (perspective)

### Conclusion et perspectives

* Synthèse générale
* Réponse à la problématique d'Introduction
* confrontation à d'autres travaux de recherche ayant donné naissance à une bibliothèque de TI
* Ouvertures, perspectives, limites
  * continuité JIT
  * ce qu'il reste à faire

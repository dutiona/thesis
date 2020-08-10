Plan manuscrit
===
* Page de garde
* Remerciements
* Résumé + mots clés
* Sommaire, index des figures/Tableaux, 
* Abréviations, 
* Glossaire

Introduction
--- 

* Définition, sujet, contexte d'étude -> reprendre texte de ma thèses en 3 mn
* Question de départ, problématique -> généricité + traitement d'images
* Présentation rapide de la méthodologie -> génie logiciel + traitement d'image
* Objectif et plan -> 2 axes GL+TI
* Justification de l'étude
 
 
Domaines de la recherche
---

* Cadre théorique
* orientation -> expliquer toutes les ramifications, ce qui sera traité, ignoré
* Synthèse bibliographique, état de l'art ->  à inclure dans le fil


Approche Génie Logiciel
---

Problème et méthode
___

Problématique, hypothèse, méthodologie, technique

* Généricité C++ pas lisible, Très lourd en syntaxe,
* Apport C++ 20, Concepts,
* Taxonomie des images et concepts,
* Techniques : versions d'algo, spécialisation d'algo, canevas d'algo
* Ranges, Vues, chainage, évaluation paraisseuse

Analyse des résultats
___

Expériences (benchmarks), analyse, comparaison
* Analyse des benchs
* comparaison avec d'autres bibliothèques
* discussions
* apport à la communauté GL sur les travaux et méthodes de design (vues, chainage, ranges, …)


Liaison
---

* Généricité pas très accessible pour prototypage rapide car lourd
* Accessible depuis python, pas de binaire : Pont statique - dynamique
* Design, difficultés/trade-off
* approches disponibles, choisies (hybride)
* résultats et performances
* bench Pylene vs OpenCV vs skimage, discussions
* améliorations, JIT ?

Approche Traitement d'Image
---

* But d'un TI practitioner : avoir des outils perforants composables,
  disponibles pour du prototypage rapide qui marche avec des standards du marché.
* Expliquer en quoi cette thèse à Pylène, offre une solution à tous ces problèmes.
  Utiliser beaucoup de dessins, code morpho-math.

Discussion + Conclusion
---

* Synthèse générale
* Réponse à la problématique d'Introduction
* confrontation à d'autres travaux de recherche ayant donné naissance à une bibliothèque de TI
* Ouvertures, perspectives, limites

Bibliography
---
* esayer d'avoir 50% des sources à - de 5 ans 

Annexes
---

* internes au manuscrit (index, table, figure, glossaire)
* externe au manuscrit (pas applicable ?)


Liste des papiers étudiés récement
===

* stroustrup.1999.hot
* stroustrup.2007.hopl
* perret.2019.higra
* xu.2015.pami
* meyer.2009.ismm
* carlinet.2014.tip
* carlinet.2015.tip
* kothe.2011.generic
* jarvi.2006.specialization-article
* iglberger.2012_1.blaze
* gibbons.2007.datatype
* garrigues.2014.video++
* czarnecki.2000.generative
* brown.2019.heterogeneous

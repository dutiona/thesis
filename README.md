# Generic Programming in modern C++ for Image Processing

[![Continuous Integration](https://github.com/dutiona/thesis/actions/workflows/ci.yaml/badge.svg)](https://github.com/dutiona/thesis/actions/workflows/ci.yaml)

## Abstract

C++ is a multi-paradigm language that enables the initiated programmer to set up efficient image processing algorithms. This language strength comes from several aspects. C++ is high-level, which enables developing powerful abstractions and mixing different programming styles to ease the development. At the same time, C++ is low-level and can fully take advantage of the hardware to deliver the best performance. It is also very portable and highly compatible which allows algorithms to be called from high-level, fast-prototyping languages such as Python or Matlab. One of the most fundamental aspects where C++ really shines is generic programming. Generic programming makes it possible to develop and reuse bricks of software on objects (images) of different natures (types) without performance loss. Nevertheless, conciliating the aspects of genericity, efficiency, and simplicity is not trivial. Modern C++ (post-2011) has brought new features that made the language simpler and more powerful. In this thesis, we first explore one particular C++20 aspect: the concepts, in order to build a concrete taxonomy of image related types and algorithms. Second, we explore another addition to C++20, ranges (and views), and we apply this design to image processing algorithms and image types in order to solve issues such as how hard it is to customize/tweak image processing algorithms. Finally, we explore possibilities regarding how we can offer a bridge between static (compile-time) generic C++ code and dynamic (runtime) Python code. We offer our own hybrid solution and benchmark its performance as well as discuss what can be done in the future with JIT technologies. Considering those three axes, we will address the issue regarding the way to conciliate generic programming, efficiency and ease of use.

## Keywords: Image Processing ; modern C++ ; Genericity ; Performance ; Concepts ; Mathematical morphologie

## Résumé

C++ est un langage de programmation multi-paradigme qui permet au développeur initié de mettre au point des algorithmes de traitement d'images. La force de langage se base sur plusieurs aspects. C++ est haut-niveau, cela signifie qu'il est possible de développer des abstractions puissantes mélangeant plusieurs styles de programmation pour faciliter le développement. En même temps, C++ reste bas-niveau et peut pleinement tirer partie du matériel pour fournir un maximum de performances. Il est aussi portable et très compatible ce qui lui permet de se brancher à d'autres langages de haut niveau pour le prototypage rapide tel que Python ou Matlab. Un des aspects les plus fondamentaux où le C++ brille, c'est la programmation générique. La programmation générique rend possible le développement et la réutilisation de briques logiciel comme des objets (images) de différentes natures (types) sans avoir de perte au niveau performance. Néanmoins, il n'est pas trivial de concilier les aspects de généricité, de performance et de simplicité d'utilisation. Le C++ moderne (post-2011) amène de nouvelles fonctionnalités qui le rendent plus simple et plus puissant. Dans cette thèse, nous explorons en premier un aspect particulier du C++20 : les concepts, dans le but de construire une taxonomie des types relatifs au traitement d'images. Deuxièmement, nous explorons une autre fonctionnalité ajoutée au C++20 : les ranges (et les vues). Nous appliquons ce design aux algorithmes de traitement d'images et aux types d'image, dans le but résoudre les problèmes liés, notamment, à la difficulté qu'il existe pour customiser les algorithmes de traitement d'image. Enfin, nous explorons les possibilités concernant la façon dont il est possible de construire un pont entre du code C++ générique statique (compile-time) et du code Python dynamique (runtime). Nous fournissons une solution hybride et nous mesurons ses performances. Nous discutons aussi les pistes qui peuvent être explorées dans le futur, notamment celles qui concernent les technologies JIT. Etant donné ces trois axes, nous voulons résoudre le problème concernant la conciliation des aspects de généricité, de performance et de simplicité d'utilisation.

## Mots clés: Traitement d'images ; C++ moderne ; Généricité ; Performance ; Concepts ; Morphologie mathématique

## Ph.D. Defense

Michaël Roynard <michael.roynard@epita.fr>

Friday 4th Novembre 2022 at 9:30 am

EPITA, 14-16 Rue Voltaire, 94270 Le Kremlin-Bicêtre

Amphi 0 (Building Voltaire)

## Composition du Jury

### Rapporteurs

* Pr. Benjamin Perret, ESIEE / LIGM / Université Gustave Eiffel
* Pr. Pascale Le Gall, CentraleSupélec / Université Paris Saclay

### Examinateurs

* Pr. Hugues Talbot, CentraleSupélec / Université Paris Saclay
* Pr. Laurent Najman, ESIEE / LIGM / Université Gustave Eiffel
* Dr. Camille Kurtz, LIPADE / SIP Lab / Université Paris Cité
* Dr. Joël Falcou, LRI / Université Paris Saclay

### Directeur

* Pr. Thierry Géraud, EPITA, LRE

### Encadrant

* Dr. Edwin Carlinet, EPITA, LRE

## Citation

```latex
@PhDThesis{	 roynard.22.phd,
  author	= {Micha\"{e}l {R}oynard},
  title		= {Generic Programming in modern {C}++ for Image Processing},
  school	= {Sorbonne Universit\'e},
  year		= 2022,
  address	= {Paris, France},
  month		= nov,
  abstract	= {C++ is a multi-paradigm language that enables the initiated programmer to set up efficient image
               processing algorithms. This language strength comes from several aspects. C++ is high-level, which
               enables developing powerful abstractions and mixing different programmingstyles to ease the development.
               At the same time, C++ is low-level and can fully take advantage of the hardware to deliver the best
               performance. It is also very portableand highly compatible which allows algorithms to be called from
               high-level, fast-prototyping languages such as Python or Matlab. One of the most fundamental aspects
               where ++ really shines is generic programming. Generic programming makes it possible to develop and reuse
               bricks of software on objects (images) of different natures (types)without performance loss.
               Nevertheless, conciliating the aspects of genericity, efficiency, and simplicity is not trivial. Modern
               C++ (post-2011) has brought new featuresthat made the language simpler and more powerful. In this thesis,
               we first explore one particular C++20 aspect: the concepts, in order to build a concrete taxonomy of image
               related types and algorithms. Second, we explore another addition to C++20, ranges (and views), and we
               apply this design to image processing algorithms and image types in order to solve issues such as how
               hard it is to customize/tweak image processing algorithms. Finally, we explore possibilities regarding
               how we can offer a bridge betweenstatic (compile-time) generic C++ code and dynamic (runtime) Python
               code. We offer our own hybrid solution and benchmark its performance as well as discuss what can be done
               in the future with JIT technologies. Considering those three axes, we will address the issue regarding
               the way to conciliate generic programming, efficiency and ease of use.}
}
```

## Links

![Résumé long (FR)](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/resume_long.pdf)

![Long summary(EN)](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/long_summary.pdf)

![Thesis manuscript](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/manuscript.pdf)

![Slides](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/slides.pdf)

![Handout](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/handout.pdf)

<!--
![Résumé long (FR)](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/resume_long.pdf)

![Long summary(EN)](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/long_summary.pdf)

![Thesis manuscript](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/manuscript.pdf)

![Slides](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/slides.pdf)

![Handout](http://mroynard.pages.lre.epita.fr/roynard.thesis.manuscript/handout.pdf)
-->

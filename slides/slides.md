---
title: Generic programming in modern C++ for \newline Image Processing
author: Michaël Roynard \newline
  {\scriptsize Supervision Edwin Carlinet} \newline
  {\scriptsize Direction Thierry Géraud} \newline
  {\tt\scriptsize firstname.lastname@epita.fr}
date: Thesis Defense --- \displaydate{dateSoutenance}
  \newline Le Kremlin Bicêtre, France
institute: EPITA Research & Development Laboratory (LRDE) \newline
 ![](../images/EDITE.png){width=1.8cm} $~~~~~$ ![](../images/epita.pdf){width=2cm} $~~~~~$
 ![](../images/lrde-big.png){width=2cm} $~~~~~$ ![](../images/Logo_of_Sorbonne_University.pdf){width=2.5cm}
controls: false
slideNumber: true
transition: none
output: pdf_document
bibliography: ../bibliography.bib
width: 1080
height: 810
#theme: white

header-includes:
- \usepackage[svgnames]{xcolor}

---

# Outline

## Table of content

* General Introduction
* Context and history of Generic Programming
  * Problem we are solving
  * A brief history
* Generic Programming for Image Processing
  * Taxonomy for Image processing: introducing Concepts
  * Introducing Image Views
* Bringing Genericity to the dynamic world
  * A bridge between the static and dynamic world
  * Continuation
* General Conclusion

# General Introduction

## Image processing nowadays

* Image processing is everywhere, in every device.
* Applications are multiples.
* Every industry and research domain is using it.

<!-- FIXME: add illustrating figure -->

## Introducing Genericity for Image processing

Algorithm must support combination whose cardinality increases with:

::: columns

:::: column
* supported underlying image type (grayscale, rgb, floating-point)
* supported data structure (ND-buffers, graphs, meshes)
* additional data type (structuring element, label maps)
::::

:::: column
![Specter of possibilities\label{specter-possibilities}](../figures/possibility_space.pdf)
::::

:::

# Context and history of Generic Programming

## History

<!-- FIXME: add illustrating figure -->

## Genericity within Libraries

* Code duplication
* Generalization
* Polymorphism (inclusion & parametric)

### Code duplication

### Generalization

### Inclusion Polymorphism

### Parametric Polymorphism

## Genericity within Programming languages

### History

* CLU
* ADA
* C++

### C++: pre-2011 (pre C++11)

* metafunctions, type-traits
* SFINAE
* CRTP

### C++: post-2011 (C++20 & Concepts)

* Writing a concept
* Simplifying code

## Limitations: C++ templates in the dynamic world

* Static templates does not mix well with dynamic code (such as Python).

# Generic Programming for Image Processing

# Bringing (static) Genericity to the dynamic world

# General Conclusion

## Conclusion

## Continuation

# References

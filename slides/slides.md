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
output:
  beamer_presentation:
    slide_level: 2
    toc: true
#footer: Michaël Roynard --- Thesis Defense --- \displaydate{dateSoutenance}
bibliography: ../bibliography.bib
width: 1080
height: 810
#toc: true
#slide_level: 2
#theme: white
header-includes:
- \usepackage[svgnames]{xcolor}


---

## Overview

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


<!-- BEGIN INTRODUCTION -->

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

<!-- END INTRODUCTION -->

<!-- BEGIN PART 1: H&C of CP- ->

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

<!-- END PART 1:  H&C of CP -->

<!-- BEGIN PART 2: GP FOR IP -->

# Generic Programming for Image Processing 

## Taxonomy for Image Processing

### Conceptification

### Taxonomy of Image Processing Algorithms

### Taxonomy of Image Types

## Our Concepts for Image Processing

### Fundamentals

### Advanced

### Support for local algorithms

## Views for Image Processing

### Introducing Image Views

### Properties

### Usage for border management

### Limitations: traversing

### Performance discussion

<!-- END PART 2: GP FOR IP -->

# Bringing (static) Genericity to the dynamic world

## Reminder about Compiled & Interpreted languages

### Compiled languages

### Interpreted languages

### Hybrid languages

### Summary

## Information that is static and/or dynamic

## Designing an Hybrid solution

### Step 1: converting back and forth

### Step 2: multi-dispatcher ($\protect n \times n$ dispatch)

### Step 3 : type-erasure & value-set

### Performance discussion

# General Conclusion

## Conclusion

## Continuation

# References

---
title: Generic programming in modern C++ for Image Processing
author: Michaël Roynard & Edwin Carlinet & Thierry Géraud\newline
 {\tt\scriptsize firstname.lastname@lrde.epita.fr}
date: \displaydate{dateSoutenance} --- Thesis Defense --- Le Kremlin Bicêtre, France
institute: EPITA Research & Development Laboratory (LRDE)  \newline
 ![](../images/epita.pdf){width=2cm} $~~~~~$ ![](../images/lrde-big.png){width=2.5cm}
controls: false
slideNumber: true
transition: none
width: 1080
height: 810
#theme: white

header-includes:
- \usepackage[svgnames]{xcolor}

---

# Title 1

## Slide 1

Content slide 1

* test
* test
* test

# Title 2

## Slide 2

* Blablabla
* Blablabla
* Blablabla

\scriptsize
```cpp
for (auto&& pix : ima.pixels())
  pix.val() = pix.val() < 125 ? 0 : 255;
```

## slide 3

* Blablabla
* Blablabla
* Blablabla

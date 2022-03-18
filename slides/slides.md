---
title: A Modern C++ Library for Generic and Efficient Image Processing
author: Thierry Géraud & Edwin Carlinet \newline
 {\tt\scriptsize firstname.lastname@lrde.epita.fr}
date: 2018/06/20 --- GT GDMM --- Lyon, France
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


# Forewords


## A common untruth

If you need to process some particular images: 
\smallskip

\small
* \purpletext{parts of images, whatever their shape; e.g. non-rectangular...}\vspace*{-.2em}
* \purpletext{images with uncommon value types; e.g. functions, tensors...}\vspace*{-.2em}
* \purpletext{images with a particular geodesy; e.g. cylinder, torus...}\vspace*{-.2em}
* \purpletext{3D images}\vspace*{-.2em}
* \purpletext{videos; e.g. 2D+t, and why not 3D+t, or "whatever+t"}\vspace*{-.2em}
* \purpletext{graphs; e.g. vertex-valued, edge-valued...}\vspace*{-.2em}
* \purpletext{meshes}\vspace*{-.2em}
* \purpletext{complexes}\vspace*{-.2em}
* \purpletext{...}

\smallskip

\normalsize
it is **not** normal that your tool **cannot** do it



# From Milena to Pylena


## Key ideas of the Milena library

* Context: MM then DT (...DG) + software engineering \& C++

* Dedicated to image processing, including many MM tools
\smallskip

* An image is a _function_: $~p \,\in\, \mathcal{D} \;\longmapsto\; f(p) \,\in\, \mathcal{V}$

* You can browse the domain $\mathcal{D}$\newline
  $~~~$ ...and access to the pixel values $f(p)$

* Dummy (non-generic) sample uses:

\scriptsize
```cpp
for (row = 0; row < ima.nrows(); row += 1)
  for (col = 0; col < ima.ncols(); col += 1)
    sum += ima.at(row, col);

point2d p(16, 64);
int_u8 v;
if (ima.domain().has(p))
  v = ima(p);
```

## hit_or_miss.hpp

```cpp
template <class I, class SEh, class SEm>
mln_concrete(I) hit_or_miss(const I& f,
                            const SEh& se_hit, const SEm& se_miss)
{
  static_assert(is_a<I,Image>::value, "1st arg shall be an Image");
  // ...
  auto ero = erode(f, se_hit);
  auto dil = dilate(f, se_miss);

  using V = typename I::value_type;
  auto res = where(dil < ero, ero - dil, V(literal::zero));
  // 'res' is a lightweight image (about no data)
  return eval(res);
}
```

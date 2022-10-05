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
- \usepackage{threeparttable}


---

## Overview

* General Introduction
* Context and history of Generic Programming
  * Genericity within libraries
  * Genericity within Programming languages
* Generic Programming for Image Processing in the static world
  * Taxonomy for Image Processing
  * Our Concepts for Image Processing
  * Views for Image Processing
* Bringing Genericity to the dynamic world
  * Reminder about Compiled & Interpreted languages
  * Designing a bridge between the static and dynamic world: Hybrid solution
  * Continuation
* General Conclusion and perspectives


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
* supported underlying image type (grayscale, rgb, floating-point, ...)
* supported data structure (ND-buffers, graphs, meshes, ...)
* additional data type (structuring element, label maps, ...)
::::

:::: column
![Specter of possibilities\label{specter-possibilities}](../figures/possibility_space.pdf)
::::

:::

<!-- END INTRODUCTION -->

<!-- BEGIN PART 1: H&C of CP -->

# Context and history of Generic Programming

## Genericity within Libraries (outline)

* Code duplication
* Generalization
* Polymorphism (inclusion & parametric)

## Genericity within Libraries: Code duplication

* Writing and optimizing an algorithm for a particular data type in mind.
* Often results in multiple switch/cases to enumerate all the supported combination of supported data types.

\small
```cpp
void fill(any_image img, any_value v)
{
  switch((img.structure_kind, img.value_kind)) 
  {
  case (BUFFER2D, UINT8):
    fill_img2d_uint8( (image2d<uint8>) img,
                      (uint8) any_value );
  // ...
  case (LUT, RGB8):
    fill_lut_rgb8( (image_lut<rgb8>) img,
                    (rgb8) any_value );
  }
}
```
\normalsize

## Genericity within Libraries: Generalization

* Need to find common denominator to all the supported types: the super-type.
* All supported data types must be convertible to and from this super-type.
* Good for maintenance but conversion can be costly and performances can be impacted.

\scriptsize
```cpp
struct image4D { // generalized super-type
  // generalized underlying value-type
  // every value is converted to this one
  using value_type = std::array<double, 4>;
  /* ... */
};
// specific types w/ conversion routines
struct image2D { image4D to(); void from(image4D); };
struct image3D { image4D to(); void from(image4D); };
// ...
void fill(image4D img, const std::array<double, 4>& v) {
  for(auto p : img.pixels())
    p.val() = v;
}
```
\normalsize

## Genericity within Libraries: Inclusion Polymorphism

* Extracting behavior pattern from algorithms
* Grouping them into logical bricks called interfaces.
* Each algorithm can require a set of behavioral pattern to be satisfied.

::: columns

:::: column
![](../figures/inclupoly.pdf)
::::

:::: column
![](../figures/inclupoly_code.pdf)
::::

:::

## Genericity within Libraries: Parametric Polymorphism

* Extracting behavior pattern from algorithms
* Grouping them into logical bricks called concepts.
* Each algorithm can require a set of behavioral pattern to be satisfied.

::: columns

:::: column
![](../figures/parapoly.pdf)
::::

:::: column
![](../figures/parapoly_code.pdf)
::::

:::

## Genericity within Libraries: Summary

\begin{table}[htbp]
  \centering
  \begin{threeparttable}
    \caption{Genericity approaches: .pros~\&~cons.}
    \begin{tabular}[width=0.8\linewidth]{l|ccccc}
      Paradigm             & TC\tnote{1} & CS\tnote{2} & E\tnote{3} & One IA\tnote{4} & EA\tnote{5} \\
      \hline
      Code Duplication     & \cmark      & \xmark      & \cmark     & \xmark          & \xmark      \\
      Code Generalization  & \xmark      & \eqmark     & \eqmark    & \cmark          & \xmark      \\
      Object-Orientation   & \eqmark     & \cmark      & \xmark     & \cmark          & \cmark      \\
      Generic Programming: &             &             &            &                 &             \\
      \quad with C++11     & \cmark      & \eqmark     & \cmark     & \cmark          & \eqmark     \\
      \quad with C++17     & \cmark      & \cmark      & \cmark     & \cmark          & \eqmark     \\
      \quad with C++20     & \cmark      & \cmark      & \cmark     & \cmark          & \cmark      \\
    \end{tabular}
    \begin{tablenotes}
      \item[1] TC: type checking.
      \item[2] CS: code simplicity.
      \item[3] E: efficiency.
      \item[4] One IA: one implementation per algorithm.
      \item[4] EA: explicit abstractions / constrained genericity.
    \end{tablenotes}
    \label{table:gen.approaches}
  \end{threeparttable}
\end{table}

## Genericity within Programming languages (outline)

* History
* C++: pre-2011 (pre C++11)
* C++: post-2011 (C++20 & Concepts)

## Genericity within Programming languages: History

* 45 year old notion
* CLU, ADA, C++
* FIXME: faire uen frise chronologique

## Genericity within Programming languages: pre C++11

* Functions on types: metafunctions or type-traits
<!--
```cpp
template<class T> struct remove_const                { using type = T; };
template<class T> struct remove_const<const T>       { using type = T; };
``
-->
* SFINAE: Substitution Failure Is Not An Error
* CRTP: Curiously Recurring Template Pattern

## Genericity within Programming languages: post C++11

* Introducing concepts and ``Conceptification''.

Naive algorithm:
\scriptsize
```cpp
template <class Image>
void gamma_correction(Image& ima, double gamma)
{
  const auto gamma_corr = 1 / gamma;

  for (int x = 0; x < ima.width(); ++x)
    for (int y = 0; y < ima.height(); ++y)
    {
      ima(x, y).r = std::pow((255 * ima(x, y).r) / 255, gamma_corr);
      ima(x, y).g = std::pow((255 * ima(x, y).g) / 255, gamma_corr);
      ima(x, y).b = std::pow((255 * ima(x, y).b) / 255, gamma_corr);
    }
}
```

## Genericity within Programming languages: Conceptification

* Step 1: Lifting RGB constraint

\scriptsize
```cpp
template <class Image>
void gamma_correction(Image& ima, double gamma)
{
  using value_t = typename Image::value_type;

  const auto gamma_corr = 1 / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for(int x = 0; x < ima.width(); ++x)
    for(int y = 0; y < ima.height(); ++y)
      ima(x, y) = std::pow((max_val * ima(x, y)) / max_val, gamma_corr);
}
```

## Genericity within Programming languages: Conceptification

* Step 2: Lifting bi-dimensional constraint

\scriptsize
```cpp
template <class Image>
void gamma_correction(Image& ima, double gamma)
{
  using value_t = typename Image::value_type;

  const auto gamma_corr = 1 / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for (auto&& pix : ima.pixels())
    pix.value() = std::pow((max_val * pix.value()) / max_val, gamma_corr);
}
```

## Genericity within Programming languages: Conceptification

* Step 3: Lifting writability constraint

\scriptsize
```cpp
template <WritableImage Image>
void gamma_correction(Image& ima, double gamma)
{
  using value_t = typename Image::value_type;

  const auto gamma_corr = 1 / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for (auto&& pix : ima.pixels())
    pix.value() = std::pow((max_val * pix.value()) / max_val, gamma_corr);
}
```

* This is the final version of the algorithm.

## Genericity within Programming languages: Conceptification

* Step 4: Concept formal definition
\begin{table}[htbp]
  \begin{tiny}
    \begin{tabular}{l|l|l|l|}
      \cline{2-4}
                                                   & \thead{Definition }               &
      \thead{Description}                          & \thead{Requirement}                                      \\
      % Image
      \cline{1-4}
      \multicolumn{1}{|c|}{\multirow{3}{*}{Image}} & \texttt{Ima::const\_pixel\_range} & \makecell[l]{type of
        the range to iterate over
      \\ all the constant pixels} & \makecell[l]{models the concept \\
        \emph{ForwardRange}}
      \\
      \cline{2-4}
      \multicolumn{1}{|c|}{}                       & \texttt{Ima::pixel\_type}         & type of a pixel
                                                   & models the concept \emph{Pixel}                          \\
      \cline{2-4}
      \multicolumn{1}{|c|}{}                       & \texttt{Ima::value\_type}         & type of a value
                                                   & models the concept \emph{Regular}                        \\
      \cline{1-4}
      % Writable Image
      \multicolumn{1}{|c|}{\makecell[l]{Writable
      \\ Image}} & \texttt{WIma::pixel\_range} & \makecell[l]{type of the range to iterate over
      \\ all the non-constant pixels} & \makecell[l]{models the concept \\
        \emph{ForwardRange}}
      \\
      \cline{1-4}
      % StructuringElement \multicolumn{1}{|c|}{StructuringElement} &  &  & \\
      %  \cline{1-4} Decomposable \multicolumn{1}{|c|}{Decomposable} &  &  & \\
      %  \cline{1-4}
    \end{tabular}
  \end{tiny}
  \caption{Concepts formalization: definitions}
  \label{table:concept.definitions}
\end{table}
\vspace{-0.5cm}
\begin{table}[htbp]
  \begin{tiny}
    \begin{tabular}{l|l|l|l|}
      \cline{2-4}
                                         & \thead{Expression}                              & \thead{Return Type} &
      \thead{Description}                                                                                          \\
      \cline{1-4}
      % Image
      \multicolumn{1}{|c|}{Image}        & \texttt{cima.pixels()}                          &
      \texttt{Ima::const\_pixel\_range}  & \makecell[l]{returns a range of constant pixels
      \\ to iterate over it} \\
      \cline{1-4}
      % Writable Image
      \multicolumn{1}{|c|}{\makecell[l]{Writable
      \\ Image}} &\texttt{wima.pixels()} & \texttt{WIma::pixel\_range}       & \makecell[l]{returns a range of
      pixels                                                                                                       \\ to iterate over it} \\
      \cline{1-4}
      % StructuringElement
      \multicolumn{1}{|c|}{\makecell[l]{Structuring
      \\ Element}} &\texttt{cse(cpix)} & \texttt{WIma::pixel\_range}       & \makecell[l]{returns a range of
        the neighboring
      \\ pixels to iterate over it} \\
      \cline{1-4}
      % Decomposable
      \multicolumn{1}{|c|}{Decomposable} & \texttt{cdse.decompose()}                       &
      \texttt{implementation defined}    & \makecell[l]{ returns a range of structuring
      \\ elements to iterate over it} \\
      \cline{1-4}
    \end{tabular}
  \end{tiny}
  \caption{Concepts formalization: expressions}
  \label{table:concept.expressions}
\end{table}

## Limitations: C++ templates in the dynamic world

* Static templates does not mix well with dynamic code (such as Python).
* Templates belong to the static world (compiled once)
* Python belongs to the dynamic world (interpreted multiple time)
* Addressed more in-depth later (Bringing Genericity to the dynamic world)

<!-- END PART 1:  H&C of CP -->

<!-- BEGIN PART 2: GP FOR IP -->

# Generic Programming for Image Processing in the static world

## Taxonomy for Image Processing (outline)

* Image types viewed as set
* Taxonomy of Image Processing Algorithms
* Taxonomy of Image Types

## Taxonomy for Image Processing: Image types viewed as set

* There are families of types.
* Those families share behavior.
* Algorithms must provide one version for each supported family.

\bigskip

::: columns

:::: column
$fill(I, v)\colon \forall{p}\in\mathcal{D}, I(p) = v$
::::

:::: column
$fill(I, v)\colon \forall{i}\in I.LUT, i = v$
::::

:::

## Taxonomy for Image Processing: Version vs. Specialization

* A version is an algorithm that supports a family of data type based on a fundamental behavior.
* A specialization of an algorithm is a specific implementation taking advantage of a property (detected at compile-type
  or at runtime) to execute this algorithm faster.

\bigskip

::: columns

:::: {.column width="38.5%"}
![](../figures/image_version.pdf)
::::

:::: {.column width="61.5%"}
![](../figures/image_version_specialization.pdf)
::::

:::

## Taxonomy for Image Processing: Dilate algorithm

* Version dispatching taking advantages of a property related to structuring element:

::: columns

:::: {.column width="60%"}
\scriptsize
```cpp
template <Image Img, StructuringElement SE>
auto dilate(Img img, SE se) {
  if (se.is_decomposable()) {
    lst_small_se = se.decompose();
    for (auto small_se : lst_small_se)
      // Recursive call
      img = dilate(img, small_se)
    return img;
  } else if (is_pediodic_line(se))
     // Van Herk's algorithm
    return fast_dilate1d(img, se)
  else
     // Classic algorithm
    return dilate_normal(img, se)
}
```
\normalsize
::::

:::: {.column width="40%"}
![](../figures/dilation_specialization_diagram.pdf)
::::

:::

## Taxonomy for Image Processing: Three families

* Pixel-wise algorithms: thresholding, gamma correction.
* Local algorithms: dilation, erosion, closing, hit-or-miss, gradient, rank filter, union-find, max-tree, etc.
* Global algorithms: Chamfer distance transform, labeling, etc.

## Taxonomy for Image Processing: Algorithms canvas

* Algorithms can have the same shape
* When this shape is known, a canvas can be written
* This canvas will only require to be provided callbacks for each customization point to work
* This canvas can leverage a multitude of implementations techniques to improve performances

## Taxonomy for Image Processing: Dilation & Erosion

* Dilation and Erosion have the same shape:

::: columns

:::: column
![](../figures/dilation_code.pdf)
::::

:::: column
![](../figures/erosion_code.pdf)
::::

:::

* They can be rewritten in a common canvas:

![](../figures/local_op_code.pdf)

::: columns

:::: column
![](../figures/local_op_dilation_code.pdf)
::::

:::: column
![](../figures/local_op_erosion_code.pdf)
::::

:::

## Taxonomy for Image Processing: Generic local algorithm canvas

\scriptsize
::: columns

:::: {.column width="45%"}
```python
def local_canvas(img, out, se):
  # do something before outer loop
  for pnt in img.points():
    # do something before inner loop
    for nx in se(pnt):
      # do something inner loop
    # do something after inner loop
  # do something after outer loop
```
::::

:::: {.column width="55%"}
```python
def dilate(img, out, se):
  do_nothing = lambda *args, **kwargs: None

  def before_inner_loop(img, out, pnt):
    out(pnt) = img(pnt)

  def inner_loop(ipix, opix, nx):
    out(pnt) = max(out(pnt), img(nx))

  local_canvas(img, out, se,
    before_outer_loop = do_nothing,
    before_inner_loop = before_inner_loop,
    inner_loop        = inner_loop,
    after_inner_loop  = do_nothing,
    after_outer_loop  = do_nothing
  )
```
::::

:::
\normalsize


## Our Concepts for Image Processing (outline)

* Fundamental concepts.
* Advanced concepts to manipulate images.
* Concept support for local algorithms.

## Fundamental concepts

Fundamental concepts are necessary to be able to do basic manipulations over an image.

* Value: represent an underlying value type and must support a set of operations.
* Point: represent a site in an image to locate a value.
* Pixel: represent a pair (Value, Point).
* Domain: represent the set of points valid for a given image (definition domain).
* Image: represent the algebraic relation $y = f(x) where $y$ is a value generated by the image $f$ for the input
  (point) $x$.
* Aside from generating a value, an image can also store a value, as in $f(x) = y.

## Fundamentals : Pixel concept

![](../figures/concepts/pixel.pdf)

\scriptsize
```cpp
  auto pix = Pixel();     // Get a pixel
  auto val = pix.val();   // yield the pixel value
  auto pnt = pix.point(); // yield the pixel point
  pix.val() = 42;         // Assign a value
```

## Fundamentals : Domain concept

![](../figures/concepts/domain.pdf){width=85%}

\scriptsize
```cpp
  auto dom = Domain(); // Get a domain
  auto pnt = Point(..., ...); // Get a random point
  bool ret = dom.has(pnt); // Check wether the domain contains the point
  bool is_empty = dom.empty(); // Check wether the domain is empty
  auto dim = dom.dim(); // Yield the domain's dimension information
  for(auto pnt : dom) // browse the definition domain
    // use pnt as a point of the domain
```

## Fundamentals : Image concept (diagram)

![](../figures/concepts/image.pdf)

## Fundamentals : Image concept (code usage)

\footnotesize
```cpp
  auto ima = AccessibleImage(); // Get an accessible image
  auto p = Point(); // Get a point
  auto val = ima(p); // Get a value from a point
  auto val = ima.at(p) // Same with no bound checking
  auto pix = ima.pixel(p) // Get a pixel from a point
  auto pix = ima.pixel_at(p) // Same with no bound checking
  ima(p) = 42; // Assigns a value from a point
  ima.at(p) = 42; // Same with no bound checking
  ima.pixel(p).val() = 42; // Assigns a pixel value from a point
  ima.pixel_at(p).val() = 42; // Same with no bound checking
```

## Advanced concepts to manipulate images

* IndexableImage: traversing an image via indexes.
* AccessibleImage: accessing image's value through points.
* BidirectionalImage: traversing image forward and backward.
* RawImage: direct access to the image's data buffer.

## Advanced concepts to manipulate images: Diagram

![](../figures/concepts/images_all.pdf)

## Concept support for local algorithms

* Support for structuring elements (disc, rectangle, sphere, cube, etc.)
* Support for extension (flat buffer, unique value, mirroring, etc.)

Typical usage in local algorithms:

\small
```cpp
  auto se = se::disc(.radius=3); // get a structuring element
  for(auto pix : ima.pixels())   // traverse image
    for(auto nb : se(pix))       // traverse neighboring pixels
      // ...
```

## Concept support for local algorithms (diagram)

![](../figures/concepts/se_extension.pdf)

## Views for Image Processing (outline)

* Genesis of a new abstraction layer: Views
* Views for Image Processing
* View properties
* Use-case: border-management
* Limitations & performance discussion

## Genesis of a new abstraction layer: Views

## Views for Image Processing

* Inspired from Milena morphers [@levillain.2009.ismm] and STL ranges [@niebler.2014.ranges]
* Cheap-to-copy
* Non-owning (of the data buffer)
* Lazy evaluation
* Compossability

## Views for Image Processing

* Views enable the Image Processing practitioner to rewrite the following alpha-blending algorithm at image level.

\scriptsize
```cpp
  void blend_inplace(const uint8_t* ima1, uint8_t* ima2, float alpha,
  int width, int height, int stride1, int stride2) {
    for (int y = 0; y < height; ++y) {
      const uint8_t* iptr = ima1 + y * stride1;
      uint8_t* optr = ima2 + y * stride2;
      for (int x = 0; x < width; ++x)
        optr[x] = iptr[x] * alpha + optr[x] * (1-alpha);
    }
  }
```

\bigskip

![](../figures/alphablend.pdf)


## View properties

## Concrete view use-case: border-management

## Views Limitations & performance discussion

<!-- END PART 2: GP FOR IP -->

<!-- BEGIN PART 3: GP in DYN WORLD-->

# Bringing (static) Genericity to the dynamic world

## Reminder about Compiled & Interpreted languages

### Compiled languages

### Interpreted languages

### Hybrid languages

### Summary

## Information that is static and/or dynamic

## Designing a bridge between the static and dynamic world: Hybrid solution

### Step 1: converting back and forth

### Step 2: multi-dispatcher ($\protect n \times n$ dispatch)

### Step 3: type-erasure & value-set

### Performance discussion

<!-- END PART 3: GP in DYN WORLD-->

# General Conclusion

## Conclusion

## Continuation

# References

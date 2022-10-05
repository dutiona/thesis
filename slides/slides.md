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

\scriptsize

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
  const auto gamma_corr = 1.f / gamma;

  for (int x = 0; x < ima.width(); ++x)
    for (int y = 0; y < ima.height(); ++y)
    {
      ima(x, y).r = 256.f * std::pow(ima(x, y).r / 256.f, gamma_corr);
      ima(x, y).g = 256.f * std::pow(ima(x, y).g / 256.f, gamma_corr);
      ima(x, y).b = 256.f * std::pow(ima(x, y).b / 256.f, gamma_corr);
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

  const auto gamma_corr = 1.f / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for(int x = 0; x < ima.width(); ++x)
    for(int y = 0; y < ima.height(); ++y)
      ima(x, y) = max_val * std::pow(ima(x, y) / max_val, gamma_corr);
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

  const auto gamma_corr = 1.f / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for (auto&& pix : ima.pixels())
    val = max_val * std::pow(pix.value() / max_val, gamma_corr);
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

  const auto gamma_corr = 1.f / gamma;
  const auto max_val = std::numeric_limits<value_t>::max();

  for (auto&& pix : ima.pixels())
    val = max_val * std::pow(pix.value() / max_val, gamma_corr);
}
```
\normalsize

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

* Inspired from Milena morphers [@levillain.2009.ismm] and STL ranges [@niebler.2014.ranges]
* Cheap-to-copy
* Non-owning (of the data buffer)
* Lazy evaluation
* Composability

## Views for Image Processing: Alpha-blending

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

## Views for Image Processing: Expression tree & Composability

* Views can be represented as an expression tree:

::: columns

:::: {.column width="45%"}
![](../figures/view_ast2.pdf)
::::

:::: {.column width="55%"}
\scriptsize

```cpp
auto alphablend =
  [](auto ima1, auto ima2, float alpha) {
    return alpha * ima1 +
                  (1 - alpha) * ima2;
  };
```

::::

:::

* Usage:

\scriptsize

```cpp
auto ima1, ima2 = /* ... */;
auto ima_blended = alphablend(ima1, ima2, 0.2);
```

\normalsize

* Composability:

\scriptsize

```cpp
auto roi = /* ... */;
auto blend_roi = alphablend(view::clip(ima1, roi), view::clip(ima2, roi), 0.2);
auto blend_red = alphablend(view::red(ima1), view::red(ima2), 0.2);
```

## Views for image processing: Overview

* Domain-restrictive views: filter, clip and mask

\scriptsize

```cpp
mln::image2d<mln::rgb8> ima = /* ... */ ;
auto mask1 = ima > 125;
auto mask2 = ima <= 125;
mln::fill(mln::view::mask(ima, mask1), 255); // Thresholding
mln::fill(mln::view::mask(ima, mask2), 0);
```

\normalsize

* Value-transforming view: transform, zip, channel projectors, conversion (cast), operators (arithmetical, logical,
  mathematical)

\scriptsize

```cpp
mln::image2d<uint8_t> ima = /* ... */ ;
auto ero = erode(ima);
auto dil = dilate(ima);
uint8_t zero = 0;
auto ret = mln::view::ifelse(dil < ero, ero - dil, zero); // Hit-or-miss
```

## View properties

![Views: property conservation](../figures/view_property.pdf)

## Concrete view use-case: border-management

* Inherent issue to Image processing when dealing with algorithms operating with neighboring windows.
* Border can be memory allocated around the image buffer (allowing negative indexes)
* Border can be lazy computed by recomputing coordinate to pick a value in the original image (e.g. a mosaic)
* The image can be decorated to allow those out-of-bound accesses
* The Structuring element can also be decorated to yield dynamic windows depending on the pixel (and its coordinates).

While being a marginal issue as it only impacts pixels at the border of the image, it is still mandatory as all local
algorithms will need this issue to be solved.


## Border-management: Policies & Strategies

\small

### Policies

* Native: if the border is large enough: forward the image as-is to the algorithm to allow the fastest access possible.
  Otherwise, the border manager fails and halt the program.
* Auto: if the border is large enough: forward the image as-is to the algorithm to allow the fastest access possible.
  Otherwise, decorate the image with a view whose extension will emulate that is required by the algorithm with the
  given structuring element.

### Strategies

* None: there is no border. Decorate the structuring element.
* Fill: the border is filled with a single value.
* Mirror: the border is filled with a mirrored value from an axial symmetry expanded from the edges.
* Periodize: the border replicates the image as in a mosaic.
* Clamp: expand the value at the image's edge onto the border.
* Image: pick the value in another image (bordering value of a tile from a larger image is picked into the original
  larger image).

## Border-management: strategies illustrations

\bigskip

:::: columns

::: {.column width="33%"}
![Border None](../figures/extensions/none.pdf){height=3.3cm}
$~~~~~$ 
*Border None* \newline
$~~~~~$
![Border periodize](../figures/extensions/periodize.pdf){height=3.3cm}
$~~~~~$ 
*Border Periodize*
$~~~~~$
:::
 
::: {.column width="33%"}
![Border fill](../figures/extensions/fill.pdf){height=3.3cm}
$~~~~~$ 
*Border Fill* \newline
$~~~~~$
![Border clamp](../figures/extensions/clamp.pdf){height=3.3cm}
$~~~~~$ 
*Border Clamp*
$~~~~~$
:::

::: {.column width="33%"}
![Border mirror](../figures/extensions/mirror.pdf){height=3.3cm}
$~~~~~$ 
*Border Mirror* \newline
$~~~~~$
![Border image](../figures/extensions/image.pdf){height=3.3cm}
$~~~~~$ 
*Border Image*
$~~~~~$
:::

::::

## Border-management: Usage

When using the border manager, the user-code becomes:

\scriptsize
```cpp
// default border width is 3
image2d<int> ima = {{0, 1, 0}, {0, 1, 1}, {0, 1, 0}};
auto disc_se = se::disc{1}; // radius is 1
auto bm = extension::bm::fill(0); // fill border with 0 with policy auto
local_algorithm(ima, disc_se, bm); // will handle the border for you
```
\normalsize

While on the algorithmic side, the code becomes:

\scriptsize
```cpp
template <class Ima, class SE, class BM>
local_algorithm(Ima ima, SE se, BM bm)
{
  auto [managed_ima, managed_se] = bm.manage(ima, se);
  std::visit([&](auto&& ima_, auto&& se_) {
    // use ima_ and se_ in loop
  }, managed_ima, managed_se);
}
```

## Views limitations: traversing

* View traversing: segmented ranges (cf. issues std::mdspan)

:::: columns

::: column
![Range-v3's ranges](../figures/linear_rng.pdf)
$~~~~~$
*Range-v3's ranges*
:::

::: column
![Range-v3's ranges](../figures/segmented_rng.pdf)
*Segmented ranges*
:::

::::

## Views limitations: traversing (code)

* Compiler needs explicit contiguous dimension in code to generate vectorized instructions.

:::: columns

::: column
*Unvectorized algorithm:*
\tiny

$~~~$

```cpp
template<class I, , class SE>
auto dilate(I input, const SE& se) {
  auto output = input.concretize(); // clone image
  for(auto [in_px, out_px] :
        view::zip(f.pixels(), g.pixels()))
  {
    out_px.val() = out_px.val();
    for(auto nhx : se(in_px))
      out_pix.val() =
        std::max(nhx.val(), out_px.val());
  }
  return output;
}
```


:::

::: column
*Vectorized algorithm:*
\tiny

$~~~$

```cpp
template<class I, class SE>
auto dilate(I input, const SE& se) {
  auto output = input.concretize(); // clone image
  // this line is needed to avoid dangling reference
  auto zipped_pixels =
        view::zip(input.pixels(), output.pixels());
  // unroll the contiguous segments
  for(auto&& row : ranges::rows(zipped_pixels))
    // optimized traversing of the segment
    for(auto [in_px, out_px] : row) {
      out_px.val() = out_px.val();
      for(auto nhx : se(in_px))
        out_pix.val() =
          std::max(in_px.val(), out_px.val());
    }
  return output;
}
```

:::

::::

## Views performance discussion

### Background subtraction algorithm

* Pipeline:

![](../figures/pipeline_bg_sub_comp.pdf)

* Corresponding code with views:

\scriptsize

```cpp
float kThreshold = 150; float kVSigma = 10;
float kHSigma = 10;  int kOpeningRadius = 32;
auto img_gray = view::transform(img_color, to_gray);
auto bg_gray  = view::transform(bg_color, to_gray);
auto bg_blurred = gaussian2d(bg_gray,  kHSigma, kVSigma);
auto tmp_gray = img_gray - bg_blurred;
auto thresholdf = [](auto x) { return x < kThreshold; };
auto tmp_bin = view::transform(tmp_gray, thresholdf);
auto ero = erosion(tmp_bin, disc(kOpeningRadius));
dilation(ero, disc(kOpeningRadius), output);
```

\small

*Pipeline implementation with _\colorbox{thistle}{views}_. Highlighted code uses _views_ by prefixing
operators with the namespace _view_.*

<!-- END PART 2: GP FOR IP -->

<!-- BEGIN PART 3: GP in DYN WORLD-->

# Bringing (static) Genericity to the dynamic world

## Reminder about Compiled & Interpreted languages

* There are 3 main families of programming languages:
  * Compiled languages (C++, C, Rust, Go).
  * Interpreted languages (Python, PHP, Javascript).
  * Hybrid languages (Java, C#).

## Compiled languages

* Compile-time:

![](../figures/static_compiletime.pdf)

* Runtime:

![](../figures/static_runtime.pdf)

## Interpreted languages

* Runtime:

![](../figures/dynamic_pipeline.pdf)

## Summary

![](../figures/comp_inter_hybrid_summary.pdf)

## Information that is static and/or dynamic

### Static information

* Image's value type (uint8, rgb8, complex, etc.)
* Image's dimension size (1D, 2D, 3D, etc.)
* Architecture of the hardware hosting the program (x86, ARM, PowerPC, GPU, etc.)

### Dynamic information

* Image's actual value ($ima(.x=12, .y=42)$)
* Image's actual size ($1024x512$, etc.)
* Architecture of the hardware hosting the program (x86, ARM, PowerPC, GPU, etc.)

*We are rarely in control about where (which host machine) our software will be run.*

## Designing a bridge between the static and dynamic world: Hybrid solution

FIXME: todo

### Step 1: converting back and forth

### Step 2: multi-dispatcher ($\protect n \times n$ dispatch)

### Step 3: type-erasure & value-set

### Performance discussion

<!-- END PART 3: GP in DYN WORLD-->

# General Conclusion

## Conclusion

## Continuation

# References

# Publications

## Conferences

### Rang A*

* CVPR : IEEE Conference on Computer Vision and Patter Recognition
* ICCV : International Conference on Computer Vision
* ECCV : European Conference on Computer Vision
* ICSE : International Conference on Software Engineering

### Rang A

* ICSA : International Conference on Software Architecture (was previously WICSA)

### Rang B

* ICPR : International Conference on Pattern Recognition
* ICIP : IEEE International Conference on Image Processing
* VCIP : IEEE International Conference on Visual Communications and Image Processing (was SPIE ... pre 2011)
* COMPSAC : International Computer Software and Applications Conference
* SWDC : International Conference on Software Development
* SEKE : International Conference on Software Engineering and Knowledge Engineering
* WACV : IEEE Workshop on Applications of Computer Vision

### Rang ? (not ranked in core website)

* ICCVW : International Conference on Computer Vision Workshop
* GRETSI : Colloque Francophone de Traitement du Signal et des Images
* GTGDMM : Groupe de Travail Géométrie Discrète et Morphologie Mathématique
* AFRIF, RFIAP, ORASIS

## Journaux

### Rang A*

* TIP : IEEE Transaction on image Processing
* JCV : International Journal of Computer Vision
* TSE : IEEE Transactions on Software Engineering
* TOSEM : ACM Transactions on Software Engineering and Methodology

### Rang A

* CVGIP : Computer Vision and Image Understanding
* JSS : Journal of Systems and Software
* INFSOF : Information and Software Technology

### Rang B

* IET-CVI : IET Computer Vision 
* SPE : Software: Practice and Experience

### Rang ? (not ranked in core website)

* JRTIP : Journal of Real-Time Image Processing 

## Dates

* CVPR
  * http://cvpr2022.thecvf.com/
  * Paper Submission Site Opened: TBD
  * Paper Registration Deadline: November 9, 2021
  * Paper Submission Deadline: November 16, 2021
  * Supplementary Materials Deadline: November 23, 2021
  * Reviews Released to Authors: January 24, 2022
  * Rebuttal Due: January 31, 2022
  * Final Decisions to Authors: March 2, 2022
  * Camera ready due: TBD

* ICCV : no infos as of yet
  * http://iccv2021.thecvf.com/node/5

* ECCV : no infos

* ICSE : unclear
  * http://www.icse-conferences.org/index.html
  * https://conf.researchr.org/home/icse-2022

* ICPR :
  * Registration deadline: January 10, 2022
  * Submission deadline: January 17, 2022
  * Acceptance/Rejection/Revision decision: March 14, 2022
  * Revision/rebuttal deadline: April 11, 2022
  * Final decision on submissions: May 9, 2022
  * Camera ready manuscript deadline: June 6, 2022
  * Early bird registration deadline: June 6, 2022
  * Presentation dates: August 22-25, 2022

* ICIP : no infos as of yet
  * http://2022.ieeeicip.org/

* VCIP : no infos as of yet
  * https://www.vcip2021.org/
  * 2021 edition is going to be in December 5-8, 2021

* COMPSAC :
  * https://ieeecompsac.computer.org/2022
  * Main Conference:
    * Main conference papers due: January 31, 2022
    * Paper notification: April 15, 2022
    * Camera-ready and registration due: May 31, 2022
  * Workshops:
    * Workshops proposal acceptance notification: 15 December 2020
    * Workshop papers due: April 21, 2022
    * Workshop paper notifications: May 15, 2022
    * Camera-ready and registration due: May 31, 2022

* SEKE : no infos for 2022
  * http://ksiresearch.org/seke/seke21.html

* WACV :
  * http://wacv2022.thecvf.com/home
  * Submission: Wednesday, August 18th, 11:59 PM Pacific (August 19th, 6:59 AM GMT), CMT availalble for submissions on July 28th.
  * Supplementary: Friday, August 20th, 11:59 PM Pacific (August 21st, 6:59 AM GMT)
  * Decisions: Saturday, October 2nd, 11:59 PM Pacific (October 3rd, 6:59 AM GMT)

* ICCVW : no info as of yet
  * http://iccv2021.thecvf.com/node/5

* GRETSI 2022
  * http://gretsi.fr/colloque2022/

* GTGDMM: no infos for a 2022 conf
  * https://gdmm2020.sciencesconf.org/
  * http://gt-gdmm.u-bordeaux.fr/
  * https://www.gdr-im.fr/

* AFRIF: http://afrif.irisa.fr/

* SWDC, MPOOL, CIARP, IPOL : conference morte ?

## Subjects ideas

1. Image processing
   * Taxonomy:
     * set representation of images
     * conceptualization
     * a minimal taxonomy necessary to work with local algorithm ?
   * Views:
     1. new paradigm to design IP algorithms by abstracting away pixel-wise algorithms
        * chainability
        * lazy evaluation
        * reusability
        * low impact performance wise
     2. practical example: border management
        * problematic of border behavior in local algorithm
        * design choice and motivation
        * views to add/remove/modify border behavior of an image
        * views to add/remove/modify structuring element if necessary
        * very low impact on IP algorithmic side
2. Software engineering
   * Taxonomy:
     * introducing concepts in C++ programming language and its applications in IP
     * conceptualization of an algorithm
     * discussion around the design choice of "all images are cheap-to-copy views" and "what is a concrete image"
     * a minimal taxonomy given to work with local algorithms ?
   * Views:
     * parallel between ranges-v3 and images
     * multidimensional traversing
     * chainability/lazy eval/reusability/good performances
   * Static dynamic bridge:
     * definition of "static world" and "dynamic world"
     * motivations (enable usage of library from Python)
     * existing ways of achieving results, pros & cons
     * hybrid solution:
       1. dispatch on known types for good performances
       2. fallback on type-erasure for unknown types (performances lowered but at least, it works)
       3. explain the mechanic behind the multi-dispatch


## Ressources

* https://www.scimagojr.com/journalsearch.php
* http://portal.core.edu.au/conf-ranks/
* http://portal.core.edu.au/jnl-ranks/

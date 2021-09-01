Ma remarque générale est qu'il y a des problèmes d'organisations et de
"flux", j'ai du mal à savoir ou tu veux en venir. Tu devrais toujours
suivre ce schéma clair pour l'ensemble des chapitres/sections.
1. Quel est le problème ?
2. Quelles sont les solutions/approches existantes ?
3. Qu'est ce qu'on propose
Il y aussi beaucoup de pages qui relèvent de la doc, des annexes (les
définitions de concepts). Il ne doit rester que ceux qui sont essentiels
à la compréhension du texte.

Chapitre 2: Généricité.
Beaucoup trop d'exemples hors-sol, la thèse parle de TI, il faut que tu
illustres sur des algos de TI. Les exemples de la partie 2.2 sont à
revoir complètement et à choisir pour illustrer la différence avec le
C++ moderne introduit dans les chapitres qui suivront.
La section 2.3.1 est une préface à la taxonomie, il faut le dire. Encore
une fois, les exemples hors-sols sont sans intérêts. La notion de traits
est quasi-absentes.
La section 2.3.2 met en avant la méthode de sélection du best
"algorithme". Une discussion est attendue, pas juste un "display". On
utilise encore dans la bibliothèque le Tag dispatching, les types
contraints par concept (généricité contrainte dont le terme n'apparait
jamais !), l'overload, la spécialisation. Pourquoi, dans quel cas ?
La section 2.3.3, n'a pas de sens à mes yeux. Je ne vois pas ce que tu
veux montrer
La section 2.4, je ne vois pas ou tu veux en venir. Ce n'est pas motivé
(pourquoi on le monde est dynamique) et il n'y a pas de conclusion.

Chapitre 3: Image et Taxonomie
3.1: Diff avec le 2.3.1 en terme de fonctionnalité ? Ou c'est une
version 2.3.1 étendue ?

Contre-sens de l'organisation. Le message c'est ce sont les algos qui
définissent les concepts "Images" et la taxonomie des algos apparait
après les concepts images.

3.1.3 Le(s) concept(s) d'image.
Ici on devrait voir une "hiérarchie" des images avec une description des
propriétés (+Lien vers les définitions de concepts). J'aurais aimé avoir
une discussion avec les différences entre traits et concepts. Quand
décide-t-on de définir un trait vs un concept. Pourquoi "raw" est un
trait et "Writable" est un concept ? Justifie les choix de designs !

3.3 Spécialisation et Version
Un point important non-abordé ici est la notion de sous-type. Qu'est-ce
qu'un sous-type ? Les limitations du design actuel, eg. la gestion des
sous-types dynamiquement (si on passe un masque qui est une ligne).
Comment est géré ce dynamisme dans les autres bibliothèques ?
Illustrer comment on sélectionne une version/spécialisation (sans être
trop redondant avec le 2.3.2). Pourquoi c'est "if constexpr", pourquoi
du trait/tag dispatch, pourquoi du concept dispatch...
Quels sont les facteurs de dispatchs (propriétés statiques des objets,
propriétés dynamiques des objets, propriétés de l'architecture
disponible...)

3.3 Canevas
Organisation et motivation à revoir. La motivation est:
1. Factorisation du boilerplate de dispatch + de travail meta (gestion
de bordure, allocation de ressources...)
2. Customisation algorithmique => le canevas est une abstraction du
parcours d'image avant tout ! Pour ça, il va falloir que tu regardes un
peu plus loin que la dilatation (Union-Find, pattern à file de
propagation).

3.3.1 Taxonomie des algorithmes
A migrer en amont. A compléter avec plus de patterns d'algo de MM pour
le cas "global".

3.3.2 Programmation hétérogène
Beaucoup de confusion entre des standards (SYCL), des extensions de
langagues (CUDA, C++AMP, OpenMP), des DSL (Halide), des bibliothèques
(triCYCL, Boost.SIMD, VCL), des compilateurs (CUDA COMPILER -> CUDA,
DPC++ -> SYCL) qui font des choses différentes.

Les canevas ne font pas de programmation hétérogène, ils permettent
d'avoir une couche d'abstraction pour l'utilisateur (ex le canevas
d'union-find parallèle qui permet d'écrire un algo utilisant l'UF d'être
automatiquement parallélisé par TBB).
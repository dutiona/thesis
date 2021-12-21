 4.1 Cette partie définit les vues disponibles dans la bibliothèque et d'où vient
le besoin. Comme souvent, tu pars trop dans une énumération des fonctionnalités,
là ou il faudrait motiver leur besoin.

Quel est l'intérêt fondamental d'une vue d'image vis-à-vis d'une API:
l'extensibilité de l'API sans ajout de paramètres et donc de façon
non-intrusive. Cf, le papier RRPR, prenons un algo ``foo(image)``


* si on veut travailler sur une sous-partie de l'image: ``foo(image, roi = subroi)``
* si on veut travailler sur des valeurs sous-quantifiées de l'image ``foo(image, projector = lambda x: x/4)``
* s'il n'existe pas le paramètre prévu ===> perdu

La combinatoire croit de façon exponentielle, les vues permettent d'étendre une API de façon non intrusive.
* ``foo(clip(image, subroi))``
* ``foo(transform(image, lambda x: x/4))``

Ensuite il faudrait organiser la présentation des vues: value transformation vs domain restriction

---+------> Value transformation : transform et zip
   |
   |------> Domain restriction
            +-> Par fonction: filter
            +-> Par domain: clip
            +-> Par image booléenne: mask

4.2.1

Enfin une partie qui discute des choix de design par rapport à l'existant. La comparaison avec les Range C++20 est importante pourtant ce n'est pas toujours très clair (une comparaison avec le design anciens morpheurs aurait été sympa aussi).

Range = Views (Non-owning, cheap to copy) + Containers (owning)

Problème: Toutes les vues doivent construire des vues à partir des containers (std::views::all_t, std::ranges::ref_view) => lourdeur, dangling reference sur vue temporaire

Dans Pylene:
Image = Image Concrete + View

* **toutes** les images sont cheap-to-copy O(1), la seule différence est l'ownership
Avantage: une vue peut tenir une image sans passer par un adaptateur de vue, par copie ! (qui est O(1))

4.2.2
4.2.3

Il y a des exemples qui illustrent la même chose, des figures doublons, des anciens paragraphes déplacés à des endroits qui ne font pas sens vis à vis de la nouvelle organisation. Tu dois refaire une passe d'organisation sur ces deux sections.


4.3
A aucun moment c'est dit que c'est implémenté à l'aide de vue alors que c'est le point cet exemple. Il faut compacter les figures et montrer comment une vue implémente la fonctionnalité (pas le code complet !, les points clés uniquement)

4.4

C'est bien d'avoir benchmarker sur un dataset mais ça ne sert à rien de reporter
le benchmark de chaque image. Une seule courbe suffit avec une "error bar" pour
montrer l'écart type sur le dataset.
En revanche, il manque le bench de la consommation mémoire pour attester qu'il y a réellement un gain comme la table du papier GPCE en pj.

4.5 SECTION: Limitation des vues ???

Code bloat, explosion des types, temps compilation, missed optimizations... Sois critique, lis les références adéquates sur les critiques des Ranges C++. D'ailleurs, je pense que la biblio est incomplète sur cette partie "Vues".

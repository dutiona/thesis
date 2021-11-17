<!-- LTeX: language=fr -->

Le pont statique-dynamique est introduit par une comparaison entre langage "compilé" vs "interprété"
avec des arguments qui n'ont parfois rien à voir avec les langages, mais plutôt leur écosystème.
Les points de comparaison proposés sont :
1. La portabilité. *"Les programmes C++ sont plus portables que les programmes Python."* C'est très contestable !
2. La facilité d'utilisation pour le end-user. *"Les progammes C++ sont censés tourner 'out-of-the-box' ?"* C'est aussi très contestable. Il y a une grosse confusion entre le langage statique/dynamique, le linkage qui peut être aussi statique/dynamique et la notion de dépendance. Un programme Python (interprété) peut embarquer l'ensemble de ses dépendances (bundle). Un programme C++ (compilé) peut se lier dynamiquement à ses dépendances qu'il embarque (un .framework qui fournit ses so/dll) ou pas (dépendances systèmes). Je ne suis pas sûr que le mode de linkage est quelque chose à voir avec le sujet du chapitre
3. La vitesse d'exécution => OK


A mon avis, la bonne façon d'introduire ce chapitre, c'est une version étendue du texte après la fig. 5.3:

1. Que veut dire statique et dynamique dans ce chapitre (ce n'est pas qu'une histoire de type) et rappeler les définitions de bases

    Informations statiques = les informations concertant un "objet" et son environnement qui sont connus au moment de la compilation (ie de la **génération de code**). E.g.: 

        * Le type de valeur de l'image
        * Le nombre de dimension de l'image
        * L'architecture sur lequel doit tourner le code produit ?

    Informations dynamiques = les informations concernant "un objet" et son environnement qui ne sont pas connues au moment de la compilation, mais seulement à l'exécution. P. ex. :

        * Les valeurs de l'image
        * La taille de l'image
        * L'architecture sur lequel doit tourner le code produit ?

    Typage statique = Le type est assigné (et connu) à la compilation
    Typage dynamique = Le type est assigné à l'exécution

2. Rappeler le besoin de généricité et que le polymorphisme peut-être statique (comme les templates en C++) ou dynamique (duck typing en Python). Ex en python et C++:

```py
def add(a, b): return a + b
```
```c++
T add(T a, T b) { return a + b; }
```

Pros and cons des deux façons. Expliquer que la forme de polymorphisme dynamique implique des indirections :

* ``a + b =CALL=> a.__plus__(b) =CALL=> .... ===  ADD a, b``
* vs ``a + b === ADD a, b``

Le typage définit le comportement. Typage dynamique => comportement dynamique => indirection => perte de perf
(C'est d'ailleurs ce qu'on va mimer avec la type-erasure pour avoir du polymorphisme dynamique)

3. Quel est l'intérêt du typage statique et de l'information statique dans notre contexte => rapidité d'exécution
   (Encore faut-il discuter de quelle information est importante pour la perf)

4. Pb comment utiliser une bibliothèque C++ générique, dont le polymorphisme est introduit statiquement par des templates
   et dont les types contiennent beaucoup d'information statique (pour les besoins de perfs) depuis un environnement plus dynamique.
   Ce problème n'est pas forcément lié à Python : comment avoir une pipeline qui gère le niveau de gris et la couleur en même temps.

J'illustrerais les approches sur des types plus simples avant de montrer sur ``ndbuffer_image`` (et mettre une grosse partie du code en annexe).


## La solution hybride

La solution hybride, c'est normalement :

* Dispatcher sur les types communs
* Fallback sur la type-erasure

```c++
class Value {...};
class Int {...};

void add(Value& a, Value& b, Value& c)
{
    if (a.type == b.type == Int) ((Int&)a).Add(Int&)b, (Int&)c);
    else if (a.type == b.type == Float) ((Float&)a).Add(Float&)b, (Float&)c);

    else // Type-erasure fallback
        a.Add(b, c)
}
```

## Type-erasure

Une type-erasure doit fournir une interface complète d'Image comme l'a fait Célian. Ici tu ne montres ici que le super-type qui permet d'être downcaster vers le type dynamique.

Faire un effacement de type = faire tourner un algo sur ``ndbuffer_image``. Le value-set en 5.3 en fait partie.
Cette section est normalement la plus longue et devrait apparaitre après le multi-dispatch.

La partie value-set avec des méthodes acceptants des objets depuis Python est
bien. Mais pourquoi ne pas créer un value_set à la volée qui utilise les
méthodes magiques ``__add__, __sub__`` déjà définies ? >


## Dispatch et double-dispatch

Il y a trop de code qui entre les parties écrites. Il faudra revoir la forme, du code, c'est des figures ! Ce n'est pas un blog.

## Benchmarks
C'est pas utile de benchmarker contre d'autres bibliothèques, on veut voir l'impact du bridge !
Le benchmark doit être :
* C++
* Python quand le type fait partie des types de dispatchs
* Python quand on fallback sur la type-erasure

Cf encore les benchmarks faits avec Célian.

## JIT
Bien





Ici on a construit un langage pour décrire une automate à pile. Voici la syntaxe du langage:
```
automate(<nombre de piles>) <nom de l'automate> {
    etat: [<liste des états>];
    init: <état initial>;
    final: [<liste des états finaux>];
    transition: [
        (<état source>, <symbole d'entrée>, <état cible>, <liste des actions de piles>...),
        ...
    ];
};
```
- \<nombre de piles> représente le nombre de piles dans l'automate à pile.
- \<nom de l'automate> est le nom donné à l'automate à piles. Il peut être composé de chiffres mais doi contenir au moins une lettre.
- \<liste des états> est une liste d'états séparés par des virgules. Il peut être composé de chiffres mais doi contenir au moins une lettre.
- \<état initial> est l'état initial de l'automate à piles.
- \<liste des états finaux> est une liste d'états finaux séparés par des virgules.
- \<état source>, <symbole d'entrée> et <état cible> définissent une transition entre deux états. Le symbole doit être un symbole codé en ASCII.
- \<liste des actions de piles> indique les actions à effectuer sur les piles lors de la transition. Voici la syntaxe pour une action sur pile:
```
('a', ->)   // dépiler le caractère 'a' (codé en ASCII)
()          // on ne fait rien
(->, 'a')   // empiler le caractère 'a' (codé en ASCII")
```
On donne 3 exemples de fichier pour la description d'automate: automate.txt, automate1.txt et automate1.txt .

Pour compiler et/ou exécuter une automate, utilisez la commande suivante:
```
make exec           // compiler les fichiers ocaml et c
./pcfloop [nom de fichier d'automate] [verbosity (0,1 ou 2)] [-output [VM] [TS]]
                    // output = 0: l'automate va être compilé et puis exécuté avec Ocaml
                    // output = 1: l'automate va être compilé pour générer deux fichiers VM et TS, qui sont utile pour l'exécution d'une exécutable c ("./Executeur")
                    // output est égal à 0 par défaut
                    
```
On utilise une table (dans le fichier VM) pour décrire l'automate et un fichier pour stocké les noms de chaque état.
Une automate à piles peut être utilisée pour définir un langage algébique. On dit qu'un mot  est accepté par l'automate s'il existe une série de transitions qui conduit à une configuration acceptante. L'exécutable "./Executeur" sert à vérifier si un mot est accepté par l'automate avec mode de reconnaissance par pile vide et état final Son usage:
```
./Executeur (-debug) VM TS      // Si on met "-debug" on verra plus de détail de l'éxecution de l'automate
```

Si on ne s'intéresse pas au langage défini par l'automate et l'acceptance des mots, on peut simplement exécuter 
```
./pcfloop [nom de fichier d'automate] [verbosity (0,1 ou 2)] 
                                // verbosity est égal à 0 par défaut
```
On peut mettre verbosity>=1 pour voir les informations concernant l'automate, et mettre verbosity=2 pour voir plus d'information lors de l'exécution de l'automate.


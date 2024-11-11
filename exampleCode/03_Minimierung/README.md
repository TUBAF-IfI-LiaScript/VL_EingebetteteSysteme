# How to

Install Python 3.1x and poetry on your Computer 

https://python-poetry.org/

1. Install the dependencies with poetry

```bash
poetry install
```

2. Open a virtuall shell

```bash
poetry shell
```

3. Run manim generation process

```bash
manim -pql main.py KarnaughVeitch4Var
```

> Für die Generierung wurde Claude.ai und folgender Promt verwendet:

```bash
Generiere eine Erklärung des Karnaugh-Veit diagrams mit python manim. 

Bitte für den Fall mit 4 Variablen.

SyntaxError: invalid decimal literal

Kannst Du die Resultierende Gleichungen der einzelnen Gruppierungsrechtecke noch ausgeben
``` 
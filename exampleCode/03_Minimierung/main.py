from manim import *

class KarnaughVeitch4Var(Scene):
    def construct(self):
        # Einführungstext
        title = Text("4-Variablen Karnaugh-Veitch Diagramm", font_size=40)
        subtitle = Text("(AB/CD)", font_size=30).next_to(title, DOWN)
        
        self.play(Write(title))
        self.play(Write(subtitle))
        self.wait(2)
        self.play(FadeOut(title), FadeOut(subtitle))

        # 4x4 KV-Diagramm erstellen
        kv_grid = self.create_4var_kv()
        self.play(Create(kv_grid))
        self.wait(2)

        # Gray-Code und Variablenbezeichnungen
        labels = self.create_gray_code_labels()
        self.play(Create(labels))
        self.wait(2)

        # Beispielwerte einfügen
        values = self.fill_example_values()
        self.play(Create(values))
        self.wait(2)

        # Verschiedene Gruppierungen mit Gleichungen demonstrieren
        groupings = self.show_groupings()
        equations = self.create_equations()
        
        # Gruppierungen und Gleichungen nacheinander anzeigen
        for i in range(len(groupings)):
            self.play(Create(groupings[i]))
            self.play(Write(equations[i]))
            self.wait(2)

    def create_4var_kv(self):
        squares = VGroup()
        for i in range(4):
            for j in range(4):
                square = Square(side_length=0.8)
                square.shift(RIGHT * (j * 0.8 - 1.2) + UP * (1.2 - i * 0.8))
                squares.add(square)
        return squares

    def create_gray_code_labels(self):
        labels = VGroup()
        
        gray_ab = ["00", "01", "11", "10"]
        gray_cd = ["00", "01", "11", "10"]
        
        ab_label = Text("AB", font_size=24).shift(UP * 2 + LEFT * 1.6)
        labels.add(ab_label)
        
        for i, code in enumerate(gray_ab):
            label = Text(code, font_size=20)
            label.shift(UP * 1.8 + RIGHT * (i * 0.8 - 1.2))
            labels.add(label)
        
        cd_label = Text("CD", font_size=24).shift(LEFT * 2 + UP * 1.2)
        labels.add(cd_label)
        
        for i, code in enumerate(gray_cd):
            label = Text(code, font_size=20)
            label.shift(LEFT * 1.6 + UP * (1.2 - i * 0.8))
            labels.add(label)
        
        return labels

    def fill_example_values(self):
        values = VGroup()
        example_values = [
            [1, 1, 1, 1],
            [1, 0, 0, 1],
            [1, 0, 0, 1],
            [1, 1, 1, 1]
        ]
        
        for i in range(4):
            for j in range(4):
                value = Text(
                    str(example_values[i][j]), 
                    font_size=20
                )
                value.shift(RIGHT * (j * 0.8 - 1.2) + UP * (1.2 - i * 0.8))
                values.add(value)
        return values

    def show_groupings(self):
        groupings = VGroup()
        
        # Obere horizontale 4er-Gruppe (Blau)
        group1 = Rectangle(
            width=3.4,
            height=0.9,
            color=BLUE,
            fill_opacity=0.2
        ).shift(UP * 1.2)
        
        # Untere horizontale 4er-Gruppe (Rot)
        group2 = Rectangle(
            width=3.4,
            height=0.9,
            color=RED,
            fill_opacity=0.2
        ).shift(DOWN * 1.2)
        
        # Linke vertikale 4er-Gruppe (Grün)
        group3 = Rectangle(
            width=0.9,
            height=3.4,
            color=GREEN,
            fill_opacity=0.2
        ).shift(LEFT * 1.2)
        
        # Rechte vertikale 4er-Gruppe (Gelb)
        group4 = Rectangle(
            width=0.9,
            height=3.4,
            color=YELLOW,
            fill_opacity=0.2
        ).shift(RIGHT * 1.2)

        return VGroup(group1, group2, group3, group4)

    def create_equations(self):
        equations = VGroup()
        
        # Gleichung für blaue Gruppe (obere horizontale 4er-Gruppe)
        eq1 = Text(
            "f₁ = C'D'",
            font_size=24,
            color=BLUE
        ).shift(RIGHT * 3 + UP * 1.2)
        
        # Gleichung für rote Gruppe (untere horizontale 4er-Gruppe)
        eq2 = Text(
            "f₂ = CD",
            font_size=24,
            color=RED
        ).shift(RIGHT * 3 + UP * 0.4)
        
        # Gleichung für grüne Gruppe (linke vertikale 4er-Gruppe)
        eq3 = Text(
            "f₃ = A'B'",
            font_size=24,
            color=GREEN
        ).shift(RIGHT * 3 - UP * 0.4)
        
        # Gleichung für gelbe Gruppe (rechte vertikale 4er-Gruppe)
        eq4 = Text(
            "f₄ = AB",
            font_size=24,
            color=YELLOW
        ).shift(RIGHT * 3 - UP * 1.2)

        # Gesamtgleichung
        total_eq = Text(
            "f = A'B' + AB + C'D' + CD",
            font_size=24,
            color=WHITE
        ).shift(DOWN * 2)
        
        equations.add(eq1, eq2, eq3, eq4, total_eq)
        return equations

class KVMinimizationExample4Var(Scene):
    def construct(self):
        # Erklärung der Minimierung
        explanation = VGroup(
            Text("Minimierung der Funktion:", font_size=36),
            Text("f = A'B' + AB + C'D' + CD", font_size=30),
            Text("Diese Form ist bereits minimal, da:", font_size=24),
            Text("• Jede Gruppe eliminiert zwei Variablen", font_size=24),
            Text("• Keine weitere Vereinfachung möglich", font_size=24),
            Text("• Alle Einsen sind in minimalen Gruppen erfasst", font_size=24)
        ).arrange(DOWN, aligned_edge=LEFT, buff=0.5)
        
        self.play(Write(explanation))
        self.wait(3)
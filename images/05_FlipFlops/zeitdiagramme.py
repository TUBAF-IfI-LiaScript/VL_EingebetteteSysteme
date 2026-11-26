#!/usr/bin/env python3
"""Zeitdiagramme der Vorlesung 06 (Flip-Flops) in einheitlichem Stil.

    python3 zeitdiagramme.py

erzeugt die SVG-Dateien timeLine*.svg im selben Ordner. Die Eingänge sind
von Hand festgelegt, die Ausgänge werden aus ihnen simuliert, damit Bild und
Schaltungsverhalten zusammenpassen.

Zeitachse: Einheit = halbe Taktperiode. Steigende Flanken bei 1, 3, 5, …,
fallende bei 2, 4, 6, … (Ausnahmen: Temperaturalarm und Flankendetektor
haben keinen Takt). Farben: Takt schwarz, Eingänge und innere Signale blau,
Ausgänge rot.
"""
from pathlib import Path

HERE = Path(__file__).parent
BLACK, BLUE, RED, GRID = "#000000", "#1f4fd1", "#d0201b", "#9a9a9a"
DT2 = 0.14                       # 2Δt in halben Taktperioden


# ------------------------------------------------------------- Signale
def level(intervals, t):
    """Pegel eines Signals, gegeben als Liste der 1-Intervalle [a, b)."""
    return int(any(a <= t < b for a, b in intervals))


def changes(intervals):
    return sorted({x for iv in intervals for x in iv})


def clock(n_pulses):
    return [(k, k + 1) for k in range(1, 2 * n_pulses, 2)]


def from_edges(edges, t_end, start=0):
    """Intervalle mit Pegel 1 aus den Umschaltzeitpunkten eines Signals."""
    iv, cur, t0 = [], start, 0.0
    for e in sorted(edges):
        if cur:
            iv.append((t0, e))
        cur ^= 1
        t0 = e
    if cur:
        iv.append((t0, t_end))
    return iv


def sr_next(s, r, q):
    return 1 if s and not r else 0 if r and not s else q


def simulate(times, enabled, next_q, delay, q=0):
    """Wertet das Speicherglied zu den Zeitpunkten `times` aus.

    Gibt die Umschaltzeiten von Q und die Liste (Ursache, Wirkung) zurück."""
    edges, cause = [], []
    for t in sorted(set(times)):
        if enabled(t):
            new = next_q(t, q)
            if new != q:
                edges.append(t + delay)
                cause.append((t, t + delay))
                q = new
    return edges, cause


def sr_async(S, R, delay):
    return simulate(changes(S) + changes(R), lambda t: True,
                    lambda t, q: sr_next(level(S, t), level(R, t), q), delay)


def sr_level(S, R, CLK, delay):
    return simulate(changes(S) + changes(R) + [a for a, _ in CLK],
                    lambda t: level(CLK, t),
                    lambda t, q: sr_next(level(S, t), level(R, t), q), delay)


def sr_rising(S, R, CLK, delay):
    return simulate([a for a, _ in CLK], lambda t: True,
                    lambda t, q: sr_next(level(S, t), level(R, t), q), delay)


def jk_rising(J, K, CLK, delay):
    def nxt(t, q):
        j, k = level(J, t), level(K, t)
        return 1 - q if j and k else sr_next(j, k, q)
    return simulate([a for a, _ in CLK], lambda t: True, nxt, delay)


def t_falling(C, delay, t_end):
    """T-Flip-Flop mit T = 1, kippt bei jeder fallenden Flanke von C."""
    falls = [b for _, b in C if b < t_end]
    edges = [f + delay for f in falls]
    return from_edges(edges, t_end), [(f, f + delay) for f in falls]


# ------------------------------------------------------------ Zeichnen
class Diagram:
    """rows: (Name, Index, Intervalle, Farbe, Flankenpfeile)
    Flankenpfeile: None, "rise", "fall" oder "both"."""

    def __init__(self, rows, t_end, unit=84, vlines=(), axis=None,
                 label_width=120, row_h=62):
        self.rows, self.t_end, self.unit = rows, t_end, unit
        self.vlines, self.axis = vlines, axis
        self.x0, self.row_h, self.amp, self.y0 = label_width, row_h, 30, 30
        self.last_mark = {}      # Zeile -> rechtes Ende der letzten Marke
        self.extra = []          # zusätzliche SVG-Elemente
        self.bottom = 30 + (60 if axis else 0)

    def x(self, t):
        return self.x0 + self.unit * t

    def base(self, i):
        return self.y0 + self.row_h * i + self.amp + 8

    def width(self):
        return int(self.x(self.t_end) + 40)

    def height(self):
        return self.y0 + self.row_h * len(self.rows) + self.bottom

    # --- Bemaßung einer Verzögerung unter Zeile `row` von t0 bis t1
    def delay(self, t0, t1, label, row, color=BLACK, dy=16):
        x0, x1 = self.x(t0), self.x(t1)
        if x0 - 22 < self.last_mark.get(row, -1e9):   # überlappt: eine Ebene tiefer
            dy += 18
        self.last_mark[row] = x1 + 70
        y = self.base(row) + dy
        if x1 - x0 >= 40:        # breit genug: Maßlinie mit Text darunter
            self.extra.append(
                f'<line x1="{x0}" y1="{y}" x2="{x1}" y2="{y}" stroke="{color}" '
                f'stroke-width="1.2" marker-start="url(#k)" marker-end="url(#k)"/>')
            self.extra.append(
                f'<text x="{(x0 + x1) / 2}" y="{y + 18}" font-size="14" '
                f'text-anchor="middle" fill="{color}">{label}</text>')
        else:                    # schmal: Pfeile von außen
            for a, b in ((x0 - 22, x0), (x1 + 22, x1)):
                self.extra.append(
                    f'<line x1="{a}" y1="{y}" x2="{b}" y2="{y}" stroke="{color}" '
                    f'stroke-width="1.2" marker-end="url(#k)"/>')
            self.extra.append(f'<text x="{x1 + 28}" y="{y + 5}" font-size="14" '
                              f'fill="{color}">{label}</text>')

    # --- gebogener roter Pfeil von (t0, Zeile r0, oben) nach (t1, Zeile r1, Mitte)
    def link(self, t0, r0, t1, r1):
        ys = self.base(r0) - self.amp
        yt = self.base(r1) - self.amp / 2
        x0, x1 = self.x(t0), self.x(t1)
        self.extra.append(
            f'<path d="M{x0},{ys} C{x0 - 20},{ys + 70} {x1 - 20},{yt - 40} '
            f'{x1 - 3},{yt}" fill="none" stroke="{RED}" stroke-width="1.6" '
            f'marker-end="url(#r)"/>')

    def text_below(self, t, label):
        y = self.base(len(self.rows) - 1) + 60
        self.extra.append(f'<text x="{self.x(t)}" y="{y}" font-size="15" '
                          f'text-anchor="middle">{label}</text>')

    def wave(self, intervals, yb, color):
        hi, lo = yb - self.amp, yb
        pts = []
        intervals = [(a, min(b, self.t_end)) for a, b in intervals if a < self.t_end]
        for a, b in intervals:
            pts += [(self.x(a), lo), (self.x(a), hi), (self.x(b), hi), (self.x(b), lo)]
        if not intervals or intervals[0][0] > 0:
            pts.insert(0, (self.x(0), lo))
        else:
            pts = pts[1:]
        if intervals and intervals[-1][1] >= self.t_end:
            pts = pts[:-1]
        else:
            pts.append((self.x(self.t_end), lo))
        d = " ".join(f"{px:.1f},{py:.1f}" for px, py in pts)
        return (f'<polyline points="{d}" fill="none" stroke="{color}" '
                f'stroke-width="2.5" stroke-linejoin="miter"/>')

    def edge_arrow(self, t, yb, up):
        y1, y2 = (yb - 4, yb - self.amp + 8) if up else (yb - self.amp + 4, yb - 8)
        return (f'<line x1="{self.x(t)}" y1="{y1}" x2="{self.x(t)}" y2="{y2}" '
                f'stroke="{BLACK}" stroke-width="1.5" marker-end="url(#k)"/>')

    def svg(self, name):
        W, H = self.width(), self.height()
        out = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" '
               f'viewBox="0 0 {W} {H}" font-family="DejaVu Sans, Arial, sans-serif">',
               f'<rect width="{W}" height="{H}" fill="white"/>',
               '<defs>'
               '<marker id="r" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" '
               f'markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="{RED}"/></marker>'
               '<marker id="k" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" '
               f'markerHeight="6" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="{BLACK}"/></marker>'
               '</defs>']
        bottom_line = self.base(len(self.rows) - 1) + 10
        for t in self.vlines:
            out.append(f'<line x1="{self.x(t)}" y1="{self.y0 - 10}" x2="{self.x(t)}" '
                       f'y2="{bottom_line}" stroke="{GRID}" stroke-dasharray="3,4"/>')
        for i, (nm, sub, iv, color, arrows) in enumerate(self.rows):
            yb = self.base(i)
            for lvl, yy in ((0, yb), (1, yb - self.amp)):
                out.append(f'<line x1="{self.x(0)}" y1="{yy}" x2="{self.x(self.t_end)}" '
                           f'y2="{yy}" stroke="{GRID}" stroke-dasharray="2,4"/>')
                out.append(f'<text x="{self.x(self.t_end) + 8}" y="{yy + 5}" '
                           f'font-size="14">{lvl}</text>')
            label = f'<tspan font-style="italic">{nm}</tspan>'
            if sub:
                label += f'<tspan font-size="12" dy="5">{sub}</tspan>'
            out.append(f'<text x="10" y="{yb - self.amp / 2 + 6}" font-size="19">{label}</text>')
            out.append(self.wave(iv, yb, color))
            if arrows:
                for a, b in iv:
                    if arrows in ("rise", "both") and 0 < a < self.t_end:
                        out.append(self.edge_arrow(a, yb, True))
                    if arrows in ("fall", "both") and 0 < b < self.t_end:
                        out.append(self.edge_arrow(b, yb, False))
        if self.axis:
            # Platz lassen, wenn unter der letzten Zeile eine Bemaßung steht
            ya = bottom_line + (40 if len(self.rows) - 1 in self.last_mark else 14)
            out.append(f'<line x1="{self.x(0)}" y1="{ya}" x2="{self.x(self.t_end) + 10}" '
                       f'y2="{ya}" stroke="{BLACK}" stroke-width="1.5" marker-end="url(#k)"/>')
            out.append(f'<text x="{self.x(self.t_end) + 10}" y="{ya + 22}" font-size="15" '
                       f'text-anchor="end">{self.axis}</text>')
        out += self.extra
        out.append("</svg>")
        (HERE / name).write_text("\n".join(out) + "\n", encoding="utf-8")
        print("geschrieben:", name)


# ============================================================ Diagramme

def temperatur():
    """SR-Latch hält einen Übertemperatur-Alarm fest (ohne Takt)."""
    T = 9.8
    S = [(1.0, 2.17), (3.33, 3.83), (5.83, 7.0)]
    R = [(7.67, 8.83)]
    q_edges, cause = sr_async(S, R, 0.2)
    d = Diagram([("S", "Temperatur", S, BLUE, None),
                 ("R", "Quittung", R, BLUE, None),
                 ("Q", "Alarm", from_edges(q_edges, T), RED, None)],
                T, unit=84, axis="Zeit", label_width=150)
    for t0, t1 in cause:
        d.delay(t0, t1, "2Δt", 2)
    d.svg("timeLineTemperaturAlarm.svg")


def synchrones_sr():
    """Taktzustandsgesteuertes SR-Latch: übernimmt nur bei Clk = 1."""
    T = 8.85
    CLK = clock(4)
    S = [(0.71, 2.43), (5.29, 5.71), (6.43, 6.86)]
    R = [(2.29, 2.71), (3.29, 3.86), (5.86, 6.57)]
    q_edges, cause = sr_level(S, R, CLK, DT2)
    d = Diagram([("Clk", None, CLK, BLACK, None),
                 ("S", None, S, BLUE, None),
                 ("R", None, R, BLUE, None),
                 ("Q", None, from_edges(q_edges, T), RED, None)],
                T, vlines=range(1, 9))
    for t0, t1 in cause:
        d.delay(t0, t1, "2Δt", 3)
    d.svg("timeLineSynchronesSR.svg")


def main_subsidiary():
    """Main übernimmt bei Clk = 1, Subsidiary gibt bei Clk = 0 weiter."""
    T = 10.6
    CLK = clock(5)
    S = [(0.5, 2.3), (5.3, 6.2), (9.25, 9.6)]
    R = [(2.7, 3.35), (7.25, 7.55), (9.6, T)]
    m_edges, m_cause = sr_level(S, R, CLK, DT2)
    QM = from_edges(m_edges, T)
    NQM = from_edges(m_edges, T, start=1)
    QM_low = from_edges(m_edges, T, start=1)
    CLKN = [(0, 1)] + [(b, b + 1) for _, b in CLK]          # invertierter Takt
    q_edges, q_cause = sr_level(QM, QM_low, CLKN, DT2)
    Q = from_edges(q_edges, T)
    d = Diagram([("Clk", None, CLK, BLACK, "both"),
                 ("S", None, S, BLUE, None),
                 ("R", None, R, BLUE, None),
                 ("Q", "Main", QM, RED, None),
                 ("S", "Subsidiary", QM, BLUE, None),
                 ("R", "Subsidiary", NQM, BLUE, None),
                 ("Q", None, Q, RED, None)],
                T, unit=84, vlines=range(1, 11), label_width=120)
    for t0, t1 in q_cause:
        src = 4 if level(Q, t1 + 0.01) else 5
        d.link(t0, src, t1, 6)
    d.delay(*m_cause[0], "2Δt", 3)
    d.delay(*q_cause[0], "2Δt", 6)
    d.svg("timeLineMainSubsidiary.svg")


def flankendetektor():
    """E direkt und über drei Inverter an ein UND: kurzer Puls an A."""
    T = 9.0
    E = [(2, T)]
    I1 = [(0, 3)]                # jeder Inverter: eine Gatterlaufzeit
    I2 = [(4, T)]
    B = [(0, 5)]
    A = [(2, 5)]                 # A = E · B (UND als ideal angenommen)
    d = Diagram([("E", None, E, BLUE, None),
                 ("I", "1", I1, BLUE, None),
                 ("I", "2", I2, BLUE, None),
                 ("B", None, B, BLUE, None),
                 ("A", None, A, RED, None)],
                T, unit=70, vlines=range(2, 6), axis="Zeit", label_width=60,
                row_h=80)
    d.delay(2, 3, "Δt", 1)
    d.delay(3, 4, "Δt", 2)
    d.delay(4, 5, "Δt", 3)
    d.delay(2, 5, "3Δt", 4)
    d.svg("timeLineFlankendetektor.svg")


def zustand_gegen_flanke():
    """Dieselben Eingänge an einem zustands- und einem flankengesteuerten SR-FF."""
    T = 7.8
    CLK = clock(4)
    S = [(0.71, 1.71), (5.71, 6.14)]
    R = [(2.29, 2.71), (3.29, 3.86), (4.86, 5.57)]
    lv_edges, lv_cause = sr_level(S, R, CLK, DT2)
    fl_edges, fl_cause = sr_rising(S, R, CLK, DT2)
    d = Diagram([("Clk", None, CLK, BLACK, "rise"),
                 ("S", None, S, BLUE, None),
                 ("R", None, R, BLUE, None),
                 ("Q", "zustandsgesteuert", from_edges(lv_edges, T), RED, None),
                 ("Q", "flankengesteuert", from_edges(fl_edges, T), RED, None)],
                T, unit=100, vlines=range(1, 8), label_width=175)
    for t0, t1 in lv_cause:
        d.delay(t0, t1, "2Δt", 3)
    for t0, t1 in fl_cause:
        d.delay(t0, t1, "2Δt", 4)
    d.svg("timeLineZustandFlanke.svg")


def jk():
    """Positiv flankengesteuertes JK-Flip-Flop, bei J = K = 1 kippt Q."""
    T = 7.8
    CLK = clock(4)
    J = [(0.71, 1.71), (4.86, 7.29)]
    K = [(2.29, 3.29), (3.86, 5.29), (6.71, 7.57)]
    q_edges, cause = jk_rising(J, K, CLK, DT2)
    d = Diagram([("Clk", None, CLK, BLACK, "rise"),
                 ("J", None, J, BLUE, None),
                 ("K", None, K, BLUE, None),
                 ("Q", None, from_edges(q_edges, T), RED, None)],
                T, unit=100, vlines=range(1, 8), label_width=80)
    for t0, t1 in cause:
        d.delay(t0, t1, "2Δt", 3)
    d.svg("timeLineJK.svg")


def asynchroner_zaehler():
    """Drei T-Flip-Flops (fallende Flanke), jedes taktet das nächste."""
    T = 16.8
    tau = 0.3
    CLK = [(k, min(k + 1, T)) for k in range(0, 18, 2)]   # fallend bei 1, 3, 5, …
    Q0, c0 = t_falling(CLK, tau, T)
    Q1, c1 = t_falling(Q0, tau, T)
    Q2, c2 = t_falling(Q1, tau, T)
    d = Diagram([("Clk", None, CLK, BLACK, "fall"),
                 ("Q", "0", Q0, RED, "fall"),
                 ("Q", "1", Q1, RED, "fall"),
                 ("Q", "2", Q2, RED, None)],
                T, unit=56, vlines=[b for _, b in CLK if b < T], label_width=70)
    d.bottom += 40
    d.delay(*c0[0], "τ", 1)
    d.delay(c1[0][0] - tau, c1[0][1], "2τ", 2)
    d.delay(c2[0][0] - 2 * tau, c2[0][1], "3τ", 3)
    falls = [b for _, b in CLK if b < T]
    for i, (a, b) in enumerate(zip(falls, falls[1:] + [T])):
        n = (i + 1) % 8
        if b - a > 1.5:
            d.text_below((a + b) / 2 + 0.3, f"{n:03b}")
    d.text_below(falls[0] / 2, "000")
    d.svg("timeLineAsynchronerZaehler.svg")


if __name__ == "__main__":
    temperatur()
    synchrones_sr()
    main_subsidiary()
    flankendetektor()
    zustand_gegen_flanke()
    jk()
    asynchroner_zaehler()

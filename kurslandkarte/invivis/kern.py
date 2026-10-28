"""invivis Kurslandkarte – gemeinsamer Kern.

Ein Kurs liefert nur Daten (Termine, Begriffe, Beziehungen, Fäden …) und ruft
`erzeuge(...)` auf. Der Kern prüft die Daten, schreibt kurslandkarte.json,
die Karte (index.html aus vorlage.html) und auf Wunsch die Startseite und die
Orientierungsfolien („Wo stehen wir?“ / „Nächster Halt“) in den Materialien.

Datenformate (Tupel, damit die Kursdateien kompakt bleiben):

  termine      (key, label, datum, kurz, datei|None, status, block)
               label: "VL 00", "VL 1", "Ü 1", "P 1" … – der Typ ist das erste Wort
               datum: Standard: ISO-Datum eines Tags der Woche – angezeigt wird die Kalenderwoche.
                      Mit KURS["tagesgenau"]: der echte Tag "2026-10-28", mehrere Tage
                      ["2026-11-25", "2026-11-26"] oder nur die Woche "2027-W21" (Tag noch offen);
                      KURS["uhrzeiten"] {"Mi": "11:30–13:00", …} ergänzt die Uhrzeit
  bloecke      {block: (name, farbe)}          farbe: "ph1".."ph4"
  linien       [(id, name, farbe)]             Themengebiete; farbe ("c1".."c7") wird seit 0.3.0 nicht mehr
                                               dargestellt – Farbe steht in der Karte nur für Fäden
  begriffe     (id, name, linie, termin, abschnittstitel|None, ebene, code, erklaerung, fehlvorstellung|None)
  beziehungen  (von, nach, text)               „von <text> nach“
  faeden       (id, name, beschreibung, [begriffs-ids chronologisch])
  anwendungen  (id, titel, fach, termin, abschnittstitel, beispiel, [begriffs-ids], herkunft)
  leitfragen   {termin: text}                  Leitfrage bzw. Ziel im Projekt
  freigegeben  {termin, …}                     Begriffe dieser Termine sind sichtbar
  anwendet     {termin: [begriffs-ids]}        z. B. Praktika, die nur anwenden
  brauchen     {termin: [begriffs-ids]}        Vorwissen für „Wo stehen wir?“ (sonst abgeleitet)

Autoren: Sebastian Zug, Ines Aubeln & Claude Code (Opus 5.5)
"""
import datetime, html, json, os, re, subprocess, sys

VERSION = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "VERSION"), encoding="utf-8").read().strip()
HIER = os.path.dirname(os.path.abspath(__file__))

# Voreinstellungen für einen reinen Vorlesungskurs; der Kurs überschreibt, was abweicht
STANDARD = {
    "einheit": "Vorlesung", "einheiten": "Vorlesungen", "einheiten_dat": "Vorlesungen", "gleich": "In derselben Vorlesung",
    "welche_einheit": "welcher Vorlesung", "der_einheit": "der Vorlesung",
    "liste": "Vorlesungen", "frage_label": "Leitfrage", "vor_pruefung": "vor Übung und Klausur",
    "freigabe": "erscheinen nach der Vorlesung, mit Ihren Vorschlägen",
    "folgen": "Die Begriffe dieser Vorlesung entstehen nach der Vorlesung – mit Ihren Vorschlägen.",
    "anwendung_daten": "Beispiel", "start_ansicht": "metro",
    "freigabe_satz": "Nach jeder Vorlesung kommen ihre Begriffe dazu, ergänzt um Ihre Vorschläge.",
    "spalten": [["VL", "Vorlesung"], ["Ü", "Übung"], ["P", "Praktikum"]],
    "woche": "Woche", "tagesgenau": False, "uhrzeiten": {},
    "status": {},
    "lernziele": [], "organisation": [], "kontakt": "", "lizenz": "",
}


def abschnitte(pfad):
    """Überschriften eines LiaScript-Dokuments in Folienreihenfolge (ohne Codeblöcke)."""
    s = open(pfad, encoding="utf-8").read()
    s = s[s.find("-->") + 3:]
    s = re.sub(r"^(`{3,4}).*?\n.*?\n\1", "", s, flags=re.S | re.M)
    return [m.group(2).strip().replace("`", "") for m in re.finditer(r"^(#{1,6}) +(.+)$", s, re.M)]


TAGE = ("Mo", "Di", "Mi", "Do", "Fr", "Sa", "So")


def _tag(d):
    return f"{d.day}.{d.month}."


def wann(feld, K):
    """Datum eines Termins → Woche (Montag, KW, Mo–Fr) und Anzeige („Mi 28.10. · 11:30–13:00“ bzw. „KW 44 · 26.–30.10.“)."""
    felder = [feld] if isinstance(feld, str) else list(feld)
    if len(felder) == 1 and re.fullmatch(r"\d{4}-W\d{2}", felder[0]):
        assert K["tagesgenau"], ("Wochenangabe nur mit tagesgenau", feld)
        y, w = felder[0].split("-W")
        tage, montag = [], datetime.date.fromisocalendar(int(y), int(w), 1)
    else:
        tage = [datetime.date.fromisoformat(x) for x in felder]
        assert tage == sorted(tage), ("Tage eines Termins nicht chronologisch", feld)
        montag = tage[0] - datetime.timedelta(days=tage[0].weekday())
        if not K["tagesgenau"]:
            tage = []
    kw, freitag = montag.isocalendar()[1], montag + datetime.timedelta(days=4)
    spanne = (f"{montag.day}.–" if montag.month == freitag.month else f"{_tag(montag)}–") + _tag(freitag)
    if tage:
        alle = " + ".join(f"{TAGE[d.weekday()]} {_tag(d)}" for d in tage)
        zeit = lambda d: K["uhrzeiten"].get(TAGE[d.weekday()])
        if len(tage) == 1:
            lang = alle + (f" · {zeit(tage[0])}" if zeit(tage[0]) else "")
        else:   # mehrere Tage: Uhrzeit je Tag, die Zeitfenster können verschieden sein
            lang = " + ".join(f"{TAGE[d.weekday()]} {_tag(d)}" + (f" {zeit(d)}" if zeit(d) else "") for d in tage)
        kurz = f"{TAGE[tage[0].weekday()]} {_tag(tage[0])}"
    else:
        lang, kurz = f"KW {kw} · " + ("Tag folgt" if K["tagesgenau"] else spanne), f"KW {kw}"
        alle = kurz
    ende = tage[-1] if tage else montag + datetime.timedelta(days=6)
    return {"montag": montag.isoformat(), "ende": ende.isoformat(), "tage": [d.isoformat() for d in tage], "kw": kw,
            "woche_tage": spanne, "wann": lang, "wann_kurz": kurz, "alle_tage": alle}


def typ(label):
    return label.split()[0]


def erzeuge(repo, kurs, termine, bloecke, linien, begriffe, beziehungen, faeden,
            anwendungen=(), leitfragen=None, freigegeben=(), anwendet=None, brauchen=None,
            karte="docs/kurslandkarte", startseite="docs/index.html", folien=False, vorschau="ausblick", pdf=None,
            pdf_ordner=None, pdf_termine=None):
    """vorschau: "ausblick" – kommende Begriffe stehen in den Daten und erscheinen mit „Ausblick“ blass;
                 "keine"    – nur Freigegebenes steht in der Seite (auch nicht im Quelltext).
       pdf:      {termin: url} – Link auf eine Druckfassung je Termin (überschreibt pdf_ordner).
       pdf_ordner: Ordner (relativ zum Repository) mit den Druckfassungen, z. B. "docs/pdf". Mit `--pdf` auf der
                 Kommandozeile werden fehlende oder veraltete PDFs vorher mit liaex erzeugt.
       pdf_termine: Termine, deren PDF gebaut und verlinkt wird (Standard: die freigegebenen)."""
    assert vorschau in ("ausblick", "keine"), vorschau
    pdf = dict(pdf or {})
    if pdf_ordner:
        pdf_termine = set(freigegeben if pdf_termine is None else pdf_termine)
        darf = [t for t in termine if t[4] and t[0] in pdf_termine]
        if "--pdf" in sys.argv:
            baue_pdfs(repo, [t[4] for t in darf], pdf_ordner)
        for t in darf:
            pfad = os.path.join(pdf_ordner, pdf_name(t[4]))
            if t[0] not in pdf and os.path.exists(os.path.join(repo, pfad)):
                pdf[t[0]] = os.path.relpath(pfad, karte)
    K = {**STANDARD, **kurs}
    leitfragen, anwendet, brauchen = leitfragen or {}, anwendet or {}, brauchen or {}
    stand = datetime.date.today().strftime("%d.%m.%Y")
    # Ab hier steht im Datumsfeld der Montag der Woche (Raster, „Sie sind hier“); die Anzeige kommt aus W
    W = {t[0]: wann(t[2], K) for t in termine}
    T = [(t[0], t[1], W[t[0]]["montag"]) + tuple(t[3:]) for t in termine]
    IDX = {t[0]: i for i, t in enumerate(T)}

    # ---- Prüfen
    assert len(IDX) == len(T) == len(W), "doppelter Termin-key"
    assert [t[2] for t in T] == sorted(t[2] for t in T), "Termine nicht chronologisch (Wochen)"
    tage = [W[t[0]]["tage"][0] for t in T if W[t[0]]["tage"]]
    assert tage == sorted(tage), "Termine nicht chronologisch (Tage)"
    for t in T:
        assert t[6] in bloecke, ("unbekannter Block", t)
        assert t[4] is None or os.path.exists(os.path.join(repo, t[4])), ("Datei fehlt", t)
    bl = [t[6] for t in T]
    assert bl == sorted(bl, key=list(bloecke).index), "Blöcke müssen zusammenhängen"
    ids = [b[0] for b in begriffe]
    assert len(set(ids)) == len(ids), ("doppelte id", [i for i in ids if ids.count(i) > 1])
    term_of = {b[0]: IDX[b[3]] for b in begriffe}
    linie_ids = {l[0] for l in linien}
    for b in begriffe:
        assert b[2] in linie_ids, ("unbekannte Linie", b[0], b[2])
    for fid, _, _, st in faeden:
        for x in st:
            assert x in term_of, (fid, x)
        for u, v in zip(st, st[1:]):
            assert term_of[u] <= term_of[v], ("Faden nicht chronologisch", fid, u, v)
    for a, b, _ in beziehungen:
        assert a in term_of and b in term_of, (a, b)
    for x in anwendungen:
        assert x[0] not in term_of, ("Anwendung und Begriff mit gleicher id", x[0])
        for k in x[6]:
            assert k in term_of, ("Anwendung nutzt unbekannten Begriff", x[0], k)
    for k, lst in list(anwendet.items()) + list(brauchen.items()):
        assert k in IDX, ("unbekannter Termin", k)
        for x in lst:
            assert x in term_of and term_of[x] < IDX[k], ("Begriff nicht vor dem Termin eingeführt", k, x)
    for k in list(leitfragen) + list(freigegeben):
        assert k in IDX, ("unbekannter Termin", k)

    def lese_abschnitte():
        return {t[0]: abschnitte(os.path.join(repo, t[4])) if t[4] else [] for t in T}

    def abschnitt_nr(sections, key, titel):
        if titel is None:
            return 0
        heads = sections[key]
        if titel not in heads:
            raise SystemExit(f"Abschnitt nicht gefunden: {T[IDX[key]][1]} »{titel}« — vorhanden: {heads}")
        return heads.index(titel) + 1

    karte_url = K["pages"].rstrip("/") + "/" + os.path.basename(karte.rstrip("/")) + "/"

    # ---- Orientierungsfolien in den Materialien (optional)
    if folien:
        _folien(repo, K, T, W, IDX, bloecke, begriffe, beziehungen, faeden, leitfragen, anwendet, brauchen, term_of, karte_url)
    # ---- Button zur Kurslandkarte unter der Zielstellung (nur wo die Markierung steht)
    _knopf(repo, K, T, karte_url)

    sections = lese_abschnitte()   # nach dem Einbetten: Folien können sich verschoben haben
    for b in begriffe:
        abschnitt_nr(sections, b[3], b[4])

    phasen, start = [], 0
    for i in range(1, len(T) + 1):
        if i == len(T) or T[i][6] != T[start][6]:
            name, farbe = bloecke[T[start][6]]
            phasen.append({"von": start, "bis": i - 1, "name": name, "farbe": farbe})
            start = i

    kurs_js = {k: K[k] for k in ("basis", "speicher", "einheit", "einheiten", "einheiten_dat", "gleich", "freigabe", "folgen", "spalten", "woche", "status", "anwendung_daten", "start_ansicht")}
    kurs_js["vorschau"] = vorschau
    # Vorschau „keine“: Begriffe nicht freigegebener Termine verlassen das Repository nicht
    frei = (lambda key: True) if vorschau == "ausblick" else (lambda key: key in freigegeben)
    b_frei = {b[0] for b in begriffe if frei(b[3])}
    out = {
        "stand": stand, "version": VERSION, "kurs": kurs_js,
        "linien": [{"id": i, "name": n, "farbe": f} for i, n, f in linien],
        "phasen": phasen,
        "vorlesungen": [
            {"vl": i, "key": str(t[0]), "label": t[1], "typ": typ(t[1]), "datei": t[4], "datum": t[2], "kurz": t[3],
             **{k: W[t[0]][k] for k in ("ende", "tage", "kw", "woche_tage", "wann", "wann_kurz")},
             "leitfrage": leitfragen.get(t[0]), "freigegeben": t[0] in freigegeben, "status": t[5], "block": t[6],
             "pdf": pdf.get(t[0]), "anwendet": [x for x in anwendet.get(t[0], []) if x in b_frei],
             "abschnitte": sections[t[0]] if frei(t[0]) else []}
            for i, t in enumerate(T)
        ],
        "begriffe": [
            {"id": b[0], "name": b[1], "linie": b[2], "vl": IDX[b[3]], "abschnitt": abschnitt_nr(sections, b[3], b[4]),
             "ebene": b[5], "code": bool(b[6]), "erklaerung": b[7], "fehlvorstellung": b[8]}
            for b in begriffe if b[0] in b_frei
        ],
        "beziehungen": [{"von": a, "nach": b, "text": t} for a, b, t in beziehungen if a in b_frei and b in b_frei],
        "faeden": [{"id": f, "name": n, "beschreibung": d, "stationen": [x for x in st if x in b_frei],
                    "weiter": any(x not in b_frei for x in st)}
                   for f, n, d, st in faeden if any(x in b_frei for x in st)],
        "anwendungen": [{"id": i, "titel": t, "fach": fa, "vl": IDX[v], "abschnitt": abschnitt_nr(sections, v, ab),
                         "datensatz": ds, "schlagworte": [x for x in sw if x in b_frei], "herkunft": h}
                        for i, t, fa, v, ab, ds, sw, h in anwendungen if frei(v)],
    }
    ziel = os.path.join(repo, karte)
    os.makedirs(ziel, exist_ok=True)
    text = json.dumps(out, ensure_ascii=False, indent=1)
    open(os.path.join(ziel, "kurslandkarte.json"), "w", encoding="utf-8").write(text + "\n")
    fuss = (f'Erzeugt mit <a href="https://github.com/TUBAF-IfI-LiaScript/invivis-kurslandkarte">invivis Kurslandkarte</a> {VERSION}'
            f' · Autoren: {html.escape(K["autoren"])}')
    ersetzen = {
        "DATEN": text.replace("</", "<\\/"), "STAND": stand, "VERSION": VERSION,
        "TITEL": html.escape(K["titel"]), "KURSNAME": html.escape(K["name"]),
        "BESCHREIBUNG": html.escape(f'Kurslandkarte {K["titel"]} ({K.get("hochschule", "")}): Begriffe, Zusammenhänge und didaktische Fäden.'),
        "AUTOREN": html.escape(K["autoren"]), "FEEDBACK": K["feedback"], "FUSS": fuss,
        "EINHEITEN": K["einheiten"], "FRAGE": K["frage_label"], "LISTE": K["liste"],
        "WELCHE_EINHEIT": K["welche_einheit"], "DER_EINHEIT": K["der_einheit"],
        "VOR_PRUEFUNG": K["vor_pruefung"], "FREIGABE_SATZ": K["freigabe_satz"],
        "AUSBLICK_SATZ": f' Mit <strong>Ausblick: An</strong> sehen Sie blass, was für kommende {K["einheiten"]} vorbereitet ist.' if vorschau == "ausblick" else "",
    }
    seite = open(os.path.join(HIER, "vorlage.html"), encoding="utf-8").read()
    seite = re.sub(r"%%([A-Z_]+)%%", lambda m: ersetzen[m.group(1)], seite)
    open(os.path.join(ziel, "index.html"), "w", encoding="utf-8").write(seite)

    if startseite:
        open(os.path.join(repo, startseite), "w", encoding="utf-8").write(_startseite(K, T, out, karte, startseite, stand))

    e1 = sum(1 for b in begriffe if b[5] == 1)
    print(f"{len(T)} Termine, {len(begriffe)} Begriffe ({e1} Kern, {len(begriffe) - e1} Detail), "
          f"{len(beziehungen)} Beziehungen, {len(anwendungen)} Anwendungen, {len(faeden)} Fäden · "
          f"{len(freigegeben)} Termine freigegeben · invivis {VERSION}")
    return out


# ---------------------------------------------------------------- Druckfassungen
def pdf_name(datei):
    """Name der Druckfassung: Dateiname des Materials, bei README.md der Ordnername."""
    stamm = os.path.splitext(os.path.basename(datei))[0]
    return (os.path.basename(os.path.dirname(datei)) if stamm.lower() == "readme" else stamm) + ".pdf"


def baue_pdfs(repo, dateien, ordner):
    """Erzeugt mit dem LiaScript-Exporter (liaex) jedes PDF, das fehlt oder älter als sein Material ist."""
    os.makedirs(os.path.join(repo, ordner), exist_ok=True)
    for datei in dateien:
        quelle, ziel = os.path.abspath(os.path.join(repo, datei)), os.path.abspath(os.path.join(repo, ordner, pdf_name(datei)))
        if os.path.exists(ziel) and os.path.getmtime(ziel) >= os.path.getmtime(quelle):
            continue
        print("PDF:", datei, "->", os.path.relpath(ziel, repo), flush=True)
        r = subprocess.run(["liaex", "-i", quelle, "-f", "pdf", "-o", ziel[:-4], "--pdf-timeout", "30000"],
                           cwd=os.path.dirname(quelle), capture_output=True, text=True)
        if r.returncode or not os.path.exists(ziel):
            print("  FEHLER beim Export:", (r.stderr or r.stdout).strip()[-300:], flush=True)


# ---------------------------------------------------------------- Startseite
def _startseite(K, T, out, karte, startseite, stand):
    karte_rel = os.path.relpath(karte, os.path.dirname(startseite) or ".") + "/"
    termine = [{"key": v["key"], "label": v["label"], "kurz": v["kurz"], "datum": v["datum"], "wann": v["wann"],
                "url": (K["basis"] + v["datei"]) if v["datei"] else None, "frage": v["leitfrage"],
                "pdf": os.path.relpath(os.path.join(karte, v["pdf"]), os.path.dirname(startseite) or ".") if v["pdf"] else None}
               for v in out["vorlesungen"]]
    e = html.escape
    lernziele = "".join(f"<li>{z}</li>" for z in K["lernziele"])
    orga = "".join(f"<dt>{e(a)}</dt><dd>{b}</dd>" for a, b in K["organisation"])
    seite = open(os.path.join(HIER, "startseite.html"), encoding="utf-8").read()
    ersetzen = {
        "TITEL": e(K["titel_lang"] if "titel_lang" in K else K["titel"]), "UNTERTITEL": e(K["name"]),
        "BESCHREIBUNG": e(K["beschreibung"]), "INHALT": K["beschreibung"],
        "AUTOREN": e(K["autoren"]), "VERSION": VERSION, "STAND": stand,
        "KARTE": karte_rel, "TERMINE": json.dumps(termine, ensure_ascii=False).replace("</", "<\\/"),
        "FRAGE": K["frage_label"],
        "LERNZIELE": f"<h2>Lernziele</h2>\n<p>Nach dem Kurs können Sie</p>\n<ol>{lernziele}</ol>" if lernziele else "",
        "ORGANISATION": f"<h2>Organisation</h2>\n<dl>{orga}</dl>" if orga else "",
        "KONTAKT": f"<h2>Kontakt</h2>\n<p>{K['kontakt']}</p>" if K["kontakt"] else "",
        "LIZENZ": K["lizenz"], "REPO": K["repo"],
    }
    return re.sub(r"%%([A-Z_]+)%%", lambda m: ersetzen[m.group(1)], seite)


# ---------------------------------------------------------------- Button zur Kurslandkarte
KNOPF = ("<!-- kurslandkarte:knopf-start -->", "<!-- kurslandkarte:knopf-ende -->")
# Gestaltung nach der Kurslandkarte: Linkfarbe, IBM Plex, Radius 0, keine Schatten; GitHub zeigt nur den Link
KNOPF_STIL = ("display: inline-block; padding: 0.5em 1.1em; background-color: #00718A; color: #ffffff; "
              "text-decoration: none; font-family: 'IBM Plex Sans', 'Segoe UI', system-ui, sans-serif; font-weight: 600;")


def _knopf(repo, K, T, karte_url):
    """Erneuert in jeder Vorlesung mit Material den Block zwischen den knopf-Markierungen.
    Die Markierung setzt der Kurs selbst (üblich: direkt unter der Zielstellung); ohne Markierung bleibt die Datei unberührt."""
    text = K.get("knopf_text", "🗺️ Diese Vorlesung in der Kurslandkarte →")
    for t in T:
        if typ(t[1]) != "VL" or not t[4]:
            continue
        pfad = os.path.join(repo, t[4])
        if not os.path.exists(pfad):
            continue
        s = open(pfad, encoding="utf-8").read()
        a, e = KNOPF
        if a not in s or e not in s:
            continue
        # Leerzeilen um den Link: LiaScript liest einen Kommentar direkt hinter einem Element als dessen Attribut
        block = f'{a}\n\n<a href="{karte_url}#termin={t[0]}" style="{KNOPF_STIL}">{text}</a>\n\n{e}'
        neu = s[:s.index(a)] + block + s[s.index(e) + len(e):]
        if neu != s:
            open(pfad, "w", encoding="utf-8").write(neu)


# ---------------------------------------------------------------- Orientierungsfolien
MARKE = {"wo": ("<!-- kurslandkarte:wo-start -->", "<!-- kurslandkarte:wo-ende -->"),
         "aus": ("<!-- kurslandkarte:ausblick-start -->", "<!-- kurslandkarte:ausblick-ende -->")}
# Markierung des heutigen Termins: fett und farbig hinterlegt (LiaScript-Stilkommentar; GitHub zeigt nur fett)
HEUTE = '<!-- style="background-color: rgba(255, 166, 0, 0.35); padding: 2px 6px; border-radius: 4px;" -->'


def _folien(repo, K, T, W, IDX, bloecke, begriffe, beziehungen, faeden, leitfragen, anwendet, brauchen, term_of, karte_url):
    name_of = {b[0]: b[1] for b in begriffe}
    spalten = [s for s in K["spalten"] if any(typ(t[1]) == s[0] for t in T)]

    def begriff_link(i, mit_termin=True):
        zusatz = f" ({T[term_of[i]][1]})" if mit_termin else ""
        return f"[{name_of[i].replace('_', chr(92) + '_')}]({karte_url}#begriff={i}){zusatz}"

    def blocktabelle(key):
        blk = T[IDX[key]][6]
        wochen = sorted({t[2] for t in T if t[6] == blk})
        def zelle(t):
            text = f"{t[1]} {t[3]}"
            if t[4]:
                text = f"[{text}]({K['basis']}{t[4]})"
            tag = f" · {W[t[0]]['alle_tage']}" if W[t[0]]["tage"] else ""
            return (f"**{text}**{HEUTE}" if t[0] == key else text) + tag
        z = ['<!-- data-type="none" -->', f"| {K['woche']} | " + " | ".join(s[1] for s in spalten) + " |",
             "| :-- " * (len(spalten) + 1) + "|"]
        for w in wochen:
            cells = [[zelle(t) for t in T if t[2] == w and t[6] == blk and typ(t[1]) == s[0]] for s in spalten]
            erster = W[next(t[0] for t in T if t[2] == w)]
            woche = f"KW {erster['kw']} · {erster['woche_tage']}"
            tag = f"**{woche}**{HEUTE}" if w == T[IDX[key]][2] else woche
            z.append(f"| {tag} | " + " | ".join("<br>".join(c) for c in cells) + " |")
        return z

    def wo_stehen_wir(key):
        i = IDX[key]
        t = T[i]
        nur_anwenden = key in anwendet
        heute = [b[0] for b in begriffe if b[3] == key and b[5] == 1]
        if nur_anwenden or key in brauchen:
            vorwissen = sorted((anwendet if nur_anwenden else brauchen)[key], key=lambda x: term_of[x])
        else:
            eigene = {b[0] for b in begriffe if b[3] == key}
            vorwissen = []
            for a, b_, _ in beziehungen:
                if b_ in eigene and term_of[a] < i and a not in vorwissen:
                    vorwissen.append(a)
            for _, _, _, st in faeden:
                for u, v in zip(st, st[1:]):
                    if v in eigene and term_of[u] < i and u not in vorwissen:
                        vorwissen.append(u)
            vorwissen = sorted(vorwissen, key=lambda x: -term_of[x])[:5]
            vorwissen.sort(key=lambda x: term_of[x])
        frage = leitfragen.get(key, "")
        blockname = bloecke[t[6]][0]
        z = [MARKE["wo"][0], "", "## Wo stehen wir?", ""]
        if typ(t[1]) == "VL":
            sprech = f"Kurz zur Orientierung. Wir sind in {blockname.split(' · ')[0]}, Termin {i + 1} von {len(T)}. {frage}"
            if heute:
                sprech += " Neu sind heute: " + ", ".join(name_of[x] for x in heute) + "."
            z += ["    --{{0}}--", sprech.strip(), ""]
        if frage:
            z += [f"**{K['frage_label']}:** {frage}", ""]
        z += [f"**{blockname}** – Termin {i + 1} von {len(T)}, heute farbig markiert", ""]
        z += blocktabelle(key) + [""]
        if vorwissen:
            z.append("- **Sie brauchen:** " + " · ".join(begriff_link(x) for x in vorwissen))
        elif i == 0:
            z.append("- **Sie brauchen:** nichts – wir fangen an")
        if nur_anwenden:
            z.append("- **Heute:** " + K.get("anwenden_text", "anwenden, nichts Neues"))
        elif heute:
            z.append("- **Heute neu:** " + " · ".join(begriff_link(x, False) for x in heute))
        z += ["", "> [!TIP]",
              f"> **Tipp – Kurslandkarte:** [Ganze Kurslandkarte öffnen]({karte_url}#termin={key}) – dort finden Sie jeden Begriff mit Erklärung, typischer Stolperfalle, Link auf die passende Folie und die roten Fäden durch die Veranstaltung.",
              "", MARKE["wo"][1]]
        return "\n".join(z)

    def ausblick(key):
        i = IDX[key]
        z = [MARKE["aus"][0], "", "--------------------------------------------------------------------------------", ""]
        # Vorlesungen kündigen die nächste Vorlesung an; Übungen und Praktika dazwischen
        # erscheinen als eigene Zeile, damit die Vorbereitung nicht verloren geht.
        j = i + 1
        if typ(T[i][1]) == "VL":
            while j < len(T) and typ(T[j][1]) != "VL":
                j += 1
        if j < len(T):
            n = T[j]
            ziel = leitfragen.get(n[0], "")
            z.append(f"**🗺️ Nächster Halt:** {n[1]} · {n[3]} ({W[n[0]]['wann']})" + (f" – {ziel}" if ziel else "")
                     + f" [Auf der Kurslandkarte ansehen]({karte_url}#termin={n[0]})")
        dazwischen = T[i + 1:j]
        if dazwischen:
            z += ["", "**Außerdem bis dahin:** " + " · ".join(
                f"[{d[1]} · {d[3]}]({karte_url}#termin={d[0]}) ({W[d[0]]['wann']})" for d in dazwischen)]
        z += ["", MARKE["aus"][1]]
        return "\n".join(z)

    def einbetten(datei, wo, aus):
        pfad = os.path.join(repo, datei)
        s = open(pfad, encoding="utf-8").read()
        for art, block in (("wo", wo), ("aus", aus)):
            a, e = MARKE[art]
            if a in s:
                s = s[:s.index(a)] + block + s[s.index(e) + len(e):]
            elif art == "wo":
                # vor die erste Überschrift zweiter Ebene außerhalb von Codeblöcken
                kopf = s.index("-->") + 3
                zeilen, pos, zaun = s[kopf:].split("\n"), kopf, False
                for zl in zeilen:
                    if zl.lstrip().startswith("```"):
                        zaun = not zaun
                    if not zaun and zl.startswith("## "):
                        break
                    pos += len(zl) + 1
                s = s[:pos] + block + "\n\n" + s[pos:]
            else:
                s = s.rstrip("\n") + "\n\n" + block + "\n"
        open(pfad, "w", encoding="utf-8").write(s)

    for t in T:
        if t[5] in K.get("folien_status", ("ausgearbeitet",)) and t[4]:
            einbetten(t[4], wo_stehen_wir(t[0]), ausblick(t[0]))

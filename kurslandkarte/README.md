# Kurslandkarte

Interaktive Übersicht über Begriffe, Zusammenhänge und didaktische Fäden der Vorlesung für Studierende – in drei Ansichten: Vorlesungen (Liste, Standard auf dem Handy), Metrokarte und Zeitleiste. „Sie sind hier“ ergibt sich aus dem Datum. Veröffentlicht über GitHub Pages (Wurzelverzeichnis von `master`): https://tubaf-ifi-liascript.github.io/VL_EingebetteteSysteme/kurslandkarte/

| Datei | Inhalt |
| :---- | :----- |
| `erzeuge.py` | Kuratierte Daten (Begriffe, Beziehungen, Anwendungen, Fäden, Termine, Leitfragen) und Erzeugung von Daten und Seite |
| `vorlage.html` | Ansicht; `%%DATEN%%` und `%%STAND%%` werden beim Erzeugen ersetzt (abgeleitet von der Kurslandkarte in VL_EAVD) |
| `kurslandkarte.json` | erzeugt: alle Daten |
| `index.html` | erzeugt: die veröffentlichte Seite |

## Aktualisieren

Nach Änderungen an Vorlesungen oder Begriffen im Wurzelverzeichnis des Repositorys:

```bash
python3 kurslandkarte/erzeuge.py
```

Begriffe verweisen in `erzeuge.py` auf den **Titel** ihres Abschnitts (ohne Backticks); das Skript liest die Abschnitte automatisch aus den Vorlesungsdateien und ermittelt daraus die LiaScript-Foliennummer. Es bricht ab, wenn ein Abschnittstitel nicht mehr existiert, eine Beziehung auf einen unbekannten Begriff verweist oder ein Faden nicht chronologisch verläuft. Die erzeugten Dateien werden mit eingecheckt.

## Nach jeder Vorlesung: Begriffe freischalten

Die Karte zeigt nur die Begriffe freigegebener Vorlesungen; für alle anderen Termin, Titel und Leitfrage. Mit „Ausblick: An“ sehen Neugierige die vorbereiteten Begriffe blass.

1. Begriffe der Vorlesung mit dem tatsächlich Behandelten abgleichen, Vorschläge der Studierenden aufnehmen.
2. Die Vorlesung in `FREIGEGEBEN` eintragen, `python3 kurslandkarte/erzeuge.py`, committen.

## Datenmodell

* **Vorlesung:** `vl`, `datei`, `datum` (erster Termin, ISO), `kurz`, `leitfrage`, `freigegeben`, `status`, `abschnitte`
* **Begriff:** `id`, `name`, `linie` (`grundlagen`, `logik`, `zustand`, `rechner`, `controller`), `vl`, `abschnitt`, `ebene` (1 = Kern, 2 = Detail), `code`, `erklaerung`, `fehlvorstellung`
* **Beziehung:** `von`, `nach`, `text` (gelesen als „von … text … nach“)
* **Anwendung:** `id` (`a_…`), `titel`, `fach` (Anwendungsfeld), `vl`, `abschnitt`, `datensatz` (das konkrete Beispiel), `schlagworte`, `herkunft`
* **Faden:** `id`, `name`, `beschreibung`, `stationen` (chronologisch)

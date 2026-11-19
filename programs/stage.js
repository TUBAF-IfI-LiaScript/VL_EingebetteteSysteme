// Gemeinsame Hilfen für die Simulatoren des Modellrechners.
//
// fitStage(): Die Oberflächen sind absolut positioniert und für eine feste
// Größe gezeichnet. Alles liegt in <div id="stage" style="width:…; height:…">;
// dieses Element wird auf die Fenstergröße (bzw. die Größe des iframes)
// skaliert.
//
// simParams(): Parameter aus der URL, sowohl ?name=wert als auch #name=wert
// (der Teil nach # funktioniert auch auf Servern, die keine Query-Strings
// an statische Dateien erlauben). Werte nach # haben Vorrang.

function fitStage() {
    const stage = document.getElementById("stage");
    if (!stage) return;
    const s = Math.min(window.innerWidth / stage.offsetWidth,
                       window.innerHeight / stage.offsetHeight);
    stage.style.transform = "scale(" + s + ")";
}
window.addEventListener("resize", fitStage);
window.addEventListener("load", fitStage);

function simParams() {
    const params = new URLSearchParams(window.location.search);
    new URLSearchParams(window.location.hash.replace(/^#/, ""))
        .forEach((value, key) => params.set(key, value));
    return params;
}

<!--
author:   Sebastian Zug

email:    sebastian.zug@informatik.tu-freiberg.de

version:  0.0.3
icon: https://upload.wikimedia.org/wikipedia/commons/d/de/Logo_TU_Bergakademie_Freiberg.svg
comment:  This file provides commonly used meta information for all LiaScript courses in the folder

@config.semester:   `Wintersemester 2026/27`
@config.lecture:    `Digitale Systeme / Eingebettete Systeme`

@onload
// PDF-Export: Das PDF-Paket des Exporters enthält kein KaTeX-CSS, jede Formel erscheint sonst doppelt
if (/\/assets\/pdf\//.test(window.location.href)) {
  const attach = Element.prototype.attachShadow
  Element.prototype.attachShadow = function (options) {
    const root = attach.call(this, options)
    if (this.tagName === 'LIA-FORMULA') {
      const style = document.createElement('style')
      style.textContent = '.katex-html { display: none; }'
      root.appendChild(style)
    }
    return root
  }
}
@end

-->

# Config variables

```
@config.semester:   `Wintersemester 2026/27`
@config.lecture:    `Digitale Systeme / Eingebettete Systeme`
```

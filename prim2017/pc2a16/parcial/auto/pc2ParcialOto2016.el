(TeX-add-style-hook
 "pc2ParcialOto2016"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "letter" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "letterpaper" "right=1.25in" "left=1.25in" "top=1in" "bottom=1in") ("inputenc" "utf8") ("fontenc" "T1") ("graphicx" "pdftex") ("helvet" "scaled=.90") ("natbib" "longnamesfirst" "sort") ("hyperref" "colorlinks=true") ("babel" "spanish")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "geometry"
    "setspace"
    "inputenc"
    "fontenc"
    "amsmath"
    "url"
    "graphicx"
    "tikz"
    "mathptmx"
    "helvet"
    "courier"
    "natbib"
    "rotating"
    "caption"
    "hyperref"
    "babel")
   (TeX-add-symbols
    "mc"))
 :latex)


Project file for TeXnix Center (windows) included.


Create pdf file from tex input:
"pdflatex *[.tex]"
Run "pdflatex --help" to show options.
Often the root file of a latex document is called "main.tex".

Run pdflatex as many times as necessary to resolve index issues etc.:
"texify *[.tex]"
Run "texify --help" to show options.

Use "-interaction=nonstopmode" option to supress interactive prompt during compiling when errors/warnings occur.

Use "-halt-on-error" to stop compilation after first error, helps when trying to fix errors one by one.

If references/bibliographie is generated by bibtex do
"latex main[.tex]"
"bibtex main[.tex]"
"latex main[.tex]"
"pdflatex main[.tex]" or "latex main.[tex]" depending on desired output.


latex -interaction=nonstopmode main.tex
bibtex main
latex -interaction=nonstopmode main
dvips -interaction=nonstopmode main
pdflatex -interaction=nonstopmode main

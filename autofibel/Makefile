
TEXMFHOME = $(CURDIR)/texmf

export TEXMFHOME

.PHONY: tests all clean

LULUBOOK=texmf/tex/latex/lulubook/lulubook.cls
AUTOFIBEL=texmf/tex/latex/autofibel/autofibel.cls

TESTFILES=\
  t/Roman/1.pdf\
  t/Carré/1.pdf

# MAIN LATEXMK RULE
# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -jobname sets the outputfile without .pdf suffix
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

#$(AUTOFIBEL): $(LULUBOOK)
#	true

%.pdf: %.tex
	latexmk -pdf -jobname=$(basename $@) -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

fibel.pdf: fibel.tex $(AUTOFIBEL) $(LULUBOOK)

all: tests fibel.pdf

tests: $(LULUBOOK) $(TESTFILES)

# does not work :)
clean:
	rm -f t/*/*.pdf

.PHONY: all clean install

# Python virtual environment
VENV = .venv
PYTHON = $(VENV)/bin/python
HTMLMIN = $(VENV)/bin/htmlmin

all: 39-bead-min.html README.pdf

install:
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install -r requirements.txt

%-min.html: %.html
	$(HTMLMIN) $< $@

39-bead.html: 39-bead.qmd miklos1.md krisztian.qmd miklos2.md terminal.html
	quarto render 39-bead.qmd

README.pdf: README.md preamble-slides.tex
	pandoc README.md -t beamer --pdf-engine=lualatex --slide-level 2 -H preamble-slides.tex -o README.pdf

README.md: 39-bead.qmd
	quarto render 39-bead.qmd --to markdown --output README.md

clean:
	rm -f README.tex README.aux README.log README.nav README.out README.snm README.toc README.vrb
	rm -f 39-bead.html
	rm -rf 39-bead_files/

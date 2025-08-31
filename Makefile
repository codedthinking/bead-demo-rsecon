.PHONY: all clean

all: demo.html README.pdf

demo.html: demo.qmd miklos1.md miklos2.md scroll.html
	quarto render demo.qmd

README.pdf: README.md preamble-slides.tex
	pandoc README.md -t beamer --pdf-engine=lualatex --slide-level 2 -H preamble-slides.tex -o README.pdf

README.md: demo.qmd
	quarto render demo.qmd --to markdown --output README.md

clean:
	rm -f README.tex README.aux README.log README.nav README.out README.snm README.toc README.vrb
	rm -f demo.html
	rm -rf demo_files/
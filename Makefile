.PHONY: all clean

all: demo.html README.pdf

demo.html: demo.qmd
	quarto render demo.qmd

README.pdf: README.md
	quarto render README.md --to pdf --pdf-engine lualatex

README.md: demo.qmd
	quarto render demo.qmd --to markdown --output README.md

clean:
	rm -f README.tex README.aux README.log README.nav README.out README.snm README.toc README.vrb
	rm -f demo.html
	rm -rf demo_files/
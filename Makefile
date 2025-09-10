.PHONY: all clean

IMAGES := $(wildcard images/*.png)

all: 39-bead.html

39-bead.html: 39-bead.qmd miklos1.md krisztian.qmd miklos2.md terminal.html $(IMAGES)
	quarto render 39-bead.qmd

39-bead.pdf:
	docker run --rm -t -v `pwd`:/slides ghcr.io/astefanutti/decktape https://bead.zip/rsecon25 39-bead.pdf

README.md: 39-bead.qmd
	quarto render 39-bead.qmd --to markdown --output README.md

clean:
	rm -f README.tex README.aux README.log README.nav README.out README.snm README.toc README.vrb
	rm -f 39-bead.html
	rm -rf 39-bead_files/

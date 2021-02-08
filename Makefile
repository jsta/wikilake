
all: docs/index.html

docs/index.html:
	Rscript -e "pkgdown::build_site()"

clean:
	rm docs/index.html

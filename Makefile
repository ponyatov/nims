all:

MERGE  = Makefile .gitignore README.md
MERGE += cross bare mips
MERGE += FORTH habr
MERGE += droid/.gitignore
MERGE += IoT
MERGE += metaL
MERGE += mips

merge:
	git checkout master
	git checkout ponyatov -- $(MERGE)

NOW = $(shell date +%d%m%d)
REL = $(shell git rev-parse --short=4 HEAD)
release:
	git tag $(NOW)-$(REL)
	git push --tags gh
	git checkout ponyatov

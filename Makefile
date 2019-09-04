all:

MERGE  = Makefile .gitignore README.md
MERGE += cross bare mips
MERGE += FORTH

merge:
	git checkout master
	git checkout ponyatov -- $(MERGE)

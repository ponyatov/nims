all:

MERGE  = Makefile .gitignore README.md
MERGE += cross bare mips
MERGE += FORTH habr
MERGE += droid/.gitignore

merge:
	git checkout master
	git checkout ponyatov -- $(MERGE)

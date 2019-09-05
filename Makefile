all:

MERGE  = Makefile .gitignore README.md
MERGE += cross bare mips
MERGE += FORTH habr
MERGE += droid/.gitignore
MERGE += anygui
MERGE += IoT

merge:
	git checkout master
	git checkout ponyatov -- $(MERGE)

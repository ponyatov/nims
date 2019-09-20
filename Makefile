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

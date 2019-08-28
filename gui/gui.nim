##  https://habr.com/ru/post/135809/
##  https://developer.gnome.org/gtk-tutorial/stable/

{.compile: "gui.c".}
proc gui_init*() {.importc.}

gui_init()

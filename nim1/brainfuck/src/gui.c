// https://habr.com/ru/post/135809/
// https://developer.gnome.org/gtk-tutorial/stable/

#include <gtk/gtk.h>

extern void gui_init() {
    gtk_init(&argc, &argv);
}

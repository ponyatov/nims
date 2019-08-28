// https://habr.com/ru/post/135809/
// https://developer.gnome.org/gtk-tutorial/stable/

#include <gtk/gtk.h>

GtkWidget *window;

int main(int argc, char *argv[]) {

    gtk_init (&argc, &argv);

// //extern void gui_init() {
//     gtk_init(0,NULL);//&argc, &argv);

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(gtk_main_quit), NULL);
    gtk_window_set_title(GTK_WINDOW(window), "Введение в GTK");
    // gtk_container_set_border_width (GTK_CONTAINER(window), 50);

    gtk_widget_show_all(window);

    gtk_main();

    return 0;
}

"""Select All and Copy All context-menu actions for GTK3 Terminator.

Inspired by egroeper/terminator-plugins (GPL-2.0-only).
"""
from gi.repository import Gtk
import terminatorlib.plugin as plugin

AVAILABLE = ['SelectAll', 'CopyAll']


class SelectAll(plugin.MenuItem):
    capabilities = ['terminal_menu']

    def callback(self, menuitems, menu, terminal):
        item = Gtk.MenuItem(label='Select all')
        item.connect('activate', self.select_all, terminal)
        menuitems.append(item)

    def select_all(self, _widget, terminal):
        terminal.vte.select_all()


class CopyAll(plugin.MenuItem):
    capabilities = ['terminal_menu']

    def callback(self, menuitems, menu, terminal):
        item = Gtk.MenuItem(label='Copy all to clipboard')
        item.connect('activate', self.copy_all, terminal)
        menuitems.append(item)

    def copy_all(self, _widget, terminal):
        vte = terminal.vte
        vte.select_all()
        # VTE GTK3; copy_clipboard() remains available on supported versions.
        vte.copy_clipboard()
        vte.unselect_all()

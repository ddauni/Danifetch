PREFIX = /usr
MANDIR = $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install danifetch.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p danifetch.sh $(DESTDIR)$(PREFIX)/bin/danifetch
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/danifetch

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/danifetch


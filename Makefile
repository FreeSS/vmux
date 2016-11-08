# #!/usr/bin/env make -f
# See LICENSE file for copyright and license details.

VERSION = 0.4
DESTDIR = /usr
SCRIPTS = scripts/nvim.vmux scripts/vim.vmux scripts/gvim.vmux
SRC = vmux

all: install-wrapper

clean:
	@echo cleaning
	@rm -f vmux-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p vmux-${VERSION}
	@cp -R LICENSE Makefile README.md ${SRC} scripts vmux-${VERSION}
	@tar -zcf vmux-${VERSION}.tar.gz vmux-${VERSION}
	@rm -rf vmux-${VERSION}

install: vmux
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f vmux ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/vmux

install-wrapper: install $(SCRIPTS)
	@echo installing wrapper scripts to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ${SCRIPTS} ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/nvim.vmux ${DESTDIR}${PREFIX}/bin/vim.vmux ${DESTDIR}${PREFIX}/bin/gvim.vmux

uninstall:
	@echo removing executable files from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/vmux ${DESTDIR}${PREFIX}/bin/nvim.vmux ${DESTDIR}${PREFIX}/bin/vim.vmux ${DESTDIR}${PREFIX}/bin/gvim.vmux

.PHONY: clean dist install install-wrapper uninstall

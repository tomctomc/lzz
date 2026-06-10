# Convenience driver.  The recursive lzz build system lives in Makefile.build
# and is driven by tools/build.sh, which sets up the bootstrap environment and
# builds on local disk (see test/README for why).
#
#   make            build build/lzz and build/lzz-static, run the probe suite
#   make install    build, then install the static binary as /usr/local/bin/lzz
#   make test       build, then run probes and the sdt corpus byte-compare
#   make gate       regenerate parser tables from rules.txt and byte-compare
#   make clean      remove the scratch build directory (local disk)
#   make cleanall   clean, and also remove the built binaries in build/
#
# Fresh install on any machine:  make cleanall && make install

export BUILDROOT ?= /tmp/lzz-build-$(USER)

all:
	tools/build.sh

install: all
	sudo install -m 755 build/lzz-static /usr/local/bin/lzz
	@echo "installed build/lzz-static as /usr/local/bin/lzz"

test: all
	test/run_probes.sh build/lzz-static
	test/run_corpus.sh build/lzz-static

gate:
	test/run_gate.sh

clean:
	rm -rf $(BUILDROOT)

cleanall: clean
	rm -rf build

.PHONY: all install test gate clean cleanall

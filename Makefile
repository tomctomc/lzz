# Convenience driver.  The recursive lzz build system lives in Makefile.build
# and is driven by tools/build.sh, which sets up the bootstrap environment and
# builds on local disk (see test/README for why).
#
#   make            build, run probes, put the static binary at bin/lzz-`uname -m`
#   make install    build, then copy bin/* verbatim to /usr/local/bin
#   make test       build, then run probes and the sdt corpus byte-compare
#   make gate       regenerate parser tables from rules.txt and byte-compare
#   make clean      remove the scratch build directory (local disk)
#   make cleanall   clean, and also remove build/ (bin/ is NEVER deleted)
#
# bin/ holds the lzz dispatcher script (picks bin/lzz-`uname -m` at runtime)
# and one static binary per architecture; build on each arch once and the
# same bin/ contents install everywhere.
#
# Fresh install on any machine:  make cleanall && make install

export BUILDROOT ?= /tmp/lzz-build-$(USER)

all:
	tools/build.sh

install: all
	sudo cp -p bin/* /usr/local/bin/
	@echo "installed: $$(cd bin && echo *) -> /usr/local/bin/"

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

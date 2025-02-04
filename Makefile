Z3_REF ?= master

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	prebuiltPkg=z3-4.8.13-x64-osx-10.16
else
	prebuiltPkg=z3-4.8.13-x64-glibc-2.31
endif

all: lib test

clean:
	rm -rf lib

gofmt:
	@echo "Checking code with gofmt.."
	gofmt -s *.go >/dev/null

test: gofmt
	go test -v

lib:
	curl -L "https://github.com/Z3Prover/z3/releases/download/z3-4.8.13/$(prebuiltPkg).zip" -o libz3.zip
	unzip libz3.zip
	mv $(prebuiltPkg) lib

.PHONY: all clean test lib

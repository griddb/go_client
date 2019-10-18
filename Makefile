SWIG = swig -DSWIGWORDSIZE64

CLIENT_TYPE = GRIDDB_GO

ARCH = $(shell arch)

SWIG_GO_SOURCE = src/griddb_go.cxx

EXTRA = src/griddb_go.go

SWIG_DEF = src/griddb.i

all: build

SWIG_DEF = src/griddb.i

$(SWIG_GO_SOURCE) : $(SWIG_DEF)
	mkdir -p src/github.com/griddb
	ln -s `pwd`/src `pwd`/src/github.com/griddb/go_client
	$(SWIG) -D$(CLIENT_TYPE) -outdir src/github.com/griddb/go_client/ -o $@ -c++ -go -cgo -use-shlib -intgosize 64 $(SWIG_DEF)
	
build: $(SWIG_GO_SOURCE)
	export CGO_CXXFLAGS="-DGRIDDB_GO -std=c++0x -I$$\{SRCDIR\}/../include" \
	&& export CGO_LDFLAGS="-L$$\{SRCDIR\}/../libs -lrt -lgridstore" \
	&& go install github.com/griddb/go_client

clean:
	rm -rf $(SWIG_GO_SOURCE) $(EXTRA)
	rm -rf src/github.com _obj pkg
	go clean

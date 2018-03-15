SWIG = swig -DSWIGWORDSIZE64
CXX = g++

ARCH = $(shell arch)

LDFLAGS = -Llibs -lpthread -lrt -lgridstore
CPPFLAGS = -fPIC -std=c++0x -g -O2
INCLUDES = -Iinclude -Isrc

INCLUDES_GO = $(INCLUDES)
CPPFLAGS_GO = $(CPPFLAGS) $(INCLUDES_GO)

PROGRAM = griddb_go.so
EXTRA = griddb_go.go

SOURCES = 	  src/TimeSeriesProperties.cpp \
		  src/ContainerInfo.cpp			\
  		  src/AggregationResult.cpp	\
		  src/Container.cpp			\
		  src/Store.cpp			\
		  src/StoreFactory.cpp	\
		  src/PartitionController.cpp	\
		  src/Query.cpp				\
		  src/Row.cpp				\
		  src/QueryAnalysisEntry.cpp			\
		  src/RowKeyPredicate.cpp	\
		  src/RowSet.cpp			\
		  src/TimestampUtils.cpp			\


all: $(PROGRAM)

SWIG_DEF = src/griddb.i

SWIG_GO_SOURCES     = src/griddb_go.cxx

OBJS = $(SOURCES:.cpp=.o)
SWIG_GO_OBJS = $(SWIG_GO_SOURCES:.cxx=.o)

$(SWIG_GO_SOURCES) : $(SWIG_DEF)
	mkdir -p src/github.com/griddb
	ln -s `pwd`/src `pwd`/src/github.com/griddb/go_client
	$(SWIG) -outdir src/github.com/griddb/go_client/ -o $@ -c++ -go -cgo -use-shlib -intgosize 64 $<
	sed -i "/^import \"C\"/i// #cgo CPPFLAGS: -std=c++0x -I$$\{SRCDIR\}/../include\n// #cgo LDFLAGS: -L$$\{SRCDIR\}/../libs -lrt -lgridstore" src/griddb_go.go

.cpp.o:
	$(CXX) $(CPPFLAGS) -c -o $@ $(INCLUDES) $<

$(SWIG_GO_OBJS): $(SWIG_GO_SOURCES)
	$(CXX) $(CPPFLAGS_GO) -c -o $@ -lstdc++ $<

griddb_go.so: $(OBJS) $(SWIG_GO_OBJS)
	$(CXX) -shared  -o $@ $(OBJS) $(SWIG_GO_OBJS) $(LDFLAGS) $(LDFLAGS_GO)
	go install github.com/griddb/go_client

clean:
	rm -rf $(OBJS) $(SWIG_GO_OBJS)
	rm -rf $(SWIG_GO_SOURCES)
	rm -rf $(PROGRAM) $(EXTRA)
	rm -rf src/github.com
	go clean

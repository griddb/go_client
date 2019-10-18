set PATH=%PATH%;%cd%\libs;
set change=/
set absolute_path=%cd%
call set absolute_gcc=%%absolute_path:\=%change%%%
set GOPATH=%cd%
set CGO_CXXFLAGS=-DGRIDDB_GO -std=c++0x -I%absolute_gcc%/include
set CGO_LDFLAGS=-L%absolute_gcc%/libs -lgridstore_c
RD /S /Q %cd%\src\github.com
RD /S /Q %cd%\pkg
mkdir %cd%\src\github.com\griddb
mklink /d %cd%\src\github.com\griddb\go_client %cd%\src
swig -outdir %cd%\src\github.com\griddb\go_client -o %cd%\src\griddb_go.cxx -c++ -go -cgo -use-shlib -intgosize 64 %cd%\src\griddb.i
go install github.com/griddb/go_client
GridDB Go Client

## Overview

GridDB Go Client is developed using GridDB C Client and [SWIG](http://www.swig.org/) (Simplified Wrapper and Interface Generator).  

## Operating environment

Building of the library and execution of the sample programs have been checked in the following environment.

    OS:              CentOS 6.7(x64)
    SWIG:            3.0.12
    GCC:             4.4.7
    Go:              1.9
    GridDB Server and C Client:   4.0 CE / 3.0 CE

## QuickStart
### Preparations

Install SWIG as below.

    $ wget https://sourceforge.net/projects/pcre/files/pcre/8.39/pcre-8.39.tar.gz
    $ tar xvfz pcre-8.39.tar.gz
    $ cd pcre-8.39
    $ ./configure
    $ make
    $ make install

    $ wget https://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz
    $ tar xvfz swig-3.0.12.tar.gz
    $ cd swig-3.0.12
    $ ./configure
    $ make
    $ make install

Set LIBRARY_PATH. 

    export LIBRARY_PATH=$LIBRARY_PATH:<C client library file directory path>

### Build and Run 

    1. Execute the command on project directory.

    $ make

    2. Set the GOPATH variable for griddb Go module files.
    
    $ export GOPATH=$GOPATH:<installed directory path>

    3. Import "github.com/griddb/go_client" in Go.

### How to run sample

GridDB Server need to be started in advance.

    1. Set LD_LIBRARY_PATH and GODEBUG

        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:<C client library file directory path>

        export GODEBUG=cgocheck=0

    2. The command to run sample

        $ go run sample/sample1.go <GridDB notification address> <GridDB notification port>
            <GridDB cluster name> <GridDB user> <GridDB password>
          -->Person: name=name02 status=false count=1 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]

## Function

(available)
- STRING, BOOL, BYTE, SHORT, INTEGER, LONG, FLOAT, DOUBLE, TIMESTAMP, BLOB type for GridDB
- put single row, get row with key
- normal query, aggregation with TQL
- Multi-Put/Get/Query (batch processing)

(not available)
- GEOMETRY, Array type for GridDB
- timeseries compression
- timeseries-specific function like gsAggregateTimeSeries, gsQueryByTimeSeriesSampling in C client
- trigger, affinity

Please refer to the following files for more detailed information.  
- [Go Client API Reference](https://griddb.github.io/go_client/GoAPIReference.htm)

Note:
1. After calling a method getting GridDB object, user must call DeleteClassName() function for each object.
   If possible, we recommend to use a defer of the DeleteClassName call like sample1.go.
2. The current API might be changed in the next version. e.g. ContainerInfo()
3. When you use GridDB V3.0 CE, please replace gridstore.h with gridstoreForV3.0.h on include/ folder and build sources.

## Community

  * Issues  
    Use the GitHub issue function if you have any requests, questions, or bug reports. 
  * PullRequest  
    Use the GitHub pull request function if you want to contribute code.
    You'll need to agree GridDB Contributor License Agreement(CLA_rev1.1.pdf).
    By using the GitHub pull request function, you shall be deemed to have agreed to GridDB Contributor License Agreement.

## License
  
  GridDB Go Client source license is Apache License, version 2.0.

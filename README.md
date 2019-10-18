GridDB Go Client

## Overview

GridDB Go Client is developed using GridDB C Client and [SWIG](http://www.swig.org/) (Simplified Wrapper and Interface Generator).  

## Operating environment

Building of the library and execution of the sample programs have been checked in the following environment.

    OS: CentOS 7.6(x64) (GCC 4.8.5)
    SWIG: 3.0.12
    Go: 1.12
    GridDB C client: V4.2 CE(Community Edition)
    GridDB server: V4.2 CE, CentOS 7.6(x64) (GCC 4.8.5)

    OS: Ubuntu 18.04(x64) (gcc 7.3.0)
    SWIG: 3.0.12
    Go: 1.12
    GridDB C client: V4.2 CE (Note: If you build from source code, please use GCC 4.8.5.)
    GridDB server: V4.2 CE, Ubuntu 18.04(x64) (Note: If you build from source code, please use GCC 4.8.5.)
    
    OS: Windows 10(x64) (gdm64-gcc 5.1.0)
    SWIG: 3.0.12
    Go: 1.12
    GridDB C client: V4.2 CE
    GridDB server: V4.2 CE, CentOS 7.6(x64) (GCC 4.8.5)

## QuickStart (CentOS, Ubuntu)
### Preparations

Install SWIG as below.

    $ wget https://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz
    $ tar xvfz swig-3.0.12.tar.gz
    $ cd swig-3.0.12
    $ ./configure
    $ make
    $ sudo make install
   
    Note: If CentOS, you might need to install pcre in advance.
    $ sudo yum install pcre2-devel.x86_64

Install Go.

Install [GridDB Server](https://github.com/griddb/griddb_nosql) and [C Client](https://github.com/griddb/c_client). (Note: If you build them from source code, please use GCC 4.8.5.) 

Set LIBRARY_PATH. 

    export LIBRARY_PATH=$LIBRARY_PATH:<C client library file directory path>

### Build and Run 

    1. Set the GOPATH variable for griddb Go module files.

        $ export GOPATH=$GOPATH:<installed directory path>

    2. Execute the command on project directory.

        $ make

    3. Import "github.com/griddb/go_client" in Go.

### How to run sample

GridDB Server need to be started in advance.

    1. Set LD_LIBRARY_PATH

        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:<C client library file directory path>

    2. The command to run sample

        $ go run sample/sample1.go <GridDB notification address> <GridDB notification port>
            <GridDB cluster name> <GridDB user> <GridDB password>
          -->Person: name=name02 status=false count=1 lob=[65, 66, 67, 68, 69, 70, 71, 72, 73, 74]

## QuickStart (Windows)
### Preparations

Install SWIG as below.
- Download zip package from https://sourceforge.net/projects/swig/files/swigwin/swigwin-3.0.12/swigwin-3.0.12.zip/download
- Extract the zip package then set PATH variable for swig tool.

Install GO
- Download and install package from https://dl.google.com/go/go1.12.8.windows-amd64.msi

Install [GridDB Server](https://github.com/griddb/griddb_nosql) on CentOS. (Note: If you build them from source code, please use GCC 4.8.5.) 

Install GridDB C Client.
- Please refer to https://github.com/griddb/c_client to install GridDB C client.
- After installing GridDB C client, create folder <go_client>\libs and store gridstore_c.dll (not use gridstore_c.lib) into it.

Install tdm64-gcc
- Download and install package from http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%20Installer/tdm64-gcc-5.1.0-2.exe/download

### Build and Run in cmd
	
    1. Go to <go_client> folder and run script:

    $ build.bat

### How to run sample

GridDB Server need to be started in advance.

    1. The command to run sample

        $ go run sample/sample1.go <GridDB notification address> <GridDB notification port>
            <GridDB cluster name> <GridDB user> <GridDB password>
          -->[ 'name01', false, 1, <Buffer 41 42 43 44 45 46 47 48 49 4a> ]

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

## Community

  * Issues  
    Use the GitHub issue function if you have any requests, questions, or bug reports. 
  * PullRequest  
    Use the GitHub pull request function if you want to contribute code.
    You'll need to agree GridDB Contributor License Agreement(CLA_rev1.1.pdf).
    By using the GitHub pull request function, you shall be deemed to have agreed to GridDB Contributor License Agreement.

## License
  
  GridDB Go Client source license is Apache License, version 2.0.

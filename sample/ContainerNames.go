package main

import(
    "github.com/griddb/go_client"
    "fmt"
    "os"
    "strconv"
)

func main() {
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)
    // Get GridStore object
        port, err := strconv.Atoi(os.Args[2])
    if (err != nil) {
        fmt.Println("strconv port failed", err)
        os.Exit(2)
    }
    gridstore, err := factory.GetStore(map[string]interface{} {
        "host": os.Args[1],
        "port": port,
        "cluster_name": os.Args[3],
        "username": os.Args[4],
        "password": os.Args[5]})
    fmt.Println("Connect to Cluster")
    if (err != nil) {
        fmt.Println("Get Store failed", err)
        panic("err get store")
    }
    defer griddb_go.DeleteStore(gridstore)

    //Get a list of container names
    //(1)Get partition controller and number of partitions
    pc, err2 := gridstore.PartitionInfo()
    if (err2 != nil) {
        fmt.Println("PartitionInfo failed, err:", err2)
        panic("err PartitionInfo")
    }
    pcCount,err3 := pc.GetPartitionCount()
    if (err3 != nil) {
        fmt.Println("GetPartitionCount failed, err:", err3)
        panic("err GetPartitionCount")
    }

    //(2) Loop by the number of partitions to get a list of container names
    //not use GetContainerNames(partitionIndex int, start int, limit int)
    //use GetContainerNames(partitionIndex int, start int64, limit int64)
    for i := 0; i < pcCount; i++ {
        namelist, err := pc.GetContainerNames(i,int64(0))
        if (err != nil) {
            fmt.Println("GetContainerNames failed, err:", err)
            panic("err GetContainerNames")
        }
        for _ , v := range namelist {
           fmt.Println(v)
        }
    }
}

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
    containerName := "SampleGo_RowExpiration"

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

    //Set row expiration release
    expInfo, err := griddb_go.CreateExpirationInfo(100, griddb_go.TIME_UNIT_DAY, 5)
    if (err != nil) {
        fmt.Println("Create CreateExpirationInfo failed, err:", err)
        panic("err CreateExpirationInfo")
    }

    //Create a time series container
    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": containerName,
        "column_info_list":[][]interface{}{
            {"date", griddb_go.TYPE_TIMESTAMP},
            {"value", griddb_go.TYPE_DOUBLE}},
        "type": griddb_go.CONTAINER_TIME_SERIES})
    if (err != nil) {
        fmt.Println("Create containerInfo failed, err:", err)
        panic("err CreateContainerInfo")
    }
    defer griddb_go.DeleteContainerInfo(conInfo)
    gridstore.DropContainer(containerName)

    //Set Row Expiration
    conInfo.SetExpirationInfo(expInfo)
    col, err := gridstore.PutContainer(conInfo)
    if (err != nil) {
        fmt.Println("put container failed, err:", err)
        panic("err PutContainer")
    }
    defer griddb_go.DeleteContainer(col)
    fmt.Println("Create TimeSeries & Set Row Expiration name=", containerName)
    fmt.Println("success!")
}

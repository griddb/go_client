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
    containerName := "SampleGo_Info"

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
    columnCount := 3
    //Create Collection

    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": containerName,
        "column_info_list":[][]interface{}{
            {"id", griddb_go.TYPE_INTEGER},
            {"productName", griddb_go.TYPE_STRING},
            {"count", griddb_go.TYPE_INTEGER}},
        "type": griddb_go.CONTAINER_COLLECTION,
        "row_key": true})
    if (err != nil) {
        fmt.Println("Create containerInfo failed, err:", err)
        panic("err CreateContainerInfo")
    }
    defer griddb_go.DeleteContainerInfo(conInfo)
    gridstore.DropContainer(containerName)
    col, err := gridstore.PutContainer(conInfo)
    if (err != nil) {
        fmt.Println("put container failed, err:", err)
        panic("err PutContainer")
    }
    defer griddb_go.DeleteContainer(col)
    fmt.Println("Sample data generation: Create Collection name", containerName)

    //get container info
    col1, err2 := gridstore.GetContainer(containerName)
    if (err2 != nil) {
        fmt.Println("GetContainer failed, err:", err2)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col1)
    fmt.Println("Get ContainerInfo: ")
    fmt.Println("name : ", conInfo.GetName())
    if(conInfo.GetType() == 0){
        fmt.Println("type = COLLECTION")
    } else {
        fmt.Println("type = TimeSeries")
    }
    fmt.Println("row_key : ", conInfo.GetRowKeyAssigned())
    columnInfo := conInfo.GetColumnInfoList()
    fmt.Println("columnCount : ", columnCount)
    for i := 0; i < columnCount; i++ {
        fmt.Println("column ", "(", columnInfo[i][0], ",", columnInfo[i][1], ")")
    }
    fmt.Println("success!")
}

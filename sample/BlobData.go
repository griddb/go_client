package main

import(
    "github.com/griddb/go_client"
    "fmt"
    "os"
    "strconv"
    "io/ioutil"
)

func main() {
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)
    containerName := "SampleGo_BlobData"

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

    //Create Collection
    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": containerName,
        "column_info_list":[][]interface{}{
            {"id", griddb_go.TYPE_INTEGER},
                {"blob", griddb_go.TYPE_BLOB}},
        "type": griddb_go.CONTAINER_COLLECTION,
        "row_key": true})
    if (err != nil) {
        fmt.Println("Create containerInfo failed, err:", err)
        panic("err CreateContainerInfo")
    }
    defer griddb_go.DeleteContainerInfo(conInfo)
    fmt.Println("Sample data generation: Create Collection name=", containerName)

    //Put container
    gridstore.DropContainer(containerName)
    col, err := gridstore.PutContainer(conInfo)
    if (err != nil) {
        fmt.Println("put container failed, err:", err)
        panic("err PutContainer")
    }
    defer griddb_go.DeleteContainer(col)

    //Register binary
    //(1)Read text file
    blob, err := ioutil.ReadFile("sample/BlobData.go")
    if (err != nil) {
        fmt.Println("ReadFile failed, err:", err)
        panic("err ReadFile")
    }

    //(2)Register a row
    err = col.Put([]interface{}{0, blob})
    if (err != nil) {
        fmt.Println("Put fail, err:", err)
    }
    fmt.Println("Put Row (Blob)")

    //Get binary
    row, err := col.Get(0)
    if (err != nil) {
        fmt.Println("Get fail, err:", err)
    }
    fmt.Println("Blob row[0]= ", row[0])
    fmt.Println("Get Blob string:\n", string(row[1].([]byte)[:]))
    fmt.Println("success!")
}
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
    nameList := []string{"notebook PC", "desktop PC",
                         "keyboard", "mouse", "printer"}
    numberList  := []int{ 108, 72, 25, 45, 62}
    containerName := "SampleGo_GetRow"
    rowCount := 5

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

    //create collecttion
    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": containerName,
        "column_info_list":[][]interface{}{
            {"id", griddb_go.TYPE_INTEGER},
            {"namelist", griddb_go.TYPE_STRING},
            {"numberList", griddb_go.TYPE_INTEGER}},
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

    //Register multiple rows
    rowList := [][]interface{}{}
        for i := 0; i < rowCount; i++ {
        rowList = append(rowList, []interface{}{i, nameList[i], numberList[i]})
    }
    err1 := col.MultiPut(rowList)
    if err1 != nil {
        fmt.Println("MultiPut err: ", err1)
    }
    fmt.Println("Sample data generation: Put Rows count=",rowCount)

    //Get a row
    //(1)Get the container
    col1, err2 := gridstore.GetContainer(containerName)
    if (err2 != nil) {
        fmt.Println("GetContainer failed, err:", err2)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col1)

    //(2)Get the value from row
    dat, err3 := col1.Get(0)
    if (err3 != nil) {
        fmt.Println("GetCol failed, err:", err3)
        panic("err GetCol")
    }
    fmt.Println("Get Row", "(", "id=", dat[0], ",", "productName=", dat[1], ",", "count=", dat[2], ")")
    fmt.Println("success!")
}
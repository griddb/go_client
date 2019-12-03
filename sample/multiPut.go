package main

import (
    "fmt"
    griddb_go "github.com/griddb/go_client"
    "os"
    "strconv"
)

func main() {
    containerNameList := []string{"SampleC_MultiPut1", "SampleC_MultiPut2"}
    nameList := []string{"notebook PC", "desktop PC", "keyboard", "mouse", "printer"}
    numberList := [][]int{{108, 72, 25, 45, 62}, {50, 11, 208, 23, 153}}
    collectionListRows := make([][][]interface{}, 0)
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)

    // Get GridStore object
    port, err := strconv.Atoi(os.Args[2])
    if err != nil {
        fmt.Println(err)
        os.Exit(2)
    }
    gridstore, err := factory.GetStore(map[string]interface{}{
        "host": os.Args[1], "port": port, "cluster_name": os.Args[3], "username": os.Args[4], "password": os.Args[5]})
    if err != nil {
        fmt.Println("ERROR gsGetGridStore")
    }
    defer griddb_go.DeleteStore(gridstore)
    fmt.Println("Connect to Cluster")
    for i := range containerNameList {
        conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{}{"name": containerNameList[i],
            "column_info_list": [][]interface{}{
                {"id", griddb_go.TYPE_INTEGER},
                {"productName", griddb_go.TYPE_STRING},
                {"count", griddb_go.TYPE_LONG}}, "type": griddb_go.CONTAINER_COLLECTION, "row_key": true})
        if err != nil {
            fmt.Println("ERROR CreateContainerInfo")
        }
        defer griddb_go.DeleteContainerInfo(conInfo)
        gridstore.DropContainer(containerNameList[i])
        col, err := gridstore.PutContainer(conInfo)
        if err != nil {
            fmt.Println("ERROR PutContainer")
        }
        defer griddb_go.DeleteContainer(col)
        fmt.Println("Sample data generation: Create Collection name=",
            containerNameList[i])
    }

    for i := range containerNameList {
        entryList := make([][]interface{}, 0)
        for j := range nameList {
            var row []interface{}
            row = append(row, j)
            row = append(row, nameList[j])
            row = append(row, numberList[i][j])
            entryList = append(entryList, row)
        }
        collectionListRows = append(collectionListRows, entryList)
    }

    inEntryList := map[string][][]interface{}{
        containerNameList[0]: collectionListRows[0], containerNameList[1]: collectionListRows[1]}

    fmt.Println("Multi Put")
    err = gridstore.MultiPut(inEntryList)
    if err != nil {
        fmt.Println("ERROR MultiPut")
    }
    fmt.Println("Success!")
}

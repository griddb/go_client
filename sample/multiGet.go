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
    predEntryList := make(map[string]griddb_go.RowKeyPredicate)
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
        container, err := gridstore.PutContainer(conInfo)
        if err != nil {
            fmt.Println("ERROR PutContainer")
        }
        defer griddb_go.DeleteContainer(container)
        fmt.Println("Sample data generation: Create Collection name=", containerNameList[i])

        entryList := make([][]interface{}, 0)
        for j := range nameList {
            var row []interface{}
            row = append(row, j)
            row = append(row, nameList[j])
            row = append(row, numberList[i][j])
            entryList = append(entryList, row)
        }
        err = container.MultiPut(entryList)
        if err != nil {
            fmt.Println("ERROR MultiPut")
        }

        fmt.Println("Sample data generation: Put Rows count=", len(nameList))
        predicate, err := gridstore.CreateRowKeyPredicate(griddb_go.TYPE_INTEGER)
        if err != nil {
            fmt.Println("ERROR CreateRowKeyPredicate")
        }
        predicate.SetRange(0, 2)
        predEntryList[containerNameList[i]] = predicate
    }

    rowList, err := gridstore.MultiGet(predEntryList)
    if err != nil {
        fmt.Println("MultiGet falied")
    }
    for i := range rowList {
        for j := range rowList[i] {
            message := fmt.Sprintf("MultiGet: container=%s, id=%d, productName=%s, count=%d",
                i, rowList[i][j][0], rowList[i][j][1], rowList[i][j][2])
            fmt.Println(message)
        }

    }
    fmt.Println("success!")
}

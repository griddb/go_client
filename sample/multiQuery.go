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
    tqlList := []string{"select * where count > 60", "select * where count > 100"}
    queryList := []griddb_go.Query{}
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)

    // Get GridStore object
    port, err0 := strconv.Atoi(os.Args[2])
    if err0 != nil {
        fmt.Println(err0)
        os.Exit(2)
    }
    gridstore, err := factory.GetStore(map[string]interface{}{"host": os.Args[1], "port": port, "cluster_name": os.Args[3], "username": os.Args[4], "password": os.Args[5]})
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
        query, err := container.Query(tqlList[i])
        if err != nil {
            fmt.Println("ERROR Query")
        }
        queryList = append(queryList, query)
    }

    gridstore.FetchAll(queryList)
    for i := range queryList {
        rs, err := queryList[i].GetRowSet()
        if err != nil {
            fmt.Println("ERROR Query")
        }
        for rs.HasNext() {
            rrow, err := rs.NextRow()
            if err != nil {
                fmt.Println("ERROR NextRow")
            }

            message := fmt.Sprintf("FetchAll result: container=%s, row=(%d, \"%s\", %d)",
                containerNameList[i], rrow[0], rrow[1], rrow[2])
            fmt.Println(message)
        }
    }
    fmt.Println("Success!")
}

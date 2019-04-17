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

    blob   := []byte{65, 66, 67, 68, 69, 70, 71, 72, 73, 74}
    update := true

    // Get GridStore object
    port, err := strconv.Atoi(os.Args[2])
    if (err != nil) {
        fmt.Println(err)
        os.Exit(2)
    }
    gridstore, err := factory.GetStore(map[string]interface{} {
        "host": os.Args[1],
        "port": port,
        "cluster_name": os.Args[3],
        "username": os.Args[4],
        "password": os.Args[5]})
    if (err != nil) {
        fmt.Println(err)
        panic("err get store")
    }
    defer griddb_go.DeleteStore(gridstore)

    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": "col01",
        "column_info_list":[][]interface{}{
            {"name", griddb_go.TYPE_STRING},
            {"status", griddb_go.TYPE_BOOL},
            {"count", griddb_go.TYPE_LONG},
            {"lob", griddb_go.TYPE_BLOB}},
        "type": griddb_go.CONTAINER_COLLECTION,
        "row_key": true})
    if (err != nil) {
        fmt.Println("Create containerInfo failed, err:", err)
        panic("err CreateContainerInfo")
    }
    defer griddb_go.DeleteContainerInfo(conInfo)

    gridstore.DropContainer("col01")
    col, err := gridstore.PutContainer(conInfo)
    if (err != nil) {
        fmt.Println("put container failed, err:", err)
        panic("err PutContainer")
    }
    defer griddb_go.DeleteContainer(col)

    // Change auto commit mode to false
    col.SetAutoCommit(false)

    // Set an index on the Row-key Column
    col.CreateIndex(map[string]interface{}{"column_name": "name", "index_type": griddb_go.INDEX_FLAG_DEFAULT})
    // Set an index on the Column
    col.CreateIndex(map[string]interface{}{"column_name": "count", "index_type": griddb_go.INDEX_FLAG_DEFAULT})

    //Put row: RowKey is "name01"
    err = col.Put([]interface{}{"name01", false, 1, blob})
    if (err != nil) {
        fmt.Println("put row name01 fail, err:", err)
    }
    // Remove row with RowKey "name01"
    col.Remove("name01")

    //Put row: RowKey is "name02"
    err = col.Put([]interface{}{"name02", false, 1, blob})
    if (err != nil) {
        fmt.Println("put row name02 fail, err:", err)
    }
    col.Commit()

    // Create normal query
    query, err := col.Query("select *")
    if (err != nil) {
        fmt.Println("create query failed, err:", err)
        panic("err create query")
    }
    defer griddb_go.DeleteQuery(query)

    // Execute query
    rs, err := query.Fetch(update)
    if (err != nil) {
        fmt.Println("fetch failed, err:", err)
        panic("err create rowset")
    }
    defer griddb_go.DeleteRowSet(rs)
    for rs.HasNext() {
        rrow, err := rs.NextRow()
        if (err != nil) {
            fmt.Println("NextRow from rs failed, err:", err)
            panic("err NextRow from rowset")
        }

        rrow[2] = rrow[2].(int) + 1
        fmt.Println("Person: name=", rrow[0]," status=", rrow[1]," count=", rrow[2]," lob=", rrow[3])

        // Update row
        err = rs.Update(rrow)
        if (err != nil) {
            fmt.Println("Update row from rs failed, err:", err)
        }
    }
    // End transaction
    col.Commit()
}

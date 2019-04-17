package main

import(
    "github.com/griddb/go_client"
    "fmt"
    "os"
    "time"
    "strconv"
)
func main() {
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)
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
    // Create ContainerInfo
    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": "point01",
        "column_info_list":[][]interface{}{
            {"timestamp", griddb_go.TYPE_TIMESTAMP},
            {"active", griddb_go.TYPE_BOOL},
            {"voltage", griddb_go.TYPE_DOUBLE}},
        "type": griddb_go.CONTAINER_TIME_SERIES,
        "row_key": true})
    if (err != nil) {
        fmt.Println("Create containerInfo failed:", err)
        panic("err CreateContainerInfo")
    }
    defer griddb_go.DeleteContainerInfo(conInfo)

    ts, err := gridstore.PutContainer(conInfo, true)
    if (err != nil) {
        fmt.Println("put container failed:", err)
        panic("err PutContainer")
    }
    defer griddb_go.DeleteContainer(ts)

    now := time.Now().UTC()
    err = ts.Put([]interface{}{now , false, 100})
    if (err != nil) {
        fmt.Println("put row failed:", err)
    }

    // Create normal query for range of timestamp from 6 hours ago to now
    query,err := ts.Query("select * where timestamp > TIMESTAMPADD(HOUR, NOW(), -6)")
    if (err != nil) {
        fmt.Println("create query failed:", err)
        panic("err Query")
    }
    defer griddb_go.DeleteQuery(query)
    rs, err := query.Fetch()
    if (err != nil) {
        fmt.Println("create rs failed:", err)
        panic("err Fetch")
    }
    defer griddb_go.DeleteRowSet(rs)
    for rs.HasNext() {
        rrow, err := rs.NextRow()
        if (err != nil) {
            fmt.Println("NextRow from rs failed:", err)
        }
        fmt.Println("Time=", rrow[0]," Active=", rrow[1]," Voltage=", rrow[2])
    }

}

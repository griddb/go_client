package main

import(
    "github.com/griddb/go_client"
    "fmt"
    "strconv"
    "time"
    "os"
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

    // Get TimeSeries
    // Reuse TimeSeries and data from sample 2
    ts, err := gridstore.GetContainer("point01")
    if (err != nil) {
        fmt.Println("get container failed:", err)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(ts)

    // Create normal query to get all row where active = FAlSE and voltage > 50
    query, err := ts.Query("select * from point01 where not active and voltage > 50")
    if (err != nil) {
        fmt.Println("create query failed:", err)
        panic("err Query")
    }
    defer griddb_go.DeleteQuery(query)
    rs, err := query.Fetch()
    if (err != nil) {
        fmt.Println("fetch failed:", err)
        panic("err Fetch")
    }
    defer griddb_go.DeleteRowSet(rs)

    // Get result
    for rs.HasNext() {
        rrow, err := rs.NextRow()
        if (err != nil) {
            fmt.Println("NextRow from rs failed:", err)
            panic("err NextRow")
        }
        timestamp := griddb_go.GetTimeMillis(rrow[0].(time.Time))

        // Perform aggregation query to get average value
        // during 10 minutes later and 10 minutes earlier from this point
        aggCommand := "select AVG(voltage) from point01 where timestamp > TIMESTAMPADD(MINUTE, TO_TIMESTAMP_MS(" + strconv.Itoa(timestamp) + "), -10) AND timestamp < TIMESTAMPADD(MINUTE, TO_TIMESTAMP_MS(" + strconv.Itoa(timestamp) + "), 10)"
        aggQuery, err := ts.Query(aggCommand)
        if (err != nil) {
            fmt.Println("create aggQuery failed:", err)
            panic("err create aggregation")
        }
        defer griddb_go.DeleteQuery(aggQuery)
        aggRs, err := aggQuery.Fetch()
        if (err != nil) {
            fmt.Println("Fetch from aggQuery failed:", err)
            panic("err Fetch for aggregation")
        }
        defer griddb_go.DeleteRowSet(aggRs)
        for aggRs.HasNext() {
            // Get aggregation result
            aggResult, err := aggRs.NextAggregation()
            if (err != nil) {
                fmt.Println("NextAggregation from aggRs failed:", err)
            }
            defer griddb_go.DeleteAggregationResult(aggResult)
            // Convert result to double and print out
            avr, err  := aggResult.Get(griddb_go.TYPE_DOUBLE)
            if (err == nil) {
                fmt.Println("[Timestamp=", timestamp, "] Average voltage=", avr)
            } else {
                fmt.Println("aggResult.Get err:", err)
            }
        }
    }
}

package main

import(
    "github.com/griddb/go_client"
    "fmt"
    "os"
    "strconv"
    "time"
)

func main() {
    factory := griddb_go.StoreFactoryGetInstance()
    defer griddb_go.DeleteStoreFactory(factory)
    dateList := []string{"2018-12-01T10:00:00.000Z",
                        "2018-12-01T10:10:00.000Z",
                        "2018-12-01T10:20:00.000Z",
                        "2018-12-01T10:40:00.000Z"}
    value1List  := []int{ 1, 3, 2, 4 }
    value2List := []float64{ 10.3, 5.7, 8.2, 4.5 }
    containerName := "SampleGo_TQLTimeseries"
    rowCount := 4

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

    // Create TIME SERIES
    conInfo, err := griddb_go.CreateContainerInfo(map[string]interface{} {
        "name": containerName,
        "column_info_list":[][]interface{}{
            {"date", griddb_go.TYPE_TIMESTAMP},
            {"value1", griddb_go.TYPE_INTEGER},
            {"value2", griddb_go.TYPE_DOUBLE}},
        "type": griddb_go.CONTAINER_TIME_SERIES})
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
    columnInfo := conInfo.GetColumnInfoList()
    fmt.Println("Sample data generation:  column=", "(", columnInfo[0][0], ",", columnInfo[1][0], ", ", columnInfo[2][0], ")")

    //Register multiple rows
    rowList := [][]interface{}{}
    layout := "2006-01-02T15:04:05.000Z"
    for i := 0; i < rowCount; i++ {
        t, err := time.Parse(layout, dateList[i])
        if err != nil {
            fmt.Println("paser timestamp err: ", err)
        }
        rowList = append(rowList, []interface{}{t, value1List[i], value2List[i]})
        fmt.Printf("Sample data generation:  row=(%s%s %d%s %f%s", dateList[i], ",", value1List[i],",", value2List[i], ")\n")
    }
    err1 := col.MultiPut(rowList)
    if err1 != nil {
        fmt.Println("MultiPut err: ", err1)
    }
    fmt.Println("Sample data generation: Put Rows Count=", rowCount)
    //Aggregation operations specific to time series
    //Get the container
    col1, err2 := gridstore.GetContainer(containerName)
    if (err2 != nil) {
        fmt.Println("GetContainer failed, err:", err2)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col1)
    //weighted average TIME_AVG
    //(1)Execute aggregation operation in TQL
    fmt.Println("TQL query : ", "SELECT TIME_AVG(value1)")
    qr, err3 := col1.Query("SELECT TIME_AVG(value1)")
    if err3 != nil {
        fmt.Println("Query err: ", err3)
    }
    rs, err4 := qr.Fetch()
    if err4 != nil {
        fmt.Println("Fetch err: ", err4)
    }
    //(2)Get the result
    for rs.HasNext() {
        agg, err5 := rs.NextAggregation()
        if (err5 != nil) {
            fmt.Println("GetNextAggregation err:", err5)
            panic("err GetNextAggregation")
        }
    //(3)Get the result of the aggregation operation
        value, err6 := agg.Get(griddb_go.TYPE_DOUBLE)
        if (err6 != nil) {
            fmt.Println("Aggregation get err:", err6)
        }
            fmt.Printf("TQL result: %f\n", value)
    }

    //------------------------------------
    // TIME_NEXT
    //------------------------------------
    //Get the container
    col2, err7 := gridstore.GetContainer(containerName)
    if (err7 != nil) {
        fmt.Println("GetContainer failed, err:", err7)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col2)

    //(1) Execute Select with TQL
    fmt.Println("TQL query :", "SELECT TIME_NEXT(*, TIMESTAMP('2018-12-01T10:10:00.000Z'))")
    qr, err8 := col2.Query("SELECT TIME_NEXT(*, TIMESTAMP('2018-12-01T10:10:00.000Z'))")
    if err8 != nil{
        fmt.Println("Query err: ", err8)
    }
    rs, err9 := qr.Fetch()
    if err9 != nil {
        fmt.Println("Fetch err: ", err9)
    }
    //(3) Get results
    for rs.HasNext() {
    //(4) Get row
        nextRow, err10 := rs.NextRow()
        if (err10 != nil) {
            fmt.Println("GetNextRow err:", err10)
            panic("err GetNextRow")
        }
    fmt.Printf("TQL result: row=(%s%s %d%s %f%s", nextRow[0], ",", nextRow[1],",", nextRow[2], ")")
    }

    //------------------------------------
    // TIME_INTERPOLATED
    //------------------------------------
    //Get The Container
    col3, err11 := gridstore.GetContainer(containerName)
    if (err11 != nil) {
        fmt.Println("GetContainer failed, err:", err11)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col3)

    //(1) Execute Select with TQL
    fmt.Println("\nTQL query :", "SELECT TIME_INTERPOLATED(value1, TIMESTAMP('2018-12-01T10:30:00.000Z'))")
    qr, err12 := col3.Query("SELECT TIME_INTERPOLATED(value1, TIMESTAMP('2018-12-01T10:30:00.000Z'))")
    if err12 != nil {
        fmt.Println("Query err: ", err12)
    }
    rs, err13 := qr.Fetch()
    if err13 != nil {
        fmt.Println("Fetch err: ", err13)
    }
    //(2)Get results
    for rs.HasNext() {
    //(3) Get row
        nextrow, err14 := rs.NextRow()
        if (err14 != nil) {
            fmt.Println("GetNextRow err:", err14)
            panic("err GetNextRow")
        }
        fmt.Printf("TQL result: row=(%s%s %d%s %f%s", nextrow[0], ",", nextrow[1],",", nextrow[2], ")\n")
    }
    fmt.Println("success!")
}

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

	// Get GridStore object
	port, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}
	gridstore := factory.GetStore(map[string]interface{} {
												"host"        :os.Args[1],
												"port"        :port,
												"cluster_name":os.Args[3],
												"username"    :os.Args[4],
												"password"    :os.Args[5],
											})

	// Create TimeSeries
	conInfo, err := griddb_go.CreateContainerInfo("point01",
												[][]interface{} {
													{"timestamp", griddb_go.TYPE_TIMESTAMP},
													{"active", griddb_go.TYPE_BOOL},
													{"voltage", griddb_go.TYPE_DOUBLE}},
													griddb_go.CONTAINER_TIME_SERIES,
				 								true)

	if(err != nil) {
		fmt.Println("Create containerInfo failed")
	}
	ts, err := gridstore.PutContainer(conInfo, true)
	if(err != nil) {
		fmt.Println("put container failed")
	}

	// Create and set row data
	now := time.Now().UTC()
	row1 := []interface{}{now , false, 100}
	// Put row to timeseries with current timestamp
	err = ts.Put(row1)
	if(err != nil) {
		fmt.Println("put row failed")
	}

	// Create normal query for range of timestamp from 6 hours ago to now
	query,err := ts.Query("select * where timestamp > TIMESTAMPADD(HOUR, NOW(), -6)")
	if(err != nil) {
		fmt.Println("create query failed")
	}
	rs, err := query.Fetch(false)
	if(err != nil) {
		fmt.Println("create rs failed")
	}

	for rs.HasNext(){
		rrow, err := rs.NextRow()
		if(err != nil) {
			fmt.Println("NextRow from rs failed")
		}
		fmt.Println("Time=", rrow[0]," Active=", rrow[1]," Voltage=", rrow[2])
	}

}

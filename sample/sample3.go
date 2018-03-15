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

	update := false

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

	// Get TimeSeries
	// Reuse TimeSeries and data from sample 2
	ts, err1 := gridstore.GetContainer("point01")
	if(err1 != nil) {
		fmt.Println("get container failed")
	}

	// Create normal query to get all row where active = FAlSE and voltage > 50
	query, err := ts.Query("select * from point01 where not active and voltage > 50")
	if(err != nil) {
		fmt.Println("create query failed")
	}
	rs, err := query.Fetch(update)
	if(err != nil) {
		fmt.Println("fetch failed")
	}

	// Get result
	for rs.HasNext(){
		rrow, err := rs.NextRow()
		if(err != nil) {
			fmt.Println("NextRow from rs failed")
		}
		mTime := rrow[0].(time.Time)
		timestamp := mTime.UnixNano() / 1000000
		// Perform aggregation query to get average value
		// during 10 minutes later and 10 minutes earlier from this point
		aggCommand := "select AVG(voltage) from point01 where timestamp > TIMESTAMPADD(MINUTE, TO_TIMESTAMP_MS(" + strconv.FormatInt(timestamp, 10) + "), -10) AND timestamp < TIMESTAMPADD(MINUTE, TO_TIMESTAMP_MS(" + strconv.FormatInt(timestamp, 10) + "), 10)"
		aggQuery, err := ts.Query(aggCommand)
		if(err != nil) {
			fmt.Println("create aggQuery failed")
		}
		aggRs, err := aggQuery.Fetch(update)
		if(err != nil) {
			fmt.Println("Fetch from aggQuery failed")
		}
		for aggRs.HasNext(){
			// Get aggregation result
			aggResult, err := aggRs.NextAggregation()
			if(err != nil) {
				fmt.Println("NextAggregation from aggRs failed")
			}
			// Convert result to double and print out
			avg, err  := aggResult.Get(griddb_go.TYPE_DOUBLE)
			if(err == nil) {
				fmt.Println("[Timestamp=", timestamp, "] Average voltage=", avg)
			} else {
				fmt.Println("aggResult.Get err = ", err)
			}
		}
	}
}

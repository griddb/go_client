package main

import(
	"github.com/griddb/go_client"
	"fmt"
	"os"
	"strconv"
)

func main() {
	factory := griddb_go.StoreFactoryGetInstance()

	blob := []byte{65, 66, 67, 68, 69, 70, 71, 72, 73, 74}

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

	// Create Collection
	conInfo, err := griddb_go.CreateContainerInfo("col01",
												[][]interface{}{
													{"name", griddb_go.TYPE_STRING},
													{"status" ,griddb_go.TYPE_BOOL},
													{"count", griddb_go.TYPE_LONG},
													{"lob", griddb_go.TYPE_BLOB}},
													griddb_go.CONTAINER_COLLECTION,
				 								true)
	if(err != nil) {
		fmt.Println("Create containerInfo failed")
	}
	col, err := gridstore.PutContainer(conInfo, false)
	if(err != nil) {
		fmt.Println("put container failed")
	}
	
	// Change auto commit mode to false
	col.SetAutoCommit(false)

	// Set an index on the Row-key Column
	col.CreateIndex("name", griddb_go.INDEX_DEFAULT)

	// Set an index on the Column
	col.CreateIndex("count", griddb_go.INDEX_DEFAULT)

	//Put row: RowKey is "name01"
	row1 := []interface{}{"name01", false, 1, blob}
	err = col.Put(row1)
	//Remove row with RowKey "name01"
	col.Remove("name01")

	//Put row: RowKey is "name02"
	row2 := []interface{}{"name02", false, 1, blob}
	err = col.Put(row2)

	col.Commit();

	// Create normal query
	query, err := col.Query("select * where name = 'name02'")
	if(err != nil) {
		fmt.Println("create query failed")
	}
	//Execute query
	rs, err := query.Fetch(true)
	if(err != nil) {
		fmt.Println("create rs from query failed")
	}
	for rs.HasNext(){
		// Update row
		rrow, err := rs.NextRow()
		if(err != nil) {
			fmt.Println("NextRow from rs failed")
		}
		fmt.Println("Person: name=", rrow[0]," status=", rrow[1]," count=", rrow[2]," lob=", rrow[3])
		tmpRow := []interface{}{"name02", false, 2, blob}
		rs.Update(tmpRow)
	}

	// End transaction
	col.Commit()
}

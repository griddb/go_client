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
    containerName := "SampleGo_Connect"

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

    //Fixed list method
    //gridstore, err := factory.GetStore(map[string]interface{} {
    //    "notification_member": os.Args[1],
    //    "cluster_name": os.Args[2],
    //    "username": os.Args[3],
    //    "password": os.Args[4]})

    //Provider method
    //gridstore, err := factory.GetStore(map[string]interface{} {
    //    "notification_provider": os.Args[1],
    //    "cluster_name": os.Args[2],
    //    "username": os.Args[3],
    //    "password": os.Args[4]})

    if (err != nil) {
        fmt.Println("GetStore failed: ", err)
        panic("err GetStore")
    }
    defer griddb_go.DeleteStore(gridstore)

    //Get the container
    col, err := gridstore.GetContainer(containerName)
    if (err != nil) {
        fmt.Println("GetContainer failed, err:", err)
        panic("err GetContainer")
    }
    defer griddb_go.DeleteContainer(col)
    fmt.Println("success!")
}
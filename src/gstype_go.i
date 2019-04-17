/*
   Copyright (c) 2017 TOSHIBA Digital Solutions Corporation.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
%{
#include <limits>
#include "_cgo_export.h"
%}
// rename all method to camel cases
%rename("%(lowercamelcase)s", %$isfunction) "";
%include exception.i
%typemap(throws) griddb::GSException  %{_swig_gopanic($1.what());%}

%typemap(imtype) (griddb::ContainerInfo*) %{SwigcptrWrapped_ContainerInfo%}
namespace griddb {
%rename(Wrapped_ContainerInfo) ContainerInfo;
%rename(Wrapped_set_column_info_list) ContainerInfo::set_column_info_list;
}
%insert(go_wrapper) %{
type ContainerInfo interface {
    Wrapped_ContainerInfo
    SetColumnInfoList(columnInfoList [][]interface{}) (err error)
}
func (e SwigcptrWrapped_ContainerInfo) SetColumnInfoList(columnInfoList [][]interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_set_column_info_list(columnInfoList)
    return
}
func StoreFactoryGetInstance() (factory StoreFactory) {
    factory = Wrapped_StoreFactoryGetInstance()
    return
}
func DeleteStoreFactory(factory StoreFactory) {
    DeleteWrapped_StoreFactory(Wrapped_StoreFactory(factory))
}
func DeleteStore(store Store) {
    DeleteWrapped_Store(Wrapped_Store(store))
}
func DeleteContainer(col Container) {
    DeleteWrapped_Container(Wrapped_Container(col))
}
func DeleteContainerInfo(colInfo ContainerInfo) {
    DeleteWrapped_ContainerInfo(Wrapped_ContainerInfo(colInfo))
}
func DeleteExpirationInfo(expiration ExpirationInfo) {
    DeleteWrapped_ExpirationInfo(Wrapped_ExpirationInfo(expiration))
}
func DeleteAggregationResult(agg AggregationResult) {
    DeleteWrapped_AggregationResult(Wrapped_AggregationResult(agg))
}
func DeleteQueryAnalysisEntry(entry QueryAnalysisEntry) {
    DeleteWrapped_QueryAnalysisEntry(Wrapped_QueryAnalysisEntry(entry))
}
func DeletePartitionController(partition PartitionController) {
    DeleteWrapped_PartitionController(Wrapped_PartitionController(partition))
}
func DeleteQuery(query Query) {
    DeleteWrapped_Query(Wrapped_Query(query))
}
func DeleteRowKeyPredicate(predicate RowKeyPredicate) {
    DeleteWrapped_RowKeyPredicate(Wrapped_RowKeyPredicate(predicate))
}
func DeleteRowSet(rowset RowSet) {
    DeleteWrapped_RowSet(Wrapped_RowSet(rowset))
}

func CreateContainerInfo(a ...interface{}) (result ContainerInfo, err error) {
    defer catch(&err)
    if (len(a) == 1 && reflect.ValueOf(a[0]).Kind() == reflect.Map) {
        tmpMap, ok := (a[0]).(map[string]interface{})
        if (!ok) {
            panic("can not get map for create containerInfo\n")
        }
        name := ""
        var column_info_list [][]interface{}
        container_type := CONTAINER_COLLECTION
        row_key := false
        var expiration ExpirationInfo
        for keywordpara := range tmpMap {
            switch(keywordpara) {
            case "name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for name for create containerInfo\n")
                }
                name = value
            case "column_info_list":
                value, ok := tmpMap[keywordpara].([][]interface{})
                if (!ok) {
                    panic("wrong type for column_info_list for create containerInfo\n")
                }
                column_info_list = value
            case "type":
                value, ok := tmpMap[keywordpara].(int)
                if (!ok) {
                    panic("wrong type for type for create containerInfo\n")
                }
                container_type = value
            case "row_key":
                value, ok := tmpMap[keywordpara].(bool)
                if (!ok) {
                    panic("wrong type for row_key for create containerInfo\n")
                }
                row_key = value
            case "expiration":
                value, ok := tmpMap[keywordpara].(ExpirationInfo)
                if (!ok) {
                    panic("wrong type for expiration for create containerInfo\n")
                }
                expiration = value
            default:
                panic(fmt.Sprintf("wrong name of parameter for create containerInfo: %v\n", keywordpara))
            }
        }
        if (expiration != nil) {
            result = NewWrapped_ContainerInfo(name, column_info_list, container_type, row_key, expiration).(ContainerInfo)
        } else {
            result = NewWrapped_ContainerInfo(name, column_info_list, container_type, row_key).(ContainerInfo)
        }
    } else {
        result = NewWrapped_ContainerInfo(a ...).(ContainerInfo)
    }
    return
}
%}

%typemap(imtype) (griddb::ExpirationInfo*) %{SwigcptrWrapped_ExpirationInfo%}
namespace griddb {
%rename(Wrapped_ExpirationInfo) ExpirationInfo;
%rename(Wrapped_set_time) ExpirationInfo::set_time;
}
%insert(go_wrapper) %{
type ExpirationInfo interface {
    Wrapped_ExpirationInfo
    SetTime(mTime int) (err error)
}
func CreateExpirationInfo(a ...interface{}) (result ExpirationInfo, err error) {
    defer catch(&err)
    for i := 0; i < len(a); i++ {
        if (a[i].(int) < math.MinInt32 || a[i].(int) > math.MaxInt32) {
            panic(fmt.Sprintf("ExpirationInfo paramter out of range"))
        }
    }
    result = NewWrapped_ExpirationInfo(a ...).(ExpirationInfo)
    return
}
func (e SwigcptrWrapped_ExpirationInfo) SetTime(mTime int ) (err error) {
    defer catch(&err)
    if ((math.MinInt32 <= mTime) && (mTime <= math.MaxInt32)) {
        e.Wrapped_set_time(mTime)
    } else {
        panic("overflow value for set time\n")
    }
    return
}
%}
%typemap(gotype) (griddb::Container*) %{Container%}
%typemap(imtype) (griddb::Container*) %{SwigcptrWrapped_Container%}
namespace griddb {
%rename(Wrapped_Container) Container;
%rename(Wrapped_put) Container::put;
%rename(Wrapped_multi_put) Container::multi_put;
%rename(Wrapped_get) Container::get;
%rename(Wrapped_remove) Container::remove;
%rename(Wrapped_query) Container::query;
%rename(Wrapped_create_index) Container::create_index;
%rename(Wrapped_drop_index) Container::drop_index;
}
%insert(go_wrapper) %{
type Container interface {
    Wrapped_Container
    Get(interface{}) (row []interface{} , err error)
    Put(row []interface{}) (err error)
    MultiPut(rowList [][]interface{}) (err error)
    Query(str string) (mQuery Query, err error)
    Remove(key interface{}) (err error)
    CreateIndex(a ...interface{}) (err error)
    DropIndex(a ...interface{}) (err error)
    SetTimestampOutput(isFloat bool)
    GetTimestampOutput() (isFloat bool)
}
func (e SwigcptrWrapped_Container) SetTimestampOutput(isFloat bool) {
    e.SetTimestamp_output_with_float(isFloat)
}
func (e SwigcptrWrapped_Container) GetTimestampOutput() (isFloat bool) {
    isFloat = e.GetTimestamp_output_with_float()
    return isFloat
}
func (e SwigcptrWrapped_Container) Get(key interface{}) (row []interface{}, err error) {
    defer catch(&err)
    e.Wrapped_get(key, &row)
    return
}
func (e SwigcptrWrapped_Container) Remove(key interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_remove(key)
    return
}
func (e SwigcptrWrapped_Container) Put(row []interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_put(row)
    return
}
func (e SwigcptrWrapped_Container) MultiPut(rowList [][]interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_multi_put(rowList)
    return
}
func (e SwigcptrWrapped_Container) Query(str string) (mQuery Query, err error) {
    defer catch(&err)
    mQuery = e.Wrapped_query(str)
    return
}
func (e SwigcptrWrapped_Container) CreateIndex(a ...interface{}) (err error) {
    defer catch(&err)
    if (len(a) == 1 && reflect.ValueOf(a[0]).Kind() == reflect.Map) {
        tmpMap, ok := (a[0]).(map[string]interface{})
        if (!ok) {
            panic("can not get map for create index\n")
        }
        column_name := ""
        index_type := INDEX_FLAG_DEFAULT
        name := ""
        for keywordpara := range tmpMap {
            switch(keywordpara) {
            case "column_name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for column_name for create index\n")
                }
                column_name = value
            case "index_type":
                value, ok := tmpMap[keywordpara].(int)
                if (!ok) {
                    panic("wrong type for index_type for create index\n")
                }
                index_type = value
            case "name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for name for create index\n")
                }
                name = value
            default:
                panic(fmt.Sprintf("wrong name of parameter for create index: %v\n", keywordpara))
            }
        }
        e.Wrapped_create_index(column_name, index_type, name)
    } else {
        e.Wrapped_create_index(a ...)
    }
    return
}
func (e SwigcptrWrapped_Container) DropIndex(a ...interface{}) (err error) {
    defer catch(&err)
    if (len(a) == 1 && reflect.ValueOf(a[0]).Kind() == reflect.Map) {
        tmpMap, ok := (a[0]).(map[string]interface{})
        if (!ok) {
            panic("can not get map for drop index\n")
        }
        column_name := ""
        index_type := INDEX_FLAG_DEFAULT
        name := ""
        for keywordpara := range tmpMap {
            switch(keywordpara) {
            case "column_name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for column_name for drop index\n")
                }
                column_name = value
            case "index_type":
                value, ok := tmpMap[keywordpara].(int)
                if (!ok) {
                    panic("wrong type for index_type for drop index\n")
                }
                index_type = value
            case "name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for name for drop index\n")
                }
                name = value
            default:
                panic(fmt.Sprintf("wrong name of parameter for drop index: %v\n", keywordpara))
            }
        }
        e.Wrapped_drop_index(column_name, index_type, name)
    } else {
        e.Wrapped_drop_index(a ...)
    }
    return
}
%}
%typemap(gotype) (griddb::Query*) %{Query%}
%typemap(imtype) (griddb::Query*) %{SwigcptrWrapped_Query%}
namespace griddb {
%rename(Wrapped_Query) Query;
%rename(Wrapped_fetch) Query::fetch;
%rename(Wrapped_set_fetch_options) Query::set_fetch_options;
}
%insert(go_wrapper) %{
type Query interface {
    Wrapped_Query
    Fetch(a ...interface{}) (mRowSet RowSet, err error)
    SetFetchOptions(a ...interface{}) (err error)
}
func (e SwigcptrWrapped_Query) Fetch(a ...interface{}) (mRowSet RowSet, err error) {
    defer catch(&err)
    mRowSet = e.Wrapped_fetch(a ...)
    return
}
func (e SwigcptrWrapped_Query) SetFetchOptions(a ...interface{}) (err error) {
    defer catch(&err)
    if (len(a) == 1 && reflect.ValueOf(a[0]).Kind() == reflect.Map) {
        tmpMap, ok := (a[0]).(map[string]interface{})
        if (!ok) {
            panic("can not get map for get store\n")
        }
        limit := FETCH_OPTION_LIMIT_MAX
        partial := false
        for keywordpara := range tmpMap {
            switch(keywordpara) {
            case "limit":
            value, ok := tmpMap[keywordpara].(int)
            if (!ok) {
                panic("wrong type for limit for set fetch options\n")
            }
            limit = value
            case "partial":
                value, ok := tmpMap[keywordpara].(bool)
                if (!ok) {
                    panic("wrong type for partial for set fetch options\n")
                }
                partial = value
            default:
                panic(fmt.Sprintf("wrong name of parameter for set fetch options: %v\n", keywordpara))
            }
        }
        e.Wrapped_set_fetch_options(limit, partial)
    } else {
        e.Wrapped_set_fetch_options(a ...)
    }
    return
}
%}
%typemap(gotype) (griddb::AggregationResult*) %{AggregationResult%}
%typemap(imtype) (griddb::AggregationResult*) %{SwigcptrWrapped_AggregationResult%}
namespace griddb {
%rename(Wrapped_AggregationResult) AggregationResult;
%rename(Wrapped_get) AggregationResult::get;
}
%insert(go_wrapper) %{
type AggregationResult interface {
    Wrapped_AggregationResult
    Get(int) (interface{}, error)
    SetTimestampOutput(isFloat bool)
    GetTimestampOutput() (isFloat bool)
}
func (e SwigcptrWrapped_AggregationResult) SetTimestampOutput(isFloat bool) {
    e.SetTimestamp_output_with_float(isFloat)
}
func (e SwigcptrWrapped_AggregationResult) GetTimestampOutput() (isFloat bool) {
    isFloat = e.GetTimestamp_output_with_float()
    return isFloat
}
func (e SwigcptrWrapped_AggregationResult) Get(mType int) (agResult interface{}, err error) {
    var tmp []interface{}
    defer catch(&err)
    e.Wrapped_get(mType, &tmp)
    agResult = tmp[0]
    return
}
%}
%typemap(gotype) (griddb::RowSet*) %{RowSet%}
%typemap(imtype) (griddb::RowSet*) %{SwigcptrWrapped_RowSet%}
namespace griddb {
%rename(Wrapped_RowSet) RowSet;
%rename(Wrapped_next_row) RowSet::next_row;
%rename(Wrapped_update) RowSet::update;
%rename(Wrapped_get_next_query_analysis) RowSet::get_next_query_analysis;
%rename(Wrapped_get_next_aggregation) RowSet::get_next_aggregation;
}
%insert(go_wrapper) %{
type RowSet interface {
    Wrapped_RowSet
    Update(row []interface{}) (err error)
    NextRow() (row []interface{} , err error)
    NextQueryAnalysis() (mQueryAnalysis QueryAnalysisEntry, err error)
    NextAggregation() (mAggregationResult AggregationResult, err error)
    SetTimestampOutput(isFloat bool)
    GetTimestampOutput() (isFloat bool)
}
func (e SwigcptrWrapped_RowSet) SetTimestampOutput(isFloat bool) {
    e.SetTimestamp_output_with_float(isFloat)
}
func (e SwigcptrWrapped_RowSet) GetTimestampOutput() (isFloat bool) {
    isFloat = e.GetTimestamp_output_with_float()
    return isFloat
}
func (e SwigcptrWrapped_RowSet) NextRow() (row []interface{}, err error) {
    defer catch(&err)
    e.Wrapped_next_row(&row)
    return
}
func (e SwigcptrWrapped_RowSet) Update(row []interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_update(row)
    return
}
func (e SwigcptrWrapped_RowSet) NextQueryAnalysis() (mQueryAnalysis QueryAnalysisEntry, err error) {
    defer catch(&err)
    mQueryAnalysis = e.Wrapped_get_next_query_analysis()
    return
}
func (e SwigcptrWrapped_RowSet) NextAggregation() (mAggregationResult AggregationResult, err error) {
    defer catch(&err)
    mAggregationResult = e.Wrapped_get_next_aggregation()
    return
}
%}
%typemap(gotype) (griddb::StoreFactory*) %{StoreFactory%}
%typemap(imtype) (griddb::StoreFactory*) %{SwigcptrWrapped_StoreFactory%}
namespace griddb {
%rename(Wrapped_StoreFactory) StoreFactory;
%rename(Wrapped_get_store) StoreFactory::get_store;
}
%insert(go_wrapper) %{
type StoreFactory interface {
    Wrapped_StoreFactory
    GetStore(a ...interface{}) (ret Store, err error)
}
func (e SwigcptrWrapped_StoreFactory) GetStore(a ...interface{}) (ret Store, err error) {
    defer catch(&err)
    if (len(a) == 1 && reflect.ValueOf(a[0]).Kind() == reflect.Map) {
        tmpMap, ok := (a[0]).(map[string]interface{})
        if (!ok) {
            panic("can not get map for get store\n")
        }
        host := ""
        port := 0
        cluster_name := ""
        database := ""
        username := ""
        password := ""
        notification_member := ""
        notification_provider := ""
        for keywordpara := range tmpMap {
            switch(keywordpara) {
            case "host":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for host for get store\n")
                }
                host = value
            case "port":
                value, ok := tmpMap[keywordpara].(int)
                if (!ok) {
                    panic("wrong type for port for get store\n")
                }
                port = value
            case "cluster_name":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for cluster_name for get store\n")
                }
                cluster_name = value
            case "database":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for database for get store\n")
                }
                database = value
            case "username":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for username for get store\n")
                }
                username = value
            case "password":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for password for get store\n")
                }
                password = value
            case "notification_member":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for notification_member for get store\n")
                }
                notification_member = value
            case "notification_provider":
                value, ok := tmpMap[keywordpara].(string)
                if (!ok) {
                    panic("wrong type for notification_provider for get store\n")
                }
                notification_provider = value
            default:
                panic(fmt.Sprintf("wrong name of parameter for get store: %v\n", keywordpara))
            }
        }
        ret = e.Wrapped_get_store(host, port, cluster_name, database, username, password, notification_member, notification_provider)
    } else {
        ret = e.Wrapped_get_store(a ...)
    }
    return
}
%}
%typemap(gotype) (griddb::Store*) %{Store%}
%typemap(imtype) (griddb::Store*) %{SwigcptrWrapped_Store%}
namespace griddb {
%rename(Wrapped_Store) Store;
%rename(Wrapped_multi_put) Store::multi_put;
%rename(Wrapped_multi_get) Store::multi_get;
%rename(Wrapped_put_container) Store::put_container;
%rename(Wrapped_get_container) Store::get_container;
%rename(Wrapped_drop_container) Store::drop_container;
%rename(Wrapped_fetch_all) Store::fetch_all;
%rename(Wrapped_create_row_key_predicate) Store::create_row_key_predicate;
%rename(Wrapped_get_container_info) Store::get_container_info;
%rename(Wrapped_partition_info) Store::partition_info;
}
%insert(go_wrapper) %{
type Store interface {
    Wrapped_Store
    MultiPut(map[string][][]interface{}) (err error)
    MultiGet(map[string]RowKeyPredicate) (mapRowList map[string][][]interface{}, err error)
    PutContainer(a ...interface{}) (container Container, err error)
    GetContainer(containerName string) (container Container, err error)
    DropContainer(containerName interface{}) (err error)
    FetchAll(listQuery []Query) (err error)
    SetTimestampOutput(isFloat bool)
    GetTimestampOutput() (isFloat bool)
    CreateRowKeyPredicate(mType int) (predicate RowKeyPredicate, err error)
    GetContainerInfo(conName string) (containerInfo ContainerInfo, err error)
    PartitionInfo() (partitionController PartitionController, err error)
}
func (e SwigcptrWrapped_Store) PartitionInfo() (partitionController PartitionController, err error) {
    defer catch(&err)
    partitionController = e.Wrapped_partition_info().(PartitionController)
    return
}
func (e SwigcptrWrapped_Store) GetContainerInfo(conName string) (containerInfo ContainerInfo, err error) {
    defer catch(&err)
    containerInfo = e.Wrapped_get_container_info(conName).(ContainerInfo)
    return
}
func (e SwigcptrWrapped_Store) CreateRowKeyPredicate(mType int) (predicate RowKeyPredicate, err error) {
    defer catch(&err)
    predicate = e.Wrapped_create_row_key_predicate(mType).(RowKeyPredicate)
    return
}
func (e SwigcptrWrapped_Store) SetTimestampOutput(isFloat bool) {
    e.SetTimestamp_output_with_float(isFloat)
}
func (e SwigcptrWrapped_Store) GetTimestampOutput() (isFloat bool) {
    isFloat = e.GetTimestamp_output_with_float()
    return isFloat
}
// inside the go_wrapper...
func catch(err *error) {
    if r := recover(); r != nil {
        *err = fmt.Errorf("%v", r)
    }
}
func (e SwigcptrWrapped_Store) FetchAll(listQuery []Query) (err error) {
    defer catch(&err)
    e.Wrapped_fetch_all(listQuery)
    return
}
func (e SwigcptrWrapped_Store) MultiPut(rowContainerList map[string][][]interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_multi_put(rowContainerList)
    return
}
func (e SwigcptrWrapped_Store) MultiGet(predicate map[string]RowKeyPredicate) (mapRowList map[string][][]interface{}, err error) {
    defer catch(&err)
    var tmp interface{}
    e.Wrapped_multi_get(predicate, &tmp)
    mapRowList = tmp.(map[string][][]interface{})
    return
}
func (e SwigcptrWrapped_Store) PutContainer(a ...interface{}) (container Container, err error) {
    defer catch(&err)
    container = e.Wrapped_put_container(a ...)
    return
}
func (e SwigcptrWrapped_Store) GetContainer(containerName string) (container Container, err error) {
    defer catch(&err)
    container = e.Wrapped_get_container(containerName)
    return
}
func (e SwigcptrWrapped_Store) DropContainer(containerName interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_drop_container(containerName.(string))
    return
}
%}
%typemap(gotype) (griddb::QueryAnalysisEntry*) %{QueryAnalysisEntry%}
%typemap(imtype) (griddb::QueryAnalysisEntry*) %{SwigcptrWrapped_QueryAnalysisEntry%}
namespace griddb {
%rename(Wrapped_QueryAnalysisEntry) QueryAnalysisEntry;
%rename(Wrapped_get) QueryAnalysisEntry::get;
}
%insert(go_wrapper) %{
type QueryAnalysisEntry interface {
    Wrapped_QueryAnalysisEntry
    Get() (info []interface{}, err error)
}

func (e SwigcptrWrapped_QueryAnalysisEntry) Get() (info []interface{}, err error) {
    defer catch(&err)
    e.Wrapped_get(&info)
    return
}
%}
%typemap(gotype) (griddb::PartitionController*) %{PartitionController%}
%typemap(imtype) (griddb::PartitionController*) %{SwigcptrWrapped_PartitionController%}
namespace griddb {
%rename(Wrapped_PartitionController) PartitionController;
%rename(Wrapped_get_container_names) PartitionController::get_container_names;
%rename(Wrapped_get_container_count) PartitionController::get_container_count;
%rename(Wrapped_get_partition_index_of_container) PartitionController::get_partition_index_of_container;
}
%insert(go_wrapper) %{
type PartitionController interface {
    Wrapped_PartitionController
    GetContainerNames(a ...interface{}) (stringList []string, err error)
    GetContainerCount(partition_index int) (count int64, err error)
    GetPartitionIndexOfContainer(container_name string) (ret int, err error)
}
func (e SwigcptrWrapped_PartitionController) GetPartitionIndexOfContainer(container_name string) (ret int, err error) {
    defer catch(&err)
    ret = e.Wrapped_get_partition_index_of_container(container_name)
    return
}
func (e SwigcptrWrapped_PartitionController) GetContainerNames(a ...interface{}) (stringList []string, err error) {
    defer catch(&err)
    argc := len(a)
    if argc == 2 {
        e.Wrapped_get_container_names__SWIG_1(a[0].(int), a[1].(int64), &stringList)
        return
    }
    if argc == 3 {
        e.Wrapped_get_container_names__SWIG_0(a[0].(int), a[1].(int64), &stringList, a[2].(int64))
        return
    }
    panic("No match for overloaded function call")
}
func (e SwigcptrWrapped_PartitionController) GetContainerCount(partition_index int) (count int64, err error) {
    defer catch(&err)
    count = e.Wrapped_get_container_count(partition_index)
    return
}
%}
%typemap(gotype) (griddb::RowKeyPredicate*) %{RowKeyPredicate%}
%typemap(imtype) (griddb::RowKeyPredicate*) %{SwigcptrWrapped_RowKeyPredicate%}
namespace griddb {
%rename(Wrapped_RowKeyPredicate) RowKeyPredicate;
%rename(Wrapped_get_range) RowKeyPredicate::get_range;
%rename(Wrapped_get_distinct_keys) RowKeyPredicate::get_distinct_keys;
%rename(Wrapped_set_range) RowKeyPredicate::set_range;
%rename(Wrapped_set_distinct_keys) RowKeyPredicate::set_distinct_keys;
}
%insert(go_wrapper) %{
type RowKeyPredicate interface {
    Wrapped_RowKeyPredicate
    SetRange(startKey interface{}, finishKey interface{}) (err error)
    GetRange() (rangeResult []interface{}, err error)
    GetDistinctKeys() (keys []interface{}, err error)
    SetDistinctKeys(keys []interface{}) (err error)
    SetTimestampOutput(isFloat bool)
    GetTimestampOutput() (isFloat bool)
}
func (e SwigcptrWrapped_RowKeyPredicate) SetTimestampOutput(isFloat bool) {
    e.SetTimestamp_output_with_float(isFloat)
}
func (e SwigcptrWrapped_RowKeyPredicate) GetTimestampOutput() (isFloat bool) {
    isFloat = e.GetTimestamp_output_with_float()
    return isFloat
}
func (e SwigcptrWrapped_RowKeyPredicate) GetRange() (rangeResult []interface{}, err error) {
    defer catch(&err)
    e.Wrapped_get_range(&rangeResult)
    return
}
func (e SwigcptrWrapped_RowKeyPredicate) SetRange(startKey interface{}, finishKey interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_set_range(startKey, finishKey)
    return
}
func (e SwigcptrWrapped_RowKeyPredicate) GetDistinctKeys() (keys []interface{}, err error) {
    defer catch(&err)
    e.Wrapped_get_distinct_keys(&keys)
    return
}
func (e SwigcptrWrapped_RowKeyPredicate) SetDistinctKeys(keys []interface{}) (err error) {
    defer catch(&err)
    e.Wrapped_set_distinct_keys(keys)
    return
}
%}
%typemap(gotype) (griddb::TimestampUtils*) %{TimestampUtils%}
%typemap(imtype) (griddb::TimestampUtils*) %{SwigcptrWrapped_TimestampUtils%}
namespace griddb {
%rename(Wrapped_TimestampUtils) TimestampUtils;
}
%insert(go_wrapper) %{
type TimestampUtils interface {
    Wrapped_TimestampUtils
}
func GetTimeMillis(mTime time.Time) (mResult int) {
    second     := mTime.Unix()
    miliSecond := mTime.Nanosecond() / 1000000
    mResult     = int(second * 1000) + miliSecond
    return
}
%}

%fragment("goStructs", "go_runtime") %{
// represent for map[string]string
type swig_mapstringstring struct {
    key string;
    value string;
}
// represent for map[string][][]interface{}
type swig_ContainerListRow struct {
    containerName string;
    listRow uintptr;
    listSize int32;
}
// represent for map[string]RowKeyPredicate
type swig_mapstringrowkeypredicate struct {
    containerName string;
    rowKeyPredicate uintptr;
}
// represent for data sent to Go client
type swig_uintptr struct {
    mtype int32
    data uintptr
    isFloat bool
}
// represent for data columnInfo sent to Go client
type swig_columnInfo struct {
    columnName string;
    mType int64;
    options int64;
}
%}
%fragment("cStructs", "header") %{
// represent for map[string]string
struct swig_mapstringstring {
    GoString key;
    GoString value;
};
// represent for map[string][][]interface{}
struct swig_ContainerListRow {
    GoString containerName;
    uintptr_t listRow;
    int32_t listSize;
};
// represent for map[string]RowKeyPredicate
struct swig_mapstringrowkeypredicate {
    GoString containerName;
    griddb::RowKeyPredicate* rowKeyPredicate;
};
// represent for data sent to Go client
struct swig_uintptr {
    int32_t type;
    uintptr_t data;
    bool isFloat;
};
// represent for data columnInfo sent to Go client
struct swig_columnInfo {
    GoString columnName;
    int64_t mType;
    int64_t options;
};
%}

%go_import("fmt")
%go_import("math")
%go_import("reflect")
%go_import("time")
%go_import("bytes")

%fragment("gointerface", "go_runtime") %{
func GoDataTOInterfaceUintptr(mInput swig_uintptr, mResult *interface{}) {
    switch (mInput.mtype) {
        case TYPE_STRING, TYPE_GEOMETRY: {
            var buffer bytes.Buffer
            buffer.WriteString(*(*string)(unsafe.Pointer(mInput.data)))
            *mResult = buffer.String()
        }
        case TYPE_BOOL:
            *mResult = *(*bool)(unsafe.Pointer(mInput.data))
        case TYPE_BYTE:
            *mResult = int(*(*int8)(unsafe.Pointer(mInput.data)))
        case TYPE_SHORT:
            *mResult = int(*(*int16)(unsafe.Pointer(mInput.data)))
        case TYPE_INTEGER:
            *mResult = int(*(*int32)(unsafe.Pointer(mInput.data)))
        case TYPE_LONG:
            *mResult = int(*(*int64)(unsafe.Pointer(mInput.data)))
        case TYPE_FLOAT:
            *mResult = float64(*(*float32)(unsafe.Pointer(mInput.data)))
        case TYPE_DOUBLE:
            *mResult = float64(*(*float64)(unsafe.Pointer(mInput.data)))
        case TYPE_TIMESTAMP: {
            tmp := *(*int64)(unsafe.Pointer(mInput.data))
            *mResult = time.Unix(tmp / 1000, (tmp % 1000)*1000000).UTC()
        }
        case TYPE_BLOB: {
            tmp := *(*[]byte)(unsafe.Pointer(mInput.data))
            blob := make ([]byte, len(tmp))
            copy(blob, tmp)
            *mResult = blob
        }
        case TYPE_NULL:
            *mResult = nil
        default:
            panic("no type found for row to convert to interface\n")
    }
}
%}
/*
* fragment to support converting data for griddb::Field
*/
%fragment("convertFieldToObject", "header", fragment = "cStructs") {
#ifdef __cplusplus
extern "C" {
#endif
void freeFieldDataForRow(uintptr_t data) {
    _goslice_ *slice = (_goslice_ *)(data);
    swig_uintptr *tmpData = (swig_uintptr *) (slice->array);
    for (int i = 0; i < slice->len; i++) {
        switch (tmpData[i].type) {
        case GS_TYPE_STRING: {
            GoString *tmpGo = (GoString *) (tmpData[i].data);
            delete [] tmpGo->p;
            delete tmpGo;
            break;
        }
        case GS_TYPE_BOOL: {
            bool *tmpGo = (bool *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_BYTE: {
            int8_t *tmpGo = (int8_t *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_SHORT: {
            int16_t *tmpGo = (int16_t *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_INTEGER: {
            int32_t *tmpGo = (int32_t *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_LONG: {
            int64_t *tmpGo = (int64_t *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_FLOAT: {
            float *tmpGo = (float *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_DOUBLE: {
            double *tmpGo = (double *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_TIMESTAMP: {
            int64_t *tmpGo = (int64_t *) (tmpData[i].data);
            delete tmpGo;
            break;
        }
        case GS_TYPE_GEOMETRY: {
            GoString *tmpGo = (GoString *) (tmpData[i].data);
            delete [] tmpGo->p;
            delete tmpGo;
            break;
        }
        case GS_TYPE_BLOB: {
            GoSlice *tmpGo = (GoSlice *) (tmpData[i].data);
            delete  [] ((char*)tmpGo->data);
            delete tmpGo;
            break;
        }
        default:
            break;
        }
    }
    delete  [] tmpData;
}
void freeColumnInfo(uintptr_t data) {
    _goslice_ *slice = (_goslice_ *)(data);
    swig_columnInfo * tmpData = (swig_columnInfo *) (slice->array);
    for (int i = 0; i < slice->len; i++) {
        delete [] tmpData[i].columnName.p;
    }
    delete [] tmpData;
}
void freeStoreMultiGet(uintptr_t data) {
    _goslice_ *slice = (_goslice_ *)(data);
    swig_ContainerListRow *tmpDataCon = (swig_ContainerListRow *) (slice->array);
    for (int i = 0; i < slice->len; i++) {
        delete [] tmpDataCon[i].containerName.p;
        _goslice_ *tmpSliceRow    = (_goslice_ *)tmpDataCon[i].listRow;
        _goslice_ *tmpDataListRow = (_goslice_ *)tmpSliceRow->array;
        for (int j = 0; j < tmpSliceRow->len; j++) {
            freeFieldDataForRow(reinterpret_cast<std::uintptr_t>(&tmpDataListRow[j]));
        }
        delete [] tmpDataListRow;
        delete [] tmpSliceRow;
    }
    delete [] tmpDataCon;
}
void freeQueryEntryGet(uintptr_t data) {
    _goslice_ *slice = (_goslice_ *)(data);
    uintptr_t * tmpData = (uintptr_t *) (slice->array);
    delete ((long *)tmpData[0]);
    delete ((long *)tmpData[1]);
    GoString *type = (GoString *)tmpData[2];
    GoString *valueType = (GoString *)tmpData[3];
    GoString *value = (GoString *)tmpData[4];
    GoString *statement = (GoString *)tmpData[5];
    delete [] type->p;
    delete [] valueType->p;
    delete [] value->p;
    delete [] statement->p;
    delete type;
    delete valueType;
    delete value;
    delete statement;
    delete tmpData;
}
void freePartitionConName(uintptr_t data) {
    _goslice_ *slice = (_goslice_ *)(data);
    _gostring_ * tmpData = (_gostring_ *) (slice->array);
    for (int i = 0; i < slice->len; i++) {
        delete [] tmpData[i].p;
    }
    delete [] tmpData;
}
#ifdef __cplusplus
}
#endif
}
/*
* fragment to support converting data for GSRow
*/
%fragment("convertGSRowToObject", "header", fragment="cStructs") {
static bool convertFieldKeyToObjectUintptr(swig_uintptr *map, GSType type, griddb::Field *field, bool timestamp_output_with_float = false) {
    switch(type) {
    case GS_TYPE_STRING: {
        GoString *tmpGo = new GoString();
        char *tmpStr = new char[strlen(field->value.asString)]();
        memcpy(tmpStr, field->value.asString, strlen(field->value.asString));
        tmpGo->p  = tmpStr;
        tmpGo->n  = strlen(field->value.asString);
        map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    case GS_TYPE_INTEGER: {
        int32_t *tmpGo = new int32_t();
        *tmpGo = field->value.asInteger;
        map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    case GS_TYPE_LONG: {
        int64_t *tmpGo = new int64_t();
        *tmpGo = field->value.asLong;
        map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    case GS_TYPE_TIMESTAMP: {
        int64_t *tmpGo = new int64_t();
        *tmpGo = field->value.asTimestamp;
        map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    default:
        return false;
    }
    map->isFloat = timestamp_output_with_float;
    map->type    = type;
    return true;
}

static void convertGSRowToObjectUintptr(swig_uintptr *map, GSRow *row, GSType type, int no, bool timestamp_output_with_float = false) {

    GSResult ret;

%#if GS_COMPATIBILITY_SUPPORT_3_5
    GSBool nullValue;
    ret = gsGetRowFieldNull(row, no, &nullValue);
    if (ret != GS_RESULT_OK) {
        SWIG_exception(SWIG_ValueError, "check get field null failed");
    }
    if (nullValue) {
        map->type = GS_TYPE_NULL;
        return;
    }
%#endif
    map->type = type;
    map->isFloat = timestamp_output_with_float;

    switch (type) {
        case GS_TYPE_STRING: {
            GSChar* stringValue;
            ret = gsGetRowFieldAsString(row, no, (const GSChar **)&stringValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field string failed");
            }
            GoString *tmpGo = new GoString();
            tmpGo->n = strlen(stringValue);
            GSChar *tmp = new GSChar[strlen(stringValue)]();
            memcpy(tmp, stringValue, strlen(stringValue));
            tmpGo->p = tmp;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_BOOL: {
            GSBool boolValue;
            ret = gsGetRowFieldAsBool(row, no, &boolValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field bool failed");
            }
            bool *tmpGo = new bool();
            *tmpGo = boolValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_BYTE: {
            int8_t byteValue;
            ret = gsGetRowFieldAsByte(row, no, &byteValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field byte failed");
            }
            int8_t *tmpGo = new int8_t();
            *tmpGo = byteValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_SHORT: {
            int16_t shortValue;
            ret = gsGetRowFieldAsShort(row, no, &shortValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field short failed");
            }
            int16_t *tmpGo = new int16_t();
            *tmpGo = shortValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_INTEGER: {
            int32_t intValue;
            ret = gsGetRowFieldAsInteger(row, no, &intValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field integer failed");
            }
            int32_t *tmpGo = new int32_t();
            *tmpGo = intValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_LONG: {
            int64_t longValue;
            ret = gsGetRowFieldAsLong(row, no, &longValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field long failed");
            }
            int64_t *tmpGo = new int64_t();
            *tmpGo = longValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_FLOAT: {
            float floatValue;
            ret = gsGetRowFieldAsFloat(row, no, &floatValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field float failed");
            }
            float *tmpGo = new float();
            *tmpGo = floatValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_DOUBLE: {
            double doubleValue;
            ret = gsGetRowFieldAsDouble(row, no, &doubleValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field double failed");
            }
            double *tmpGo = new double();
            *tmpGo = doubleValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_TIMESTAMP: {
            GSTimestamp timestampValue;
            ret = gsGetRowFieldAsTimestamp(row, no, &timestampValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field timestamp failed");
            }
            int64_t *tmpGo = new int64_t();
            *tmpGo = timestampValue;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_GEOMETRY: {
            GSChar* geometryValue;
            ret = gsGetRowFieldAsGeometry(row, no, (const GSChar **)&geometryValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field geometry failed");
            }
            GoString *tmpGo = new GoString();
            tmpGo->n = strlen(geometryValue);
            GSChar *tmp = new GSChar[strlen(geometryValue)]();
            memcpy(tmp, geometryValue, strlen(geometryValue));
            tmpGo->p = tmp;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        case GS_TYPE_BLOB: {
            GSBlob blobValue;
            ret = gsGetRowFieldAsBlob(row, no, &blobValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field string failed");
            }
            GSChar *tmp = new GSChar[blobValue.size]();
            memcpy(tmp, blobValue.data, blobValue.size);
            GoSlice *tmpGo = new GoSlice();
            tmpGo->len = blobValue.size;
            tmpGo->cap = blobValue.size;
            tmpGo->data = tmp;
            map->data = reinterpret_cast<std::uintptr_t>(tmpGo);
            break;
        }
        default:
            SWIG_exception(SWIG_ValueError, "GSType for convert row to object is not correct");
    }
}
}
%fragment("convertObjectToFieldKey", "header") {
    static bool convertObjectToFieldKey(griddb::Field &field, uintptr_t inputData, GSType type) {
        switch (type) {
        case GS_TYPE_STRING: {
            GetInterfaceArrayLength_return array_length = {0};
            array_length = GetInterfaceArrayLength(inputData, GS_TYPE_STRING);
            if (array_length.r1 == -1) {
                SWIG_exception(SWIG_ValueError, "Get string size from Go code is failed");
            }
            GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
            GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
            int result = SetForBlobString(inputData, tmpSlice);
            if (result == -1) {
                delete [] tmp;
                SWIG_exception(SWIG_ValueError, "Get string from Go code is failed");
            }
            field.value.asString = (GSChar*)tmp;
            field.type = GS_TYPE_STRING;
            return true;
        }
        case GS_TYPE_INTEGER: {
            GetNumericInterface_return return_result = {0};
            return_result = GetNumericInterface(inputData, GS_TYPE_INTEGER);
            if (return_result.r3 == -1) {
                SWIG_exception(SWIG_ValueError, "Get integer from Go code is failed");
            }
            if (return_result.r1 < std::numeric_limits<int32_t>::min() ||
                    return_result.r1 > std::numeric_limits<int32_t>::max()) {
                SWIG_exception(SWIG_ValueError, "integer is out of range");
            }
            field.type = GS_TYPE_INTEGER;
            field.value.asInteger = int32_t(return_result.r1);
            return true;
        }
        case GS_TYPE_LONG: {
            GetNumericInterface_return return_result = {0};
            return_result = GetNumericInterface(inputData, GS_TYPE_INTEGER);
            if (return_result.r3 == -1) {
                SWIG_exception(SWIG_ValueError, "Get integer from Go code is failed");
            }
            field.value.asLong = return_result.r1;
            field.type = GS_TYPE_LONG;
            return true;
        }
        case GS_TYPE_TIMESTAMP: {
            GetNumericInterface_return return_result = {0};
            return_result = GetNumericInterface(inputData, GS_TYPE_TIMESTAMP);
            if (return_result.r3 == -1) {
                SWIG_exception(SWIG_ValueError, "Get timestamp from Go code is failed");
            }
            if (return_result.r0 != GS_TYPE_STRING) {
                field.value.asTimestamp = return_result.r1;
            } else {
                GSTimestamp timestampVal;
                GetInterfaceArrayLength_return array_length = {0};
                array_length = GetInterfaceArrayLength(inputData, GS_TYPE_STRING);
                if (array_length.r1 == -1) {
                    SWIG_exception(SWIG_ValueError, "Get timestamp string size from Go code is failed");
                }
                GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
                GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
                int result = SetForBlobString(inputData, tmpSlice);
                if (result == -1) {
                    delete [] tmp;
                    SWIG_exception(SWIG_ValueError, "Get timestamp string from Go code is failed");
                }
                if (gsParseTime((GSChar*)tmp, &timestampVal) == GS_FALSE) {
                    delete [] tmp;
                    SWIG_exception(SWIG_ValueError, "gsParseTime for row failed!");
                }
                field.value.asTimestamp = timestampVal;
                delete [] tmp;
            }
            field.type = GS_TYPE_TIMESTAMP;
            return true;
        }
        default:
            return false;
        }
        return true;
    }
}

//fragment to set data for fields in row
%fragment("setRowFromObject", "header") {
    static bool setRowFromObjectWithString(GSRow *row, int no, uintptr_t inputData) {
        GetInterfaceArrayLength_return array_length = {0};
        array_length = GetInterfaceArrayLength(inputData, GS_TYPE_STRING);
        if (array_length.r1 == -1) {
            SWIG_exception(SWIG_ValueError, "Get string size from Go code is failed");
        }
        GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
        GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
        int result = SetForBlobString(inputData, tmpSlice);
        if (result == -1) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "Get string from Go code is failed");
        }
        GSResult ret = gsSetRowFieldByString(row, no, (const GSChar *)tmp);
        if (ret != GS_RESULT_OK) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "Can not set string value for row");
        }
        delete [] tmp;
        return true;
    }
    static bool setRowFromObjectWithBool(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_BOOL);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get bool from Go code is failed");
        }
        GSResult ret = gsSetRowFieldByBool(row, no, (return_result.r1) ? true:false);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set bool value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithByte(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_BYTE);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get byte from Go code is failed");
        }
        if (return_result.r1 < std::numeric_limits<int8_t>::min() ||
            return_result.r1 > std::numeric_limits<int8_t>::max()) {
            SWIG_exception(SWIG_ValueError, "byte is out of range");
        }
        GSResult ret = gsSetRowFieldByByte(row, no, int8_t(return_result.r1));
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set byte value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithShort(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_SHORT);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get short from Go code is failed");
        }
        if (return_result.r1 < std::numeric_limits<int16_t>::min() ||
            return_result.r1 > std::numeric_limits<int16_t>::max()) {
            SWIG_exception(SWIG_ValueError, "short is out of range");
        }
        GSResult ret = gsSetRowFieldByShort(row, no, int16_t(return_result.r1));
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set short value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithInteger(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_INTEGER);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get integer from Go code is failed");
        }
        if (return_result.r1 < std::numeric_limits<int32_t>::min() ||
            return_result.r1 > std::numeric_limits<int32_t>::max()) {
            SWIG_exception(SWIG_ValueError, "integer is out of range");
        }
        GSResult ret = gsSetRowFieldByInteger(row, no, int32_t(return_result.r1));
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set integer value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithLong(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_LONG);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get long from Go code is failed");
        }
         GSResult ret = gsSetRowFieldByLong(row, no, return_result.r1);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set long value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithFloat(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_FLOAT);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get integer from Go code is failed");
        }
        if (return_result.r2 < - std::numeric_limits<float>::max() ||
            return_result.r2 > std::numeric_limits<float>::max()) {
            SWIG_exception(SWIG_ValueError, "float is out of range");
        }
        GSResult ret = gsSetRowFieldByFloat(row, no, float(return_result.r2));
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set float value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithDouble(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_DOUBLE);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get double from Go code is failed");
        }
        GSResult ret = gsSetRowFieldByDouble(row, no, return_result.r2);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set float value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithTimestamp(GSRow *row, int no, uintptr_t inputData) {
        GetNumericInterface_return return_result = {0};
        return_result = GetNumericInterface(inputData, GS_TYPE_TIMESTAMP);
        if (return_result.r3 == -1) {
            SWIG_exception(SWIG_ValueError, "Get timestamp from Go code is failed");
        }
        GSResult ret;
        if (return_result.r0 != GS_TYPE_STRING) {
            ret = gsSetRowFieldByTimestamp(row, no, return_result.r1);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "Can not set timestamp value for row");
            }
        } else {
            GSTimestamp timestampVal;
            GetInterfaceArrayLength_return array_length = {0};
            array_length = GetInterfaceArrayLength(inputData, GS_TYPE_STRING);
            if (array_length.r1 == -1) {
                SWIG_exception(SWIG_ValueError, "Get timestamp string size from Go code is failed");
            }
            GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
            GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
            int result = SetForBlobString(inputData, tmpSlice);
            if (result == -1) {
                delete [] tmp;
                SWIG_exception(SWIG_ValueError, "Get timestamp string from Go code is failed");
            }
            if (gsParseTime((GSChar*)tmp, &timestampVal) == GS_FALSE) {
                delete [] tmp;
                SWIG_exception(SWIG_ValueError, "gsParseTime for row failed!");
            }
            ret = gsSetRowFieldByTimestamp(row, no, timestampVal);
            if (ret != GS_RESULT_OK) {
                delete [] tmp;
                SWIG_exception(SWIG_ValueError, "Can not set timestamp value for row");
            }
            delete [] tmp;
        }
        return true;
    }
    static bool setRowFromObjectWithGeometry(GSRow *row, int no, uintptr_t inputData) {
        GetInterfaceArrayLength_return array_length = {0};
        array_length = GetInterfaceArrayLength(inputData, GS_TYPE_GEOMETRY);
        if (array_length.r1 == -1) {
            SWIG_exception(SWIG_ValueError, "Get geometry size from Go code is failed");
        }
        GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
        GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
        int result = SetForBlobString(inputData, tmpSlice);
        if (result == -1) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "Get geometry from Go code is failed");
        }
        GSResult ret = gsSetRowFieldByGeometry(row, no, (GSChar*)tmp);
        if (ret != GS_RESULT_OK) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "Can not set geometry value for row");
        }
        delete [] tmp;
        return true;
    }
    static bool setRowFromObjectWithBlob(GSRow *row, int no, uintptr_t inputData) {
        GetInterfaceArrayLength_return array_length = {0};
        array_length = GetInterfaceArrayLength(inputData, GS_TYPE_BLOB);
        if (array_length.r1 == -1) {
            array_length = GetInterfaceArrayLength(inputData, GS_TYPE_STRING);
            if (array_length.r1 == -1) {
                SWIG_exception(SWIG_ValueError, "Get string size from Go code is failed");
            }
        }
        GoUint8 *tmp = new GoUint8[array_length.r0 + 1]();
        GoSlice tmpSlice = {tmp, array_length.r0, array_length.r0};
        int result = SetForBlobString(inputData, tmpSlice);
        if (result == -1) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "Get blob from Go code is failed");
        }
        GSBlob blobValTmp = {array_length.r0, (const void*)tmp};
        GSResult ret = gsSetRowFieldByBlob(row, no, &blobValTmp);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set blob value for row");
        }
        return true;
    }
    static bool setRowFromObject(GSRow *row, int no, uintptr_t inputData, GSType type) {
        bool isNil = checkNil(inputData);
        if (isNil) {
%#if GS_COMPATIBILITY_SUPPORT_3_5
            GSResult ret = gsSetRowFieldNull(row, no);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "Can not set nil value for row");
            }
%#else
            SWIG_exception(SWIG_ValueError, "Nil is not support to set for row");
%#endif
        } else {
            switch (type) {
            case GS_TYPE_STRING:
                setRowFromObjectWithString(row, no, inputData);
                break;
            case GS_TYPE_BOOL:
                setRowFromObjectWithBool(row, no, inputData);
                break;
            case GS_TYPE_BYTE:
                setRowFromObjectWithByte(row, no, inputData);
                break;
            case GS_TYPE_SHORT:
                setRowFromObjectWithShort(row, no, inputData);
                break;
            case GS_TYPE_INTEGER:
                setRowFromObjectWithInteger(row, no, inputData);
                break;
            case GS_TYPE_LONG:
                setRowFromObjectWithLong(row, no, inputData);
                break;
            case GS_TYPE_FLOAT:
                setRowFromObjectWithFloat(row, no, inputData);
                break;
            case GS_TYPE_DOUBLE:
                setRowFromObjectWithDouble(row, no, inputData);
                break;
            case GS_TYPE_TIMESTAMP:
                setRowFromObjectWithTimestamp(row, no, inputData);
                break;
            case GS_TYPE_GEOMETRY:
                setRowFromObjectWithGeometry(row, no, inputData);
                break;
            case GS_TYPE_BLOB:
                setRowFromObjectWithBlob(row, no, inputData);
                break;
            default:
                SWIG_exception(SWIG_ValueError, "can not detect type from container successfully");
                break;
            }
        }
        return true;
    }
}
/**
* Typemaps for StoreFactory.set_properties() function
*/
%typemap(gotype) (const GSPropertyEntry* props, int propsCount) %{map[string]string%}
%typemap(imtype) (const GSPropertyEntry* props, int propsCount) %{[]swig_mapstringstring%}
%typemap(goin, fragment="goStructs") (const GSPropertyEntry* props, int propsCount) %{
    $result = make([]swig_mapstringstring, len($input), len($input))
    i := 0
    for key, value := range $input {
        $result[i].key = key
        $result[i].value = value
        i++
    }
%}
%typemap(in, fragment="cStructs") (const GSPropertyEntry* props, int propsCount)
(char *tmpName, char *tmpValue, int i, int j) %{
    swig_mapstringstring *prop_map = (swig_mapstringstring *)$input.array;
    $2 = $input.len;
    if ($2 > 0) {
        $1 = new GSPropertyEntry[$2]();
        for (i = 0; i < $2; i++) {
            tmpName = new char[prop_map[i].key.n + 1]();
            tmpValue = new char[prop_map[i].value.n + 1]();
            if (tmpName == NULL || tmpValue == NULL) {
                for (j = 0; j < i; j++) {
                    delete [] $1[j].name;
                    delete [] $1[j].value;
                }
            }
            memcpy(tmpName, prop_map[i].key.p, prop_map[i].value.n);
            memcpy(tmpValue, prop_map[i].value.p, prop_map[i].value.n);
            $1[i].name = tmpName;
            $1[i].value = tmpValue;
        }
    }
%}
%typemap(freearg) (const GSPropertyEntry* props, int propsCount) {
    if ($1) {
        for (int i = 0; i < $2; i++) {
            delete [] $1[i].name;
            delete [] $1[i].value;
        }
        delete [] $1;
    }
}

/**
* Typemaps for ContainerInfo's constructor
*/
%typemap(gotype) (const GSColumnInfo* props, int propsCount) %{[][]interface{}%}
%typemap(imtype) (const GSColumnInfo* props, int propsCount) %{[]uintptr%}
%typemap(goin) (const GSColumnInfo* props, int propsCount) %{
    $result = make([]uintptr, len($input), len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in) (const GSColumnInfo* props, int propsCount) (uintptr_t *tmpData, GoSlice sliceName,
int8_t *tmpStr, lenColumnName_return nameData, getColumnInfo_return result, int i, int k) %{
    tmpData = (uintptr_t*)$input.array;
    $2 = $input.len;
    if ($2 <= 0) {
        SWIG_exception(SWIG_ValueError, "err schema for GSColumnInfo no column");
    }
    $1 = new GSColumnInfo[$2]();
    for (i = 0; i < $2; i++) {
        nameData = lenColumnName(tmpData[i]);
        if (nameData.r1 == -1) {
            delete [] $1;
            for (k = 0; k < i; k++) {
                delete [] $1[k].name;
            }
            SWIG_exception(SWIG_ValueError, "get len for column name memory from Go code failed");
        }
        tmpStr = new int8_t[nameData.r0 + 1]();
        sliceName = {tmpStr, nameData.r0 + 1, nameData.r0 + 1};
        result = getColumnInfo(tmpData[i], sliceName);
        if (result.r2 == -1) {
            delete [] $1;
            for (k = 0; k < i; k++) {
                delete [] $1[k].name;
            }
            SWIG_exception(SWIG_ValueError, "get column info from Go code failed");
        }
        $1[i].name = (char *)tmpStr;
        $1[i].type = (int32_t) result.r0;
#if GS_COMPATIBILITY_SUPPORT_3_5
        if (result.r1 == 0) { // if no set for options
            $1[i].options = (i == 0) ? GS_TYPE_OPTION_NOT_NULL:GS_TYPE_OPTION_NULLABLE;
        } else {
            $1[i].options = (int32_t) result.r1;
        }
        $1[i].indexTypeFlags = GS_INDEX_FLAG_DEFAULT;
#endif
    }
%}
%typemap(freearg) (const GSColumnInfo* props, int propsCount) %{
    if ($1) {
        for (int i = 0; i < $2; i++) {
            delete [] $1[i].name;
        }
        delete [] $1;
    }
%}
/*
 * Typemap for ContainerInfo.set_column_info_list
 */
%typemap(gotype) (ColumnInfoList columnInfoList) %{[][]interface{}%}
%typemap(imtype) (ColumnInfoList columnInfoList) %{[]uintptr%}
%typemap(goin) (ColumnInfoList columnInfoList) %{
    $result = make([]uintptr, len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in) (ColumnInfoList columnInfoList) (GSColumnInfo *tmpColumnInfo, uintptr_t* tmpData, int i,
int k, lenColumnName_return nameData, getColumnInfo_return result, GoSlice tmpSlice, int8_t *tmpStr) %{
    $1.size = $input.len;
    tmpData = (uintptr_t *)$input.array;
    if ($1.size <= 0) {
        $1.columnInfo = NULL;
    } else {
        tmpColumnInfo = new GSColumnInfo[$1.size]();
        for (i = 0; i < $input.len; i++) {
            nameData = lenColumnName(tmpData[i]);
            if (nameData.r1 == -1) {
                for (k = 0; k < i; k++) {
                    delete [] tmpColumnInfo[k].name;
                }
                delete [] tmpColumnInfo;
                SWIG_exception(SWIG_ValueError, "get len for column name memory from Go code failed");
            }
            tmpStr = new int8_t[nameData.r0 + 1]();
            tmpSlice = {tmpStr, nameData.r0 + 1, nameData.r0 + 1};
            result = getColumnInfo(tmpData[i], tmpSlice);
            if (result.r2 == -1) {
                for (k = 0; k < i; k++) {
                    delete [] tmpColumnInfo[k].name;
                }
                delete [] tmpStr;
                delete [] tmpColumnInfo;
                SWIG_exception(SWIG_ValueError, "get column info from Go code failed");
            }
            tmpColumnInfo[i].name = (char *)tmpStr;
            tmpColumnInfo[i].type = result.r0;
#if GS_COMPATIBILITY_SUPPORT_3_5
            if (result.r1 == 0) { // if no set for options
                tmpColumnInfo[i].options = (i == 0) ? GS_TYPE_OPTION_NOT_NULL:GS_TYPE_OPTION_NULLABLE;
            } else {
                tmpColumnInfo[i].options = result.r1;
            }
            tmpColumnInfo[i].indexTypeFlags = GS_INDEX_FLAG_DEFAULT;
#endif
        }
        $1.columnInfo = tmpColumnInfo;
    }
%}
%typemap(freearg) (ColumnInfoList columnInfoList) {
    size_t size = $1.size;
    if ($1.columnInfo) {
        for (int i =0; i < size; i++) {
            if ($1.columnInfo[i].name) {
                delete [] $1.columnInfo[i].name;
            }
        }
        delete [] $1.columnInfo;
    }
}
/*
 * Typemap for ContainerInfo.get_column_info_list
 */
%typemap(gotype) (ColumnInfoList) %{[][]interface{}%}
%typemap(out) (ColumnInfoList) (swig_columnInfo *tmpColumnInfo, char *tmpStr, int i, int j) %{
    tmpColumnInfo = new swig_columnInfo[$1.size]();
    for (i = 0; i < $1.size; i++) {
        tmpColumnInfo[i].mType        = $1.columnInfo[i].type;
        tmpColumnInfo[i].options      = $1.columnInfo[i].options;
        tmpColumnInfo[i].columnName.n = strlen($1.columnInfo[i].name);
        tmpStr = new char[tmpColumnInfo[i].columnName.n]();
        memcpy(tmpStr, $1.columnInfo[i].name, tmpColumnInfo[i].columnName.n);
        tmpColumnInfo[i].columnName.p = tmpStr;
    }
    $result.len   = $1.size;
    $result.cap   = $1.size;
    $result.array = tmpColumnInfo;
%}
%typemap(goout) (ColumnInfoList) %{
    slice := *(*[]swig_columnInfo)(unsafe.Pointer(&$1))
    tmp   := make([][]interface{}, len(slice))
    for i := range slice {
        tmp[i] = make([]interface{}, 3)
        var columnName bytes.Buffer
        columnName.WriteString(slice[i].columnName)
        tmp[i][0] = columnName.String()
        tmp[i][1] = int(slice[i].mType)
        tmp[i][2] = int(slice[i].options)
    }
    C.freeColumnInfo(C.uintptr_t(uintptr(unsafe.Pointer(&$1))));
    $result = tmp
%}
/**
* Typemaps for fetch_all() function
*/
%typemap(gotype) (GSQuery* const* queryList, size_t queryCount) %{[]Query%}
%typemap(imtype) (GSQuery* const* queryList, size_t queryCount) %{[]uintptr%}
%typemap(goin) (GSQuery* const* queryList, size_t queryCount) %{
    $result = make([]uintptr, len($input), len($input))
    for i := range $input {
        $result[i] = $input[i].Swigcptr()
    }
%}
%typemap(in) (GSQuery* const* queryList, size_t queryCount) %{
    griddb::Query **queries = (griddb::Query **)($input.array);
    $2 = $input.len;
    $1 = NULL;
    if ($2 > 0) {
        $1 = new GSQuery*[$2]();
        for (int i = 0; i < $2; i++) {
            $1[i] = queries[i]->gs_ptr();
        }
    }
%}
%typemap(freearg) (GSQuery* const* queryList, size_t queryCount) {
    if ($1) {
        delete [] $1;
    }
}

/*
 * typemap for AggregationResult.get function in AggregationResult class
 */
%typemap(in, numinputs = 1) (griddb::Field *agValue) (griddb::Field tmpAgValue) %{
    $1 = &tmpAgValue;
%}
%typemap(gotype) (griddb::Field *agValue) %{*[]interface{}%}
%typemap(imtype) (griddb::Field *agValue) %{*[]swig_uintptr%}
%typemap(argout, fragment="cStructs") (griddb::Field *agValue) %{
    swig_uintptr *tmp = new swig_uintptr[1]();
    switch ($1->type) {
    case GS_TYPE_LONG: {
        long *tmpGo = new long();
        *tmpGo = $1->value.asLong;
        tmp[0].data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    case GS_TYPE_DOUBLE: {
        double *tmpGo = new double();
        *tmpGo = $1->value.asDouble;
        tmp[0].data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    case GS_TYPE_TIMESTAMP: {
        int64_t *tmpGo = new int64_t();
        *tmpGo = $1->value.asTimestamp;
        tmp[0].data = reinterpret_cast<std::uintptr_t>(tmpGo);
        break;
    }
    default:
        SWIG_exception(SWIG_ValueError, "type for AggregationResult.get incorrect");
    }
    tmp[0].type    = $1->type;
    tmp[0].isFloat = arg1->timestamp_output_with_float;
    $input->len = 1;
    $input->cap = 1;
    $input->array = tmp;
%}
%typemap(goargout, fragment="goStructs") (griddb::Field *agValue) %{
    slice    := *(*[]swig_uintptr)(unsafe.Pointer($1))
    tmpArray := make([]interface{}, 1, 1)
    switch (slice[0].mtype) {
        case TYPE_LONG:
            tmpArray[0] = *(*int64)(unsafe.Pointer(slice[0].data))
        case TYPE_DOUBLE:
            tmpArray[0] = *(*float64)(unsafe.Pointer(slice[0].data))
        case TYPE_TIMESTAMP: {
            tmp := *(*int64)(unsafe.Pointer(slice[0].data))
            if (!slice[0].isFloat) {
                tmpArray[0] = time.Unix(tmp / 1000, (tmp % 1000)*1000000).UTC()
            } else {
                tmpArray[0] = float64(tmp) / 1000
            }
        }
    }
    C.freeFieldDataForRow(C.uintptr_t((uintptr)(unsafe.Pointer($1))));
    *$input = tmpArray
%}

/**
* Typemaps for Container.put_row() function
*/
%typemap(gotype) (GSRow *rowContainer) %{[]interface{}%}
%typemap(imtype) (GSRow *rowContainer) %{[]uintptr%}
%typemap(goin) (GSRow *rowContainer) %{
    $result = make([]uintptr, len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in, fragment="SetRowWithBasicData", fragment="setRowFromObject") (GSRow *rowContainer)
(int i, int colNum, GSType* typeList, GSRow *tmpRow, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)($input.array);
    tmpRow = arg1->getGSRowPtr();
    typeList = arg1->getGSTypeList();
    colNum = arg1->getColumnCount();
    if (colNum != $input.len) {
        SWIG_exception(SWIG_ValueError, "column number for put row is not correct");
    }
    for (i = 0; i < colNum; i++) {
        setRowFromObject(tmpRow, i, tmpData[i], typeList[i]);
    }
%}

/**
* Typemaps for RowSet.update() function
*/
%typemap(gotype) (GSRow* row) %{[]interface{}%}
%typemap(imtype) (GSRow* row) %{[]uintptr%}
%typemap(goin) (GSRow* row) %{
    $result = make([]uintptr, len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in, fragment="setRowFromObject") (GSRow* row)
(int i, int colNum, GSType* typeList, GSRow *tmpRow, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)($input.array);
    tmpRow = arg1->getGSRowPtr();
    typeList = arg1->getGSTypeList();
    colNum = arg1->getColumnCount();
    if (colNum != $input.len) {
        SWIG_exception(SWIG_ValueError, "column number for put row is not correct");
    }
    for (i = 0; i < colNum; i++) {
        setRowFromObject(tmpRow, i, tmpData[i], typeList[i]);
    }
%}

/**
* Typemaps for Container.multi_put() function
*/
%typemap(gotype) (GSRow** listRowdata) %{[][]interface{}%}
%typemap(imtype) (GSRow** listRowdata) %{[]uintptr%}
%typemap(goin) (GSRow** listRowdata) %{
    if ($input == nil) {
        panic("wrong input for nil\n")
    }
    $result = make([]uintptr, len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in, fragment="setRowFromObject") (GSRow** listRowdata, int rowCount)
(int colNum, GSType* typeList, GSRow **tmpListRow, GSContainer *mContainer, GSResult ret,
uintptr_t *tmpData, GoSlice elements, uintptr_t *tmpfield, int i, int j, int k) %{
    tmpData = (uintptr_t *)$input.array;
    $2 = $input.len;
    if ($2 == 0) {
        $1 = NULL;
    } else {
        tmpListRow = new GSRow*[$2]();
        mContainer = arg1->getGSContainerPtr();
        colNum = arg1->getColumnCount();
        typeList = arg1->getGSTypeList();
        for (i = 0; i < $2; i++) {
            ret = gsCreateRowByContainer(mContainer, &tmpListRow[i]);
            if (ret != GS_RESULT_OK) {
                for (j = 0; j < i; j++) {
                    gsCloseRow(&tmpListRow[j]);
                }
                delete [] tmpListRow;
                SWIG_exception(SWIG_ValueError, "gsCreateRowByContainer failed");
            }
            if (colNum != lenRow(tmpData[i])) {
                delete [] tmpListRow;
                SWIG_exception(SWIG_ValueError, "column number for container multi put row is not correct");
            }
            tmpfield = new uintptr_t[colNum]();
            elements = {tmpfield, colNum, colNum};
            eachElementRow(tmpData[i], elements);
            for (k = 0; k < colNum; k++) {
                setRowFromObject(tmpListRow[i], k, tmpfield[k], typeList[k]);
            }
            delete [] tmpfield;
        }
        $1 = tmpListRow;
    }
%}
%typemap(freearg) (GSRow** listRowdata, int rowCount) {
    if ($1) {
        for (int rowNum = 0; rowNum < $2; rowNum++) {
            gsCloseRow(&$1[rowNum]);
        }
        delete [] $1;
    }
}

/*
* typemap for Container.get_row
*/
// Convert data for input
%typemap(gotype) (griddb::Field* keyFields) %{interface{}%}
%typemap(imtype) (griddb::Field* keyFields) %{uintptr%}
%typemap(goin) (griddb::Field* keyFields) %{
    $result = (uintptr)(unsafe.Pointer(&$input))
%}
%typemap(in, fragment = "convertObjectToFieldKey") (griddb::Field* keyFields)
(griddb::Field tmpField, uintptr_t tmpData, GSType* typeList) %{
    tmpData = (uintptr_t)$input;
    typeList = arg1->getGSTypeList();
    if (!convertObjectToFieldKey(tmpField, tmpData, typeList[0])) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for Container get row");
    }
    $1 = &tmpField;
%}
// Convert data for output
%typemap(in, numinputs = 1) (GSRow *rowdata) %{
    $1 = NULL;
%}
%typemap(gotype) (GSRow *rowdata) %{*[]interface{}%}
%typemap(imtype) (GSRow *rowdata) %{*[]swig_uintptr%}
%typemap(argout) (GSRow *rowdata)
(int i, GSRow *tmpRow, swig_uintptr *tmp, GSType *mType) %{
    if ($result == true) {
        $input->len = arg1->getColumnCount();
        $input->cap = arg1->getColumnCount();
        tmpRow = arg1->getGSRowPtr();
        tmp = new swig_uintptr[$input->len]();
        mType = arg1->getGSTypeList();
        for (i = 0; i < $input->len; i++) {
            convertGSRowToObjectUintptr(&tmp[i], tmpRow, mType[i], i, arg1->timestamp_output_with_float);
        }
        $input->array = tmp;
    }
%}
%typemap(goargout) (GSRow *rowdata) %{
    slice := *(*[]swig_uintptr)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterfaceUintptr(slice[i], &tmp[i])
    }
    C.freeFieldDataForRow(C.uintptr_t((uintptr)(unsafe.Pointer($1))));
    *$input = tmp
%}

/*
* typemap for RowSet.next_row function
*/
%typemap(in, numinputs = 1) (bool* hasNextRow) (bool tmpHasNextRow) %{
    $1 = &tmpHasNextRow;
%}
%typemap(gotype) (bool* hasNextRow) %{*[]interface{}%}
%typemap(imtype) (bool* hasNextRow) %{*[]swig_uintptr%}
%typemap(argout, fragment="convertGSRowToObject") (bool* hasNextRow)
(int i, GSRow *tmpRow, swig_uintptr *tmp, GSType *mType) %{
    if (*$1) {
        $input->len = arg1->getColumnCount();
        $input->cap = arg1->getColumnCount();
        tmpRow = arg1->getGSRowPtr();
        tmp = new swig_uintptr[$input->len]();
        mType = arg1->getGSTypeList();
        for (i = 0; i < $input->len; i++) {
            convertGSRowToObjectUintptr(&tmp[i], tmpRow, mType[i], i, arg1->timestamp_output_with_float);
        }
        $input->array = tmp;
    }
%}
%typemap(goargout) (bool* hasNextRow) %{
    slice := *(*[]swig_uintptr)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterfaceUintptr(slice[i], &tmp[i])
    }
    C.freeFieldDataForRow(C.uintptr_t((uintptr)(unsafe.Pointer($1))));
    *$input = tmp
%}
/*
* typemap for Store.multi_put function
*/
%typemap(gotype) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{map[string][][]interface{}%}
%typemap(imtype) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{[]uintptr%}
%typemap(goin) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) %{
    tmp    := make([]swig_ContainerListRow, len($input))
    $result = make([]uintptr, len($input))
    i := 0
    for con := range $input {
        tmp[i].containerName = con
        tmp[i].listSize      = int32(len($input[con]))
        tmpSlice := $input[con]
        tmp[i].listRow       = (uintptr)(unsafe.Pointer(&tmpSlice))
        $result[i]           = (uintptr)(unsafe.Pointer(&tmp[i]))
        i++
    }
%}
%typemap(in, numinputs = 1, fragment="setRowFromObject")
(GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
(char* tmpConName, griddb::Container* tmpContainer, int colNum, GSType* typeList,
swig_ContainerListRow *conData,  GoSlice sliceListRow, GoSlice *sliceRows, uintptr_t *fieldAddrs,
int result, uintptr_t *tmpData, int conNum, int i, int j, int k) %{
    $4 = $input.len;
    if ($4 == 0) {
        $1 = NULL;
        $2 = NULL;
        $3 = NULL;
    } else {
        $1         = new GSRow**[$4]();
        $2         = new int [$4]();
        $3         = new GSChar*[$4]();
        tmpData = (uintptr_t *)$input.array;
        // set data for each container
        for (conNum = 0; conNum < $4; conNum++) {
            conData = (swig_ContainerListRow *)tmpData[conNum];
            tmpConName = new char[conData->containerName.n + 1]();
            memcpy(tmpConName, conData->containerName.p, conData->containerName.n);
            $3[conNum]    = tmpConName;
            $2[conNum]    = conData->listSize;
            if ($2[conNum] == 0) {
                SWIG_exception(SWIG_ValueError, "number of row is null");
            } else {
                $1[conNum] = new GSRow* [$2[conNum]]();
                tmpContainer = arg1->get_container($3[conNum]);
                typeList = tmpContainer->getGSTypeList();
                colNum = tmpContainer->getColumnCount();
                sliceRows = new GoSlice[conData->listSize]();
                for (i = 0; i < conData->listSize; i++) {
                    fieldAddrs = new uintptr_t[colNum]();
                    sliceRows[i] = {fieldAddrs, colNum, colNum};
                }
                sliceListRow = {sliceRows, conData->listSize, conData->listSize};
                result = eachElementRowStoreMulPut(conData->listRow, sliceListRow);
                // set data for each row
                for (i = 0; i < conData->listSize; i++) {
                    GSResult ret = gsCreateRowByContainer(tmpContainer->getGSContainerPtr(), &$1[conNum][i]);
                    if (ret != GS_RESULT_OK) {
                        for (j = 0; j < i; j++) {
                            gsCloseRow(&$1[conNum][j]);
                        }
                        for (j = 0; j < conData->listSize; j++) {
                            delete [] (uintptr_t *)sliceRows[j].data;
                        }
                        delete sliceRows;
                        for (j = 0; j <= conNum; j++) {
                            delete [] $1[j];
                        }
                        delete [] $1;
                        delete [] $2;
                        delete [] $3;
                        SWIG_exception(SWIG_ValueError, "gsCreateRowByContainer failed");
                    }
                    if (colNum != sliceRows[i].len) {
                        delete [] $1;
                        delete [] $2;
                        delete [] $3;
                        for (j = 0; j < conData->listSize; j++) {
                            delete [] (uintptr_t *)sliceRows[j].data;
                        }
                        delete sliceRows;
                        SWIG_exception(SWIG_ValueError, "column number for store multi put row is not correct");
                    }
                    // set data for each field of row
                    fieldAddrs = (uintptr_t *)sliceRows[i].data;
                    for (j = 0; j < colNum; j++) {
                        setRowFromObject($1[conNum][i], j, fieldAddrs[j], typeList[j]);
                    }
                    delete [] (uintptr_t *)sliceRows[i].data;
                }
                delete sliceRows;
                // delete container after setting data for list of row
                delete tmpContainer;
            }
        }
    }
%}
%typemap(freearg) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) {
    for (int i = 0; i < $4; i++) {
        if ($1[i]) {
            for (int j = 0; j < $2[i]; j++) {
                gsCloseRow(&$1[i][j]);
            }
            delete [] $1[i];
        }
        if ($3) {
            if ($3[i]) {
                delete [] $3[i];
            }
        }
    }
    if ($1) delete [] $1;
    if ($2) delete [] $2;
    if ($3) delete [] $3;
}

/*
* typemap for Store.multi_get function
*/
//input for Store.multi_get() function
%typemap(gotype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{map[string]RowKeyPredicate%}
%typemap(imtype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{[]uintptr%}
%typemap(goin) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{
    tmpList := make([]swig_mapstringrowkeypredicate, len($input), len($input))
    $result = make([]uintptr, len($input), len($input))
    i := 0
    for containerName := range $input {
        tmpList[i].containerName = containerName
        tmpList[i].rowKeyPredicate = $input[containerName].Swigcptr()
        $result[i] = (uintptr)(unsafe.Pointer(&tmpList[i]))
        i++
    }
%}
%typemap(in) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount)
(swig_mapstringrowkeypredicate *mapper, GSRowKeyPredicateEntry *tmpEntry,
GSChar *tmpStr, uintptr_t *tmpData, int i) %{
    tmpData = (uintptr_t *)$input.array;
    $2 = $input.len;
    $1 = NULL;
    if ($2 > 0) {
        tmpEntry = new GSRowKeyPredicateEntry[$2]();
        // set data for each element of entry array
        for (i = 0; i < $2; i++) {
            mapper = (swig_mapstringrowkeypredicate *)tmpData[i];
            tmpStr = new GSChar[mapper->containerName.n + 1]();
            memcpy(tmpStr, mapper->containerName.p, mapper->containerName.n);
            tmpEntry[i].containerName = tmpStr;
            tmpEntry[i].predicate = (GSRowKeyPredicate *)mapper->rowKeyPredicate->gs_ptr();

        }
        $1 = &tmpEntry;
    }
%}
%typemap(freearg) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) {
    if (*$1) {
        for (int i = 0; i < $2; i++) {
            if ((*$1)[i].containerName) {
                delete [] (*$1)[i].containerName;
            }
        }
        delete [] (*$1);
    }
}
//output for Store.multi_get() function
%typemap(in) (GSContainerRowEntry **entryList, size_t* containerCount, int **colNumList, GSType*** typeList, int **orderFromInput)
(GSContainerRowEntry *tmpEntryList, size_t tmpContainerCount, int *tmpcolNumList, GSType** tmpTypeList, int *tmpOrderFromInput) {
    $1 = &tmpEntryList;
    $2 = &tmpContainerCount;
    $3 = &tmpcolNumList;
    $4 = &tmpTypeList;
    $5 = &tmpOrderFromInput;
}
%typemap(gotype) (GSContainerRowEntry **entryList, size_t* containerCount,
int **colNumList, GSType*** typeList, int **orderFromInput) %{*interface{}%}
%typemap(imtype) (GSContainerRowEntry **entryList, size_t* containerCount,
int **colNumList, GSType*** typeList, int **orderFromInput) %{*[]swig_ContainerListRow%}
%typemap(argout)
(GSContainerRowEntry **entryList, size_t* containerCount, int **colNumList, GSType*** typeList, int **orderFromInput)
(int i, int j, int k, swig_ContainerListRow *tmpEntry, GSChar *tmpStr,
GoSlice *tmpsliceRow, GoSlice *tmpListRow, swig_uintptr *tmpFields,
GSRow *tmpRow, GSContainerRowEntry *tmpEntryList) %{
    $input->len = *$2;
    $input->cap = *$2;
    tmpEntry = new swig_ContainerListRow[$input->len]();
    //set for each container
    for (i = 0; i < $input->len; i++) {
        // set containerName
        tmpEntryList = &((*$1)[((*$5)[i])]);
        tmpEntry[i].containerName.n = strlen(tmpEntryList->containerName);
        tmpStr = new GSChar[tmpEntry[i].containerName.n]();
        memcpy(tmpStr,  tmpEntryList->containerName, tmpEntry[i].containerName.n);
        tmpEntry[i].containerName.p = tmpStr;
        // set data for each row
        tmpEntry[i].listSize = tmpEntryList->rowCount;
        tmpsliceRow          = new GoSlice[1]();
        tmpsliceRow->len     = tmpEntry[i].listSize;
        tmpsliceRow->cap     = tmpEntry[i].listSize;
        tmpListRow           = new GoSlice[tmpEntry[i].listSize]();
        tmpsliceRow->data    = (void *)tmpListRow;
        tmpEntry[i].listRow  = (uintptr_t)tmpsliceRow;
        for (j = 0; j < tmpEntry[i].listSize; j++) {
            tmpListRow[j].len  = (*$3)[i];
            tmpListRow[j].cap  = (*$3)[i];
            tmpFields = new swig_uintptr[(*$3)[i]]();
            tmpListRow[j].data = (void *)tmpFields;
            // set data for output
            tmpRow = (GSRow*)(tmpEntryList->rowList[j]);
            for (k = 0; k < (*$3)[i]; k++) {
                convertGSRowToObjectUintptr(&tmpFields[k], tmpRow, (*$4)[i][k], k, arg1->timestamp_output_with_float);
            }
            gsCloseRow(&tmpRow);
        }
    }
    if (*$4) {
        for (int j = 0; j < *$2;j++) {
            if ((*$4)[j]) {
                delete []  (*$4)[j];
            }
        }
        delete [] (*$4);
    }
    delete [] (*$3);
    delete [] (*$5);
    $input->array = (void *)tmpEntry;
%}
%typemap(goargout) (GSContainerRowEntry **entryList,
size_t* containerCount, int **colNumList, GSType*** typeList, int **orderFromInput) %{
    slice := *(*[]swig_ContainerListRow)(unsafe.Pointer($1))
    tmp := make(map[string][][]interface{})
    for i := range slice {
        tmpSliceRow := *(*[][]swig_uintptr)(unsafe.Pointer(slice[i].listRow))
        tmpListRow  := make([][]interface{}, slice[i].listSize)
        var containerName bytes.Buffer
        containerName.WriteString(slice[i].containerName)
        for j := range tmpSliceRow {
            tmpListRow[j] = make([]interface{}, len(tmpSliceRow[j]))
            for n := range tmpListRow[j] {
                GoDataTOInterfaceUintptr(tmpSliceRow[j][n], &tmpListRow[j][n])
            }
        }
        tmp[containerName.String()] = tmpListRow
    }
    C.freeStoreMultiGet(C.uintptr_t(uintptr(unsafe.Pointer($1))))
    *$input = tmp
%}

/**
 * Typemap for QueryAnalysisEntry.get()
 */
%typemap(gotype) (GSQueryAnalysisEntry* queryAnalysis) %{*[]interface{}%}
%typemap(imtype) (GSQueryAnalysisEntry* queryAnalysis) %{*[]uintptr%}
%typemap(in, numinputs = 1) (GSQueryAnalysisEntry* queryAnalysis) (GSQueryAnalysisEntry queryAnalysis1) {
    $1 = &queryAnalysis1;
}
%typemap(argout) (GSQueryAnalysisEntry* queryAnalysis)
(long *tmpID, long *tmpDepth, GoString * tmpType, GoString * tmpValueType,
GoString * tmpValue, GoString * tmpStatement, uintptr_t *tmp)%{
    tmpID             = new long();
    tmpDepth          = new long();
    tmpType      = new GoString();
    tmpValueType = new GoString();
    tmpValue     = new GoString();
    tmpStatement = new GoString();
    tmpType->p      = new char[strlen($1->type)]();
    tmpValueType->p = new char[strlen($1->valueType)]();
    tmpValue->p     = new char[strlen($1->value)]();
    tmpStatement->p = new char[strlen($1->statement)]();
    *tmpID        = $1->id;
    *tmpDepth     = $1->depth;
    memcpy((void*)tmpType->p, $1->type, strlen($1->type));
    memcpy((void*)tmpValueType->p, $1->valueType, strlen($1->valueType));
    memcpy((void*)tmpValue->p, $1->value, strlen($1->value));
    memcpy((void*)tmpStatement->p, $1->statement, strlen($1->statement));
    tmpType->n      = strlen($1->type);
    tmpValueType->n = strlen($1->valueType);
    tmpValue->n     = strlen($1->value);
    tmpStatement->n = strlen($1->statement);

    delete $1->type;
    delete $1->valueType;
    delete $1->value;
    delete $1->statement;

    // set data for output
    $input->len = 6;
    $input->cap = 6;
    tmp = new uintptr_t[6]();
    tmp[0] = reinterpret_cast<std::uintptr_t>(tmpID);
    tmp[1] = reinterpret_cast<std::uintptr_t>(tmpDepth);
    tmp[2] = reinterpret_cast<std::uintptr_t>(tmpType);
    tmp[3] = reinterpret_cast<std::uintptr_t>(tmpValueType);
    tmp[4] = reinterpret_cast<std::uintptr_t>(tmpValue);
    tmp[5] = reinterpret_cast<std::uintptr_t>(tmpStatement);
    $input->array = tmp;
%}
%typemap(goargout) (GSQueryAnalysisEntry* queryAnalysis) %{
    slice := *(*[]uintptr)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    tmp[0] = *(*int)(unsafe.Pointer(slice[0]))
    tmp[1] = *(*int)(unsafe.Pointer(slice[1]))
    var buffer2 bytes.Buffer
    buffer2.WriteString(*(*string)(unsafe.Pointer(slice[2])))
    tmp[2] = buffer2.String()
    var buffer3 bytes.Buffer
    buffer3.WriteString(*(*string)(unsafe.Pointer(slice[3])))
    tmp[3] = buffer3.String()
    var buffer4 bytes.Buffer
    buffer4.WriteString(*(*string)(unsafe.Pointer(slice[4])))
    tmp[4] = buffer4.String()
    var buffer5 bytes.Buffer
    buffer5.WriteString(*(*string)(unsafe.Pointer(slice[5])))
    tmp[5] = buffer5.String()
    C.freeQueryEntryGet(C.uintptr_t(uintptr(unsafe.Pointer($1))))
    *$input = tmp
%}

/**
 * Typemap for PartitionController.GetContainerNames()
 * PartitionController.GetPartitionHosts()
 * PartitionController.GetPartitionBackupHosts()
 */
%typemap(gotype) (const GSChar * const ** stringList, size_t *size) %{*[]string%}
%typemap(in, numinputs = 1) (const GSChar * const ** stringList, size_t *size)
(GSChar ** tmpStringList, size_t tmpSize) {
    $1 = &tmpStringList;
    $2 = &tmpSize;
}
%typemap(argout) (const GSChar * const ** stringList, size_t *size)
(_gostring_ *sliceStr, int i, int k, char *tmpStr) %{
    sliceStr = new _gostring_[*$2]();
    for (int i = 0; i < *$2; i++) {
        tmpStr = new char[strlen((*$1)[i])]();
        memcpy(tmpStr, (*$1)[i], strlen((*$1)[i]));
        sliceStr[i].n = strlen((*$1)[i]);
        sliceStr[i].p = tmpStr;
    }
    $input->len = *$2;
    $input->cap = *$2;
    $input->array = sliceStr;
%}
%typemap(goargout) (const GSChar * const ** stringList, size_t *size) %{
    slice := *(*[]string)(unsafe.Pointer($1))
    tmp := make([]string, len(slice), len(slice))
    for i := range slice {
        var buffer bytes.Buffer
        buffer.WriteString(slice[i])
        tmp[i] = buffer.String()
    }
    C.freePartitionConName(C.uintptr_t(uintptr(unsafe.Pointer($1))));
    *$input = tmp
%}

/**
 * Typemap for RowKeyPredicate.set_range()
*/
%typemap(gotype) (griddb::Field* startKey) %{interface{}%}
%typemap(imtype) (griddb::Field* startKey) %{uintptr%}
%typemap(goin) (griddb::Field* startKey) %{
    $result = (uintptr)(unsafe.Pointer(&$input))
%}
%typemap(in, fragment="convertObjectToFieldKey") (griddb::Field* startKey)
(griddb::Field tmpFieldStart, uintptr_t tmpDataStart, GSType typeStartKey) %{
    tmpDataStart = (uintptr_t)$input;
    typeStartKey = arg1->get_key_type();
    if (!convertObjectToFieldKey(tmpFieldStart, tmpDataStart, typeStartKey)) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for Container get row");
    }
    $1 = &tmpFieldStart;
%}
%typemap(gotype) (griddb::Field* finishKey) %{interface{}%}
%typemap(imtype) (griddb::Field* finishKey) %{uintptr%}
%typemap(goin) (griddb::Field* finishKey) %{
    $result = (uintptr)(unsafe.Pointer(&$input))
%}
%typemap(in, fragment="convertObjectToFieldKey") (griddb::Field* finishKey)
(griddb::Field tmpFieldFinish, uintptr_t tmpDataFinish, GSType typeFinishKey) %{
    tmpDataFinish = (uintptr_t)$input;
    typeFinishKey = arg1->get_key_type();
    if (!convertObjectToFieldKey(tmpFieldFinish, tmpDataFinish, typeFinishKey)) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for Container get row");
    }
    $1 = &tmpFieldFinish;
%}

/**
 * Typemaps output for RowKeyPredicate.set_distinct_keys()
*/
%typemap(gotype) (const griddb::Field *keys, size_t keyCount) %{[]interface{}%}
%typemap(imtype) (const griddb::Field *keys, size_t keyCount) %{[]uintptr%}
%typemap(goin) (const griddb::Field *keys, size_t keyCount) %{
    $result = make([]uintptr, len($input))
    for i := range $input {
        $result[i] = (uintptr)(unsafe.Pointer(&$input[i]))
    }
%}
%typemap(in, fragment="convertObjectToFieldKey") (const griddb::Field *keys, size_t keyCount)
(griddb::Field *tmpField, int i, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)$input.array;
    $2 = $input.len;
    if ($2 <= 0) {
        SWIG_exception(SWIG_ValueError, "distinct keys incorrect");
    }
    tmpField = new griddb::Field[$2]();
    GSType type = arg1->get_key_type();
    for (i = 0; i < $2; i++) {
        if (!convertObjectToFieldKey(tmpField[i], tmpData[i], type)) {
            delete [] tmpField;
            SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for set_distinct_keys");
        }
    }
    $1 = tmpField;
%}
%typemap(freearg) (const griddb::Field *keys, size_t keyCount) {
    delete [] $1;
}

/**
 * Typemap for RowKeyPredicate.get_range()
 * Typemaps output for RowKeyPredicate.get_distinct_keys()
 */
// typemap for ouput of RowKeyPredicate.get_range()
%typemap(in, numinputs = 1) (griddb::Field* startField, griddb::Field* finishField) (griddb::Field tmpStartField, griddb::Field tmpFinishField) %{
    $1 = &tmpStartField;
    $2 = &tmpFinishField;
%}
%typemap(gotype) (griddb::Field* startField, griddb::Field* finishField) %{*[]interface{}%}
%typemap(imtype) (griddb::Field* startField, griddb::Field* finishField) %{*[]swig_uintptr%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Field* startField, griddb::Field* finishField)
(swig_uintptr *tmp) %{
    $input->len = 2;
    $input->cap = 2;
    tmp = new swig_uintptr[$input->len]();
    if ($1->type == GS_TYPE_NULL) {
        tmp[0].type = GS_TYPE_NULL;
        tmp[1].type = GS_TYPE_NULL;
    } else {
        if (!convertFieldKeyToObjectUintptr(&tmp[0], $1->type, $1, arg1->timestamp_output_with_float)) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "set start key for RowKeyPredicate.get_range failed");
        }
        if (!convertFieldKeyToObjectUintptr(&tmp[1], $2->type, $2, arg1->timestamp_output_with_float)) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "set finish key for RowKeyPredicate.get_range failed");
        }
    }
    $input->array = tmp;
%}
%typemap(goargout) (griddb::Field* startField, griddb::Field* finishField) %{
    slice := *(*[]swig_uintptr)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterfaceUintptr(slice[i], &tmp[i])
    }
    C.freeFieldDataForRow(C.uintptr_t((uintptr)(unsafe.Pointer($1))));
    *$input = tmp
%}
// typemap for ouput of RowKeyPredicate.get_distinct_keys()
%typemap(in, numinputs=1) (griddb::Field **keys, size_t* keyCount) (griddb::Field *tmpKeys, size_t tmpKeyCount) {
  $1 = &tmpKeys;
  $2 = &tmpKeyCount;
}
%typemap(gotype) (griddb::Field **keys, size_t* keyCount) %{*[]interface{}%}
%typemap(imtype) (griddb::Field **keys, size_t* keyCount) %{*[]swig_uintptr%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Field **keys, size_t* keyCount)
(swig_uintptr *tmp, int i) %{
    $input->len = *$2;
    $input->cap = *$2;
    tmp = new swig_uintptr[$input->len]();
    for (i = 0; i < $input->len; i++) {
        if (!convertFieldKeyToObjectUintptr(&tmp[i], (*$1)[i].type, &(*$1)[i], arg1->timestamp_output_with_float)) {
            delete [] tmp;
            SWIG_exception(SWIG_ValueError, "set start key for RowKeyPredicate.get_distinct_keys failed");
        }
    }
    $input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (griddb::Field **keys, size_t* keyCount) %{
    slice := *(*[]swig_uintptr)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterfaceUintptr(slice[i], &tmp[i])
    }
    C.freeFieldDataForRow(C.uintptr_t((uintptr)(unsafe.Pointer($1))));
    *$input = tmp
%}

/**
 * Support close method
 */
%typemap(gotype) (GSBool allRelated) %{bool%}

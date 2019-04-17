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
%}
// rename all method to camel cases
%rename("%(lowercamelcase)s", %$isfunction) "";
%include exception.i
%typemap(throws) griddb::GSException  %{_swig_gopanic($1.what());%}

#define UTC_TIMESTAMP_MAX 253402300799.999

%insert(go_wrapper) %{
const (
    FETCH_OPTION_LIMIT_MAX = 2147483647
)
const (
    CONTAINER_COLLECTION = iota
    CONTAINER_TIME_SERIES
)
const (
    INDEX_FLAG_DEFAULT = -1
    INDEX_FLAG_TREE = 1
    INDEX_FLAG_HASH = 2
    INDEX_FLAG_SPATIAL = 4
)
const (
    ROW_SET_CONTAINER_ROWS = iota
    ROW_SET_AGGREGATION_RESULT
    ROW_SET_QUERY_ANALYSIS
)
const (
    TYPE_STRING = iota
    TYPE_BOOL
    TYPE_BYTE
    TYPE_SHORT
    TYPE_INTEGER
    TYPE_LONG
    TYPE_FLOAT
    TYPE_DOUBLE
    TYPE_TIMESTAMP
    TYPE_GEOMETRY
    TYPE_BLOB
    TYPE_STRING_ARRAY
    TYPE_BOOL_ARRAY
    TYPE_BYTE_ARRAY
    TYPE_SHORT_ARRAY
    TYPE_INTEGER_ARRAY
    TYPE_LONG_ARRAY
    TYPE_FLOAT_ARRAY
    TYPE_DOUBLE_ARRAY
    TYPE_TIMESTAMP_ARRAY
    TYPE_NULL = -1
)
const (
    FETCH_LIMIT = iota
)
const (
    TIME_UNIT_YEAR = iota
    TIME_UNIT_MONTH
    TIME_UNIT_DAY
    TIME_UNIT_HOUR
    TIME_UNIT_MINUTE
    TIME_UNIT_SECOND
    TIME_UNIT_MILLISECOND
)
const (
    TYPE_OPTION_NULLABLE = iota
    TYPE_OPTION_NOT_NULL
)
%}
%typemap(imtype) (griddb::ContainerInfo*) %{SwigcptrWrapped_ContainerInfo%}
namespace griddb {
%rename(Wrapped_ContainerInfo) ContainerInfo;
}
%insert(go_wrapper) %{
type ContainerInfo interface {
    Wrapped_ContainerInfo
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
            result = NewWrapped_ContainerInfo(name, column_info_list, container_type, row_key, expiration)
        } else {
            result = NewWrapped_ContainerInfo(name, column_info_list, container_type, row_key)
        }
    } else {
        result = NewWrapped_ContainerInfo(a ...)
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
    defer catch(&err)
    e.Wrapped_get(mType, &agResult)
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
    e.Wrapped_multi_get(predicate, &mapRowList)
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
    e.Wrapped_get_container_names(a ...)
    return
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
// represent for []interface{}{string, int , int}
%fragment("cstringintint", "header") %{
struct swig_stringintint {
    _gostring_ columnName;
    long mType;
    long options;
};
%}
%fragment("gostringintint", "go_runtime") %{
type swig_stringintint struct {
    columnName string;
    mType int;
    options int;
}
%}

// represent for map[string]string
%fragment("cstringstring", "header") %{
struct swig_mapstringstring {
    _gostring_ key;
    _gostring_ value;
};
%}
%fragment("gostringstring", "go_runtime") %{
type swig_mapstringstring struct {
    key string;
    value string;
}
%}

// represent for map[string]int
%fragment("cstringint", "header") %{
struct swig_cmapstringint {
    _gostring_ key;
    long value;
};
%}
%fragment("gostringint", "go_runtime") %{
type swig_gomapstringint struct {
    key string;
    value int;
}
%}

// represent for map[string]RowKeyPredicate
%fragment("cstringrowkeypredicate", "header") %{
struct swig_mapstringrowkeypredicate {
    _gostring_ containerName;
    griddb::RowKeyPredicate* rowKeyPredicate;
};
%}
%fragment("gostringrowkeypredicate", "go_runtime") %{
type swig_mapstringrowkeypredicate struct {
    containerName string;
    rowKeyPredicate uintptr;
}
%}

// represent for map[string][][]interface{}
%fragment("cContainerListRow", "header") %{
struct swig_ContainerListRow {
    _gostring_ containerName;
    intgo list_size;
    _goslice_ listRow;
};
%}
%fragment("goContainerListRow", "go_runtime") %{
type swig_ContainerListRow struct {
    containerName string;
    list_size int;
    listRow [][]swig_interface;
}
%}

// represent for []interface{}
%fragment("cinterface", "header") %{
struct swig_interface {
    intgo type;
    _gostring_ asString;
    bool asBool;
    int8_t asByte;
    int16_t asShort;
    int32_t asInteger;
    int64_t asLong;
    float asFloat;
    double asDouble;
    int64_t asTimestamp;
    _gostring_ asGeometry;
    _goslice_ asBlob;
    bool timestamp_output_with_float;


};
%}
%go_import("fmt")
%go_import("strconv")
%go_import("strings")
%go_import("math")
%go_import("reflect")
%go_import("time")
%fragment("gointerface", "go_runtime") %{
type swig_interface struct {
    mtype int
    asString string
    asBool bool
    asByte int8
    asShort int16
    asInteger int32
    asLong int64
    asFloat float32
    asDouble float64
    asTimestamp int64
    asGeometry string
    asBlob []byte
    timestamp_output_with_float bool

}
func GoDataFromInterface(mResult *swig_interface, mInput *interface{}) {
    if((*mInput) == nil) {
        (*mResult).mtype = TYPE_NULL
    } else {
        switch reflect.ValueOf((*mInput)).Kind() {
            case reflect.String:
                value, ok := (*mInput).(string)
                if(!ok) {
                    panic("can not interface convert to string")
                }
                (*mResult).asString = value
                (*mResult).mtype = TYPE_STRING
            case reflect.Bool:
                value, ok := (*mInput).(bool)
                if(!ok) {
                    panic("can not interface convert to bool")
                }
                (*mResult).asBool = value
                (*mResult).mtype = TYPE_BOOL
            case reflect.Int8:
                value, ok := (*mInput).(int8)
                if(!ok) {
                    panic("can not interface convert to int")
                }
                (*mResult).asByte = int8(value)
                (*mResult).mtype = TYPE_BYTE
            case reflect.Int16:
                value, ok := (*mInput).(int16)
                if(!ok) {
                    panic("can not interface convert to int")
                }
                if ((math.MinInt8 <= value) && (value <= math.MaxInt8)) {
                    (*mResult).asByte = int8(value)
                    (*mResult).mtype = TYPE_BYTE
                } else {
                    (*mResult).asShort = int16(value)
                    (*mResult).mtype = TYPE_SHORT
                }
            case reflect.Int32:
                value, ok := (*mInput).(int32)
                if(!ok) {
                    panic("can not interface convert to int")
                }
                if ((math.MinInt8 <= value) && (value <= math.MaxInt8)) {
                    (*mResult).asByte = int8(value)
                    (*mResult).mtype = TYPE_BYTE
                } else if ((math.MinInt16 <= value) && (value <= math.MaxInt16)) {
                    (*mResult).asShort = int16(value)
                    (*mResult).mtype = TYPE_SHORT
                } else {
                    (*mResult).asInteger = int32(value)
                    (*mResult).mtype = TYPE_INTEGER
                }
            case reflect.Int:
                value, ok := (*mInput).(int)
                if(!ok) {
                    panic("can not interface convert to int")
                }
                if ((math.MinInt8 <= value) && (value <= math.MaxInt8)){
                    (*mResult).asByte = int8(value)
                    (*mResult).mtype = TYPE_BYTE
                } else if ((math.MinInt16 <= value) && (value <= math.MaxInt16)){
                    (*mResult).asShort = int16(value)
                    (*mResult).mtype = TYPE_SHORT
                } else if ((math.MinInt32 <= value) && (value <= math.MaxInt32)){
                    (*mResult).asInteger = int32(value)
                    (*mResult).mtype = TYPE_INTEGER
                } else {
                    (*mResult).asLong = int64(value)
                    (*mResult).mtype = TYPE_LONG
                }
            case reflect.Int64:
                value, ok := (*mInput).(int64)
                if(!ok) {
                    panic("can not interface convert to int64")
                }
                if ((math.MinInt8 <= value) && (value <= math.MaxInt8)){
                    (*mResult).asByte = int8(value)
                    (*mResult).mtype = TYPE_BYTE
                } else if ((math.MinInt16 <= value) && (value <= math.MaxInt16)){
                    (*mResult).asShort = int16(value)
                    (*mResult).mtype = TYPE_SHORT
                } else if ((math.MinInt32 <= value) && (value <= math.MaxInt32)){
                    (*mResult).asInteger = int32(value)
                    (*mResult).mtype = TYPE_INTEGER
                } else {
                    (*mResult).asLong = int64(value)
                    (*mResult).mtype = TYPE_LONG
                }
            case reflect.Float32:
                value, ok := (*mInput).(float32)
                if(!ok) {
                    panic("can not interface convert to float")
                }
                (*mResult).asFloat = value
                (*mResult).mtype = TYPE_FLOAT
            case reflect.Float64:
                value, ok := (*mInput).(float64)
                if(!ok) {
                    panic("can not interface convert to double")
                }
                (*mResult).asDouble = value
                (*mResult).mtype = TYPE_DOUBLE
            case reflect.Struct:
                tmp, ok := (*mInput).(time.Time)
                if (!ok) {
                    panic("can not interface convert to time object")
                }
                (*mResult).mtype = TYPE_TIMESTAMP
                (*mResult).asTimestamp = tmp.Unix() // get second
                // get mili second for timestamp
                var tmpMili int64
                tmpMili = 0
                if (strings.Contains(tmp.String(), ".")) {
                    strList := strings.Split(tmp.String(), " ")
                    mstr := strList[1]
                    strList = strings.Split(mstr, ".")
                    // get mili second, remove redundant number after mili second
                    if (len(strList[1]) > 3) {
                        strList[1] = strList[1][:3]
                    }
                    tmpConvert, err := strconv.Atoi(strList[1])
                    if (err == nil) {
                        if (len(strList[1]) == 3) {
                            tmpMili = int64(tmpConvert)
                        } else if( len(strList[1]) == 2) {
                            tmpMili = int64(tmpConvert) * 10
                        } else if(len(strList[1]) == 1) {
                            tmpMili = int64(tmpConvert) * 100
                        } else {
                            //nothing to do
                        }
                    }
                }
                // Add mili second to timestamp
                (*mResult).asTimestamp = (*mResult).asTimestamp * 1000 + tmpMili
            case reflect.Slice:
                value, ok := (*mInput).([]byte)
                if(!ok) {
                    panic("can not interface convert to blob")
                }
                (*mResult).asBlob = value
                (*mResult).mtype = TYPE_BLOB
            default:
                panic("no type of interface found for row")
        }
    }
}

func GoDataTOInterface(mInput *swig_interface, mResult *interface{}) {
    switch (*mInput).mtype {
        case TYPE_STRING:
            *mResult = (*mInput).asString
        case TYPE_BOOL:
            *mResult = (*mInput).asBool
        case TYPE_BYTE:
            *mResult = (*mInput).asByte
        case TYPE_SHORT:
            *mResult = (*mInput).asShort
        case TYPE_INTEGER:
            *mResult = (*mInput).asInteger
        case TYPE_LONG:
            *mResult = (*mInput).asLong
        case TYPE_FLOAT:
            *mResult = (*mInput).asFloat
        case TYPE_DOUBLE:
            *mResult = (*mInput).asDouble
        case TYPE_TIMESTAMP:
            var tmp interface{}
            if ((*mInput).timestamp_output_with_float) {
                tmp = (*mInput).asTimestamp
            } else {
                tmp = time.Unix((*mInput).asTimestamp / 1000, ((*mInput).asTimestamp % 1000)*1000000).UTC()
            }
            *mResult = tmp
        case TYPE_GEOMETRY:
            *mResult = (*mInput).asGeometry
        case TYPE_BLOB:
            *mResult = (*mInput).asBlob
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
%fragment("convertFieldToObject", "header", fragment = "cinterface") {
static void convertFieldToObject(swig_interface *map, GSValue *value, GSType type, bool timestamp_output_with_float = false) {
    map->type = type;
    switch (type) {
        case GS_TYPE_STRING:
            map->asString.n = strlen(value->asString);
            map->asString.p = (GSChar *)malloc(sizeof(GSChar) * map->asString.n + 1);
            if (map->asString.p == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for string to convert field to object failed");
            }
            memset(map->asString.p, 0x0, sizeof(GSChar) * map->asString.n + 1);
            memcpy(map->asString.p, value->asString, strlen(value->asString));
            break;
        case GS_TYPE_BOOL:
            map->asBool =  value->asBool;
            break;
        case GS_TYPE_BYTE:
            map->asByte = value->asByte;
            break;
        case GS_TYPE_SHORT:
            map->asShort = value->asShort;
            break;
        case GS_TYPE_INTEGER:
            map->asInteger =  value->asInteger;
            break;
        case GS_TYPE_LONG:
            map->asLong =  value->asLong;
            break;
        case GS_TYPE_FLOAT:
            map->asFloat =  value->asFloat;
            break;
        case GS_TYPE_DOUBLE:
            map->asDouble =  value->asDouble;
            break;
        case GS_TYPE_TIMESTAMP:
            map->asTimestamp = value->asTimestamp;
            map->timestamp_output_with_float = timestamp_output_with_float;
            break;
        case GS_TYPE_GEOMETRY:
            map->asGeometry.n = strlen(value->asGeometry);
            map->asGeometry.p = (GSChar *)malloc(sizeof(GSChar) * map->asGeometry.n + 1);
            if (map->asGeometry.p == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for geometry to convert field to object failed");
            }
            memset(map->asGeometry.p, 0x0, sizeof(GSChar) * map->asGeometry.n + 1);
            memcpy(map->asGeometry.p, value->asGeometry, strlen(value->asGeometry));
            break;
        case GS_TYPE_BLOB:
            map->asBlob.len = value->asBlob.size;
            map->asBlob.cap = value->asBlob.size;
            map->asBlob.array = malloc(sizeof(GSChar) * map->asBlob.len);
            if (map->asBlob.array == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for blob to convert field to object failed");
            }
            memcpy(map->asBlob.array, value->asBlob.data, map->asBlob.len);
            break;
%#if GS_COMPATIBILITY_SUPPORT_3_5
        case GS_TYPE_NULL:
            break;
%#endif
        default:
            SWIG_exception(SWIG_ValueError, "GSType to convert field to object is not correct");
    }
}
}
/*
* fragment to support converting data for GSRow
*/
%fragment("convertGSRowToObject", "header", fragment = "cinterface") {
static void convertGSRowToObject(swig_interface *map, GSRow *row, GSType type, int no, bool timestamp_output_with_float = false) {
    GSResult ret;
%#if GS_COMPATIBILITY_SUPPORT_3_5
    GSBool nullValue;
    ret = gsGetRowFieldNull(row, no, &nullValue);
    if (ret != GS_RESULT_OK) {
        SWIG_exception(SWIG_ValueError, "check get field null failed");
    }
    map->type = GS_TYPE_NULL;
%#endif
    switch (type) {
        case GS_TYPE_STRING: {
            GSChar* stringValue;
            ret = gsGetRowFieldAsString(row, no, (const GSChar **)&stringValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field string failed");
            }
            map->asString.n = strlen(stringValue);
            map->asString.p = (GSChar *)malloc(sizeof(GSChar) * map->asString.n + 1);
            if (map->asString.p == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for string to convert row to Object failed");
            }
            memset(map->asString.p, 0x0, sizeof(GSChar) * map->asString.n + 1);
            memcpy(map->asString.p, stringValue, map->asString.n);
            break;
        }
        case GS_TYPE_BOOL: {
            GSBool boolValue;
            ret = gsGetRowFieldAsBool(row, no, &boolValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field bool failed");
            }
            map->asBool =  boolValue;
            break;
        }
        case GS_TYPE_BYTE: {
            int8_t byteValue;
            ret = gsGetRowFieldAsByte(row, no, &byteValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field byte failed");
            }
            map->asByte = byteValue;
            break;
        }
        case GS_TYPE_SHORT: {
            int16_t shortValue;
            ret = gsGetRowFieldAsShort(row, no, &shortValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field short failed");
            }
            map->asShort = shortValue;
            break;
        }
        case GS_TYPE_INTEGER: {
            int32_t intValue;
            ret = gsGetRowFieldAsInteger(row, no, &intValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field integer failed");
            }
            map->asInteger = intValue;
            break;
        }
        case GS_TYPE_LONG: {
            int64_t longValue;
            ret = gsGetRowFieldAsLong(row, no, &longValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field long failed");
            }
            map->asLong = longValue;
            break;
        }
        case GS_TYPE_FLOAT: {
            float floatValue;
            ret = gsGetRowFieldAsFloat(row, no, &floatValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field float failed");
            }
            map->asFloat =  floatValue;
            break;
        }
        case GS_TYPE_DOUBLE: {
            double doubleValue;
            ret = gsGetRowFieldAsDouble(row, no, &doubleValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field double failed");
            }
            map->asDouble =  doubleValue;
            break;
        }
        case GS_TYPE_TIMESTAMP: {
            GSTimestamp timestampValue;
            ret = gsGetRowFieldAsTimestamp(row, no, &timestampValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field timestamp failed");
            }
            map->asTimestamp = timestampValue;
            map->timestamp_output_with_float = timestamp_output_with_float;
            break;
        }
        case GS_TYPE_GEOMETRY: {
            GSChar* geometryValue;
            ret = gsGetRowFieldAsGeometry(row, no, (const GSChar **)&geometryValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field geometry failed");
            }
            map->asGeometry.n = strlen(geometryValue);
            map->asGeometry.p = (GSChar *)malloc(sizeof(GSChar) * map->asGeometry.n + 1);
            if (map->asGeometry.p == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for geometry to convert row to Object failed");
            }
            memset(map->asGeometry.p, 0x0, sizeof(GSChar) * map->asGeometry.n + 1);
            memcpy(map->asGeometry.p, geometryValue, map->asGeometry.n);
            break;
        }
        case GS_TYPE_BLOB: {
            GSBlob blobValue;
            ret = gsGetRowFieldAsBlob(row, no, &blobValue);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "get field string failed");
            }
            map->asBlob.len = blobValue.size;
            map->asBlob.cap = blobValue.size;
            map->asBlob.array = malloc(sizeof(GSChar) * map->asBlob.len);
            if (map->asBlob.array == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for blob to convert row to object failed");
            }
            memcpy(map->asBlob.array, blobValue.data, map->asBlob.len);
            break;
        }
        default:
            SWIG_exception(SWIG_ValueError, "GSType for convert row to object is not correct");
    }
    map->type = type;
}
}

/**
 * Support convert type from object to GSTimestamp: input in target language can be :
 * datetime object, string, float, int
 */
%fragment("convertObjectToGSTimestamp", "header") {
static bool convertObjectToGSTimestamp(swig_interface *map, GSTimestamp* timestamp) {
    switch (map->type) {
    case GS_TYPE_TIMESTAMP:
        *timestamp = map->asTimestamp;
        break;
    case GS_TYPE_BYTE:
        *timestamp = map->asByte*1000;
        break;
    case GS_TYPE_SHORT:
        *timestamp = map->asShort*1000;
        break;
    case GS_TYPE_INTEGER:
        *timestamp = map->asInteger*1000;
        break;
    case GS_TYPE_LONG:
        if (map->asLong > UTC_TIMESTAMP_MAX) {
            return false;
        }
        *timestamp = map->asLong*1000;
        break;
    case GS_TYPE_FLOAT:
        if (map->asFloat > UTC_TIMESTAMP_MAX) {
            return false;
        }
        *timestamp = static_cast<int64_t>(map->asFloat*1000);
        break;
    case GS_TYPE_DOUBLE:
        if (map->asDouble > UTC_TIMESTAMP_MAX) {
            return false;
        }
        *timestamp = static_cast<int64_t>(map->asDouble*1000);
        break;
    case GS_TYPE_STRING:
    {
        GSChar *s = (GSChar *)malloc(sizeof(GSChar) * map->asString.n + 1);
        if (s == NULL) {
            SWIG_exception(SWIG_ValueError, "Can not allocate for timestamp string");
        }
        memset(s, 0, sizeof(GSChar) * map->asString.n + 1);
        memcpy(s, map->asString.p, map->asString.n);
        if (gsParseTime(s, timestamp) == GS_FALSE) {
            printf("gsParseTime for field key failed!");
            return false;
        }
        free((void *)s);
        break;
    }
    default:
        // Invalid input
        return false;
    }
    return true;
}
}
%fragment("convertObjectToFieldKey", "header", fragment = "cinterface", fragment="convertObjectToGSTimestamp", fragment="setString") {
    static bool convertObjectToFieldKey(griddb::Field &field, swig_interface *map, GSType type) {
        switch (type) {
        case GS_TYPE_STRING:
            if (map->type == GS_TYPE_STRING) {
                if (map->asString.n == 0) {
                    field.value.asString = strdup("\0");
                    if (field.value.asString == NULL) {
                        SWIG_exception(SWIG_ValueError, "allocate for null string field failed");
                    }
                } else {
                    field.value.asString = setString(map->asString.p, map->asString.n);
                }
            } else {
                return false;
            }
            field.type = GS_TYPE_STRING;
            return true;
        case GS_TYPE_INTEGER:
            if (map->type == GS_TYPE_INTEGER) {
                field.value.asInteger = map->asInteger;
            } else if (map->type == GS_TYPE_BYTE) {
                field.value.asInteger = map->asByte;
            } else if (map->type == GS_TYPE_SHORT) {
                field.value.asInteger = map->asShort;
            } else {
                return false;
            }
            field.type = GS_TYPE_INTEGER;
            return true;
        case GS_TYPE_LONG:
            if (map->type == GS_TYPE_LONG) {
                field.value.asLong = map->asLong;
            } else if (map->type == GS_TYPE_INTEGER) {
                field.value.asLong = map->asInteger;
            } else if (map->type == GS_TYPE_BYTE) {
                field.value.asLong = map->asByte;
            } else if (map->type == GS_TYPE_SHORT) {
                field.value.asLong = map->asShort;
            } else {
                return false;
            }
            field.type = GS_TYPE_LONG;
            return true;
        case GS_TYPE_TIMESTAMP:
            field.type = GS_TYPE_TIMESTAMP;
            return convertObjectToGSTimestamp(map, &field.value.asTimestamp);
        default:
            return false;
        }
        return true;
    }
}
//fragment to create data for string with end null character
%fragment("setString", "header") {
static GSChar* setString(GSChar* src, int size) {
    GSChar* des;
    if(src == NULL || size < 1) {
        return NULL;
    }
    des = (GSChar *)malloc(size + 1);
    if (des == NULL) {
        SWIG_exception(SWIG_ValueError, "can not allocate memory for setString");
    }
    memset(des, 0x0, size + 1);
    memcpy(des, src, size);
    return des;
}
}
//fragment to set data for fields in row
%fragment("setRowFromObject", "header", fragment = "cinterface", fragment="setString") {
    static bool setRowFromObjectWithString(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        GSChar* stringVal;
        if (map->type == GS_TYPE_STRING) {
            if (map->asString.n == 0) {
                stringVal = strdup("\0");
                if (stringVal == NULL) {
                    SWIG_exception(SWIG_ValueError, "allocate for null string field failed");
                }
            } else {
                stringVal = setString(map->asString.p, map->asString.n);
            }
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for string");
        }
        ret = gsSetRowFieldByString(row, no, stringVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set string value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithBool(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        GSBool boolVal;
        if (map->type == GS_TYPE_BOOL) {
            boolVal = map->asBool;
        } else if(map->type == GS_TYPE_LONG) {
            boolVal = (map->asLong) ? true : false;
        } else if (map->type == GS_TYPE_BYTE) {
            boolVal = (map->asByte) ? true : false;
        } else if (map->type == GS_TYPE_SHORT) {
            boolVal = (map->asShort) ? true : false;
        } else if(map->type == GS_TYPE_INTEGER) {
            boolVal = (map->asInteger) ? true : false;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for bool");
        }
        ret = gsSetRowFieldByBool(row, no, boolVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set bool value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithByte(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        int8_t byteVal;
        if (map->type == GS_TYPE_BYTE) {
            byteVal = map->asByte;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for byte");
        }
        ret = gsSetRowFieldByByte(row, no, byteVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set byte value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithShort(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        int16_t shortVal;
        if (map->type == GS_TYPE_BYTE) {
            shortVal = map->asByte;
        } else if (map->type == GS_TYPE_SHORT) {
            shortVal = map->asShort;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for short");
        }
        ret = gsSetRowFieldByShort(row, no, shortVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set short value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithInteger(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        int32_t intVal;
        if (map->type == GS_TYPE_BYTE) {
            intVal = map->asByte;
        } else if (map->type == GS_TYPE_SHORT) {
            intVal = map->asShort;
        } else if (map->type == GS_TYPE_INTEGER) {
            intVal = map->asInteger;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for integer");
        }
        ret = gsSetRowFieldByInteger(row, no, intVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set integer value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithLong(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        int64_t longVal;
        if (map->type == GS_TYPE_BYTE) {
            longVal = map->asByte;
        } else if (map->type == GS_TYPE_SHORT) {
            longVal = map->asShort;
        } else if (map->type == GS_TYPE_INTEGER) {
            longVal = map->asInteger;
        } else if (map->type == GS_TYPE_LONG) {
            longVal = map->asLong;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for long");
        }
        ret = gsSetRowFieldByLong(row, no, longVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set long value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithFloat(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        float floatVal;
        if (map->type == GS_TYPE_BYTE) {
            floatVal = map->asByte;
        } else if (map->type == GS_TYPE_SHORT) {
            floatVal = map->asShort;
        } else if (map->type == GS_TYPE_INTEGER) {
            floatVal = map->asInteger;
        } else if (map->type == GS_TYPE_LONG) {
            floatVal = map->asLong;
        } else if (map->type == GS_TYPE_FLOAT) {
            floatVal = map->asFloat;
        } else if (map->type == GS_TYPE_DOUBLE) {
            if (!(map->asDouble < (- std::numeric_limits<float>::max())) &&
                !(map->asDouble > std::numeric_limits<float>::max())) {
                floatVal = static_cast<float>(map->asDouble);
            } else {
                SWIG_exception(SWIG_ValueError, "float input is out of range");
            }
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for float");
        }
        ret = gsSetRowFieldByFloat(row, no, floatVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set float value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithDouble(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        double doubleVal;
        if (map->type == GS_TYPE_BYTE) {
            doubleVal = map->asByte;
        } else if (map->type == GS_TYPE_SHORT) {
            doubleVal = map->asShort;
        } else if (map->type == GS_TYPE_INTEGER) {
            doubleVal = map->asInteger;
        } else if (map->type == GS_TYPE_LONG) {
            doubleVal = map->asLong;
        } else if (map->type == GS_TYPE_FLOAT) {
            doubleVal = map->asFloat;
        } else if(map->type == GS_TYPE_DOUBLE) {
            doubleVal = map->asDouble;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for double");
        }
        ret = gsSetRowFieldByDouble(row, no, doubleVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set float value for row");
        }
        return true;
    }
    // input for timestamp is: string/byte/short/integer/float
    static bool setRowFromObjectWithTimestamp(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        GSTimestamp timestampVal;
        switch(map->type) {
            case GS_TYPE_STRING: {
                GSChar *s = (GSChar *)malloc(sizeof(GSChar) * map->asString.n + 1);
                if (s == NULL) {
                    SWIG_exception(SWIG_ValueError, "Can not allocate for timestamp string");
                }
                memset(s, 0, sizeof(GSChar) * map->asString.n + 1);
                memcpy(s, map->asString.p, map->asString.n);
                if (gsParseTime(s, &timestampVal) == GS_FALSE) {
                    SWIG_exception(SWIG_ValueError, "gsParseTime for row failed!");
                }
                free((void *)s);
                break;
            }
            case GS_TYPE_BYTE: {
                timestampVal = map->asByte *1000;
                break;
            }
            case GS_TYPE_SHORT: {
                timestampVal = map->asShort *1000;
                break;
            }
            case GS_TYPE_INTEGER: {
                timestampVal = map->asInteger *1000;
                break;
            }
            case GS_TYPE_LONG: {
                if (map->asLong > UTC_TIMESTAMP_MAX) {
                    SWIG_exception(SWIG_ValueError, "long to set for timestamp is out of range");
                }
                timestampVal = map->asLong *1000;
                break;
            }
            case GS_TYPE_FLOAT: {
                if (map->asFloat > UTC_TIMESTAMP_MAX) {
                    SWIG_exception(SWIG_ValueError, "float to set for timestamp is out of range");
                }
                timestampVal = static_cast<int64_t>(map->asFloat *1000);
                break;
            }
            case GS_TYPE_DOUBLE: {
                if (map->asDouble > UTC_TIMESTAMP_MAX) {
                    SWIG_exception(SWIG_ValueError, "double to set for timestamp is out of range");
                }
                timestampVal = static_cast<int64_t>(map->asDouble *1000);
                break;
            }
            case GS_TYPE_TIMESTAMP: {
                timestampVal = map->asTimestamp;
                break;
            }
            default:
                SWIG_exception(SWIG_ValueError, "incorrect column type to set for timestamp");
        }
        ret = gsSetRowFieldByTimestamp(row, no, timestampVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set timestamp value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithGeometry(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        GSChar* geometryVal;
        if (map->type == GS_TYPE_STRING) {
            geometryVal = setString(map->asString.p, map->asString.n);
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for geometry");
        }
        ret = gsSetRowFieldByGeometry(row, no, geometryVal);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set geometry value for row");
        }
        return true;
    }
    static bool setRowFromObjectWithBlob(GSRow *row, swig_interface *map, int no) {
        GSResult ret;
        GSBlob blobValTmp;
        if (map->type == GS_TYPE_STRING) {
            blobValTmp.size = map->asString.n;
            void *tmp = malloc(sizeof(GSChar) * blobValTmp.size);
            if (tmp == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for blob for setRowFromObjectWithBlob failed");
            }
            memcpy(tmp, map->asString.p, blobValTmp.size);
            blobValTmp.data = (const void*)tmp;
        } else if (map->type == GS_TYPE_BLOB) {
            blobValTmp.size = map->asBlob.len;
            void *tmp = malloc(sizeof(GSChar) * blobValTmp.size);
            if (tmp == NULL) {
                SWIG_exception(SWIG_ValueError, "allocate memory for blob for setRowFromObjectWithBlob failed");
            }
            memcpy(tmp, map->asBlob.array, blobValTmp.size);
            blobValTmp.data = (const void*)tmp;
        } else {
            SWIG_exception(SWIG_ValueError, "incorrect column type to set for bolb");
        }
        ret = gsSetRowFieldByBlob(row, no, &blobValTmp);
        if (ret != GS_RESULT_OK) {
            SWIG_exception(SWIG_ValueError, "Can not set blob value for row");
        }
        return true;
    }
    static bool setRowFromObject(GSRow *row, swig_interface *map, GSType type, int no) {
        if (type >= GS_TYPE_NULL &&
            type <= GS_TYPE_TIMESTAMP_ARRAY &&
            map->type == GS_TYPE_NULL) {
%#if GS_COMPATIBILITY_SUPPORT_3_5
            GSResult ret = gsSetRowFieldNull(row, no);
            if (ret != GS_RESULT_OK) {
                SWIG_exception(SWIG_ValueError, "Can not set null value for row field");
            }
            return true;
%#else
            //Not support NULL
            return false;
%#endif
        }

        switch (type) {
        case GS_TYPE_STRING:
            setRowFromObjectWithString(row, map, no);
            break;
        case GS_TYPE_BOOL:
            setRowFromObjectWithBool(row, map, no);
            break;
        case GS_TYPE_BYTE:
            setRowFromObjectWithByte(row, map, no);
            break;
        case GS_TYPE_SHORT:
            setRowFromObjectWithShort(row, map, no);
            break;
        case GS_TYPE_INTEGER:
            setRowFromObjectWithInteger(row, map, no);
            break;
        case GS_TYPE_LONG:
            setRowFromObjectWithLong(row, map, no);
            break;
        case GS_TYPE_FLOAT:
            setRowFromObjectWithFloat(row, map, no);
            break;
        case GS_TYPE_DOUBLE:
            setRowFromObjectWithDouble(row, map, no);
            break;
        case GS_TYPE_TIMESTAMP:
            setRowFromObjectWithTimestamp(row, map, no);
            break;
        case GS_TYPE_GEOMETRY:
            setRowFromObjectWithGeometry(row, map, no);
            break;
        case GS_TYPE_BLOB:
            setRowFromObjectWithBlob(row, map, no);
            break;
        case GS_TYPE_STRING_ARRAY:
        case GS_TYPE_BOOL_ARRAY:
        case GS_TYPE_BYTE_ARRAY:
        case GS_TYPE_SHORT_ARRAY:
        case GS_TYPE_INTEGER_ARRAY:
        case GS_TYPE_LONG_ARRAY:
        case GS_TYPE_FLOAT_ARRAY:
        case GS_TYPE_DOUBLE_ARRAY:
        case GS_TYPE_TIMESTAMP_ARRAY:
            SWIG_exception(SWIG_ValueError, "Go do not support array type yet");
            break;
        case GS_TYPE_NULL:
            SWIG_exception(SWIG_ValueError, "detect type from container is GS_TYPE_NULL but not support");
            break;
        default:
            SWIG_exception(SWIG_ValueError, "can not detect type from container successfully");
            break;
        }
        return true;
    }
}
/**
* Typemaps for StoreFactory.set_properties() function
*/
%typemap(gotype) (const GSPropertyEntry* props, int propsCount) %{map[string]string%}
%typemap(imtype) (const GSPropertyEntry* props, int propsCount) %{[]swig_mapstringstring%}

%typemap(goin, fragment="gostringstring") (const GSPropertyEntry* props, int propsCount) %{
    $result = make([]swig_mapstringstring, len($input), len($input))
    i := 0
    for key, value := range $input {
        $result[i].key = key
        $result[i].value = value
        i++
    }
%}
%typemap(in, fragment="cstringstring") (const GSPropertyEntry* props, int propsCount) %{
    swig_mapstringstring *prop_map = (swig_mapstringstring *)$input.array;
    $2 = $input.len;
    if($2 > 0){
        $1 = (GSPropertyEntry*) malloc($2 * sizeof(GSPropertyEntry));
        if($1 == NULL){
            SWIG_exception(SWIG_ValueError, "allocate memory for GSPropertyEntry failed");
        }
        for(int i = 0; i < $2; i++){
            $1[i].name = setString(prop_map[i].key.p, prop_map[i].key.n);
            $1[i].value = setString(prop_map[i].value.p, prop_map[i].value.n);
        }
    }
%}
%typemap(freearg) (const GSPropertyEntry* props, int propsCount) {
    if ($1) {
        for(int i = 0; i < $2; i++){
            if($1[i].name) {
                free((void *) $1[i].name);
            }
            if($1[i].value) {
                free((void *) $1[i].value);
            }
        }
        free((void *) $1);
    }
}

/**
* Typemaps for ContainerInfo's constructor
*/
%typemap(gotype) (const GSColumnInfo* props, int propsCount) %{[][]interface{}%}
%typemap(imtype) (const GSColumnInfo* props, int propsCount) %{[]uintptr%}
%go_import("fmt")
%typemap(goin, fragment="gostringintint") (const GSColumnInfo* props, int propsCount) %{
    tmpArr := make([]swig_stringintint, len($input), len($input))
    $result = make([]uintptr, 1, 1)
    for i := range $input {
        tmpArr[i].columnName = $input[i][0].(string)
        tmpArr[i].mType      = $input[i][1].(int)
        if (len($input[i]) >= 3) {
            tmpArr[i].options = $input[i][2].(int)
        } else {
            tmpArr[i].options = TYPE_NULL
        }
    }
    $result[0] = (uintptr)(unsafe.Pointer(&tmpArr))
%}
%typemap(in, fragment="cstringintint") (const GSColumnInfo* props, int propsCount)
(swig_stringintint *map, GSChar *tmpStr, uintptr_t *data, _goslice_ *tmpSlice) %{
    data = (uintptr_t*)$input.array;
    tmpSlice = (_goslice_*)data[0];
    map = (swig_stringintint *)tmpSlice->array;
    $2 = tmpSlice->len;
    if($2 <= 0) {
        SWIG_exception(SWIG_ValueError, "err schema for GSColumnInfo no column");
    }
    $1 = (GSColumnInfo *) malloc($2 * sizeof(GSColumnInfo));
    if ($1 == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for GSColumnInfo failed");
    }
    memset($1, 0x0, $2 * sizeof(GSColumnInfo));
    for(int i = 0; i < $2; i++) {
        $1[i].name = setString(map[i].columnName.p, map[i].columnName.n);
        $1[i].type = (int32_t) map[i].mType;
#if GS_COMPATIBILITY_SUPPORT_3_5
        if ((int32_t) map[i].options > 0) {
            $1[i].options = (int32_t) map[i].options;
        }
#endif
    }
%}
%typemap(freearg) (const GSColumnInfo* props, int propsCount) %{
    if($1) {
        for(int i = 0; i < $2; i++) {
            if($1[i].name) {
                free((void *) $1[i].name);
            }
        }
        free((void *) $1);
    }
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
    griddb::Query **queries = *(griddb::Query ***)(&$input.array);
    $2 = $input.len;
    $1 = NULL;
    if($2 > 0) {
        $1 = (GSQuery**) malloc($2*sizeof(GSQuery*));
        if($1 == NULL) {
            SWIG_exception(SWIG_ValueError, "allocate memory for GSQuery array failed");
            return;
        }

        for(int i = 0; i < $2; i++) {
            $1[i] = queries[i]->gs_ptr();
        }
    }
%}
%typemap(freearg) (GSQuery* const* queryList, size_t queryCount) {
    if($1) {
        free((void *) $1);
    }
}

/*
 * typemap for AggregationResult.get function in AggregationResult class
 */
%typemap(in, numinputs = 1) (griddb::Field *agValue) (griddb::Field tmpAgValue) %{
    $1 = &tmpAgValue;
%}
%typemap(gotype) (griddb::Field *agValue) %{*interface{}%}
%typemap(imtype) (griddb::Field *agValue) %{*[]swig_interface%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Field *agValue) %{
    $input->len = 1;
    $input->cap = 1;
    swig_interface *tmp = (swig_interface *)malloc(sizeof(swig_interface));
    if (tmp == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for AggregationResult.get failed");
    }
    memset(tmp, 0x0, $input->len * sizeof(swig_interface));
    convertFieldToObject(tmp, &($1->value), $1->type, arg1->timestamp_output_with_float);
    $input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (griddb::Field *agValue) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    var tmp interface{}
    GoDataTOInterface(&slice[0], &tmp)
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
    *$input = tmp
%}

/**
* Typemaps for Container.put_row() function
*/
%typemap(gotype) (GSRow *rowContainer) %{[]interface{}%}
%typemap(imtype) (GSRow *rowContainer) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (GSRow *rowContainer) %{
    tmpArr := make([]swig_interface, len($input), len($input))
    $result = make([]uintptr, 1)
    for i := range $input {
        GoDataFromInterface(&tmpArr[i], &$input[i])
    }
    $result[0] = (uintptr)(unsafe.Pointer(&tmpArr))
%}
%typemap(in, fragment="cinterface", fragment="setRowFromObject") (GSRow *rowContainer)
(int i, int colNum, GSType* typeList, GSRow *tmpRow, swig_interface *map, uintptr_t *tmpData, _goslice_* tmpSlice) %{
    tmpData = (uintptr_t *)($input.array);
    tmpSlice = (_goslice_*)(tmpData[0]);
    map = (swig_interface *)tmpSlice->array;
    tmpRow = arg1->getGSRowPtr();
    typeList = arg1->getGSTypeList();
    colNum = arg1->getColumnCount();
    if (colNum != tmpSlice->len) {
        SWIG_exception(SWIG_ValueError, "column number for put row is not correct");
    }
    for (i = 0; i < colNum; i++) {
        setRowFromObject(tmpRow, &map[i], typeList[i], i);
    }
%}

/**
* Typemaps for RowSet.update() function
*/
%typemap(gotype) (GSRow* row) %{[]interface{}%}
%typemap(imtype) (GSRow* row) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (GSRow* row) %{
    tmpArr := make([]swig_interface, len($input), len($input))
    $result = make([]uintptr, 1)
    for i := range $input {
        GoDataFromInterface(&tmpArr[i], &$input[i])
    }
    $result[0] = (uintptr)(unsafe.Pointer(&tmpArr))
%}
%typemap(in, fragment="cinterface", fragment="setRowFromObject") (GSRow* row)
(int i, int colNum, GSType* typeList, GSRow *tmpRow, swig_interface *map, uintptr_t *tmpData, _goslice_ *tmpSlice) %{
    tmpData = (uintptr_t *)$input.array;
    tmpSlice = (_goslice_ *)tmpData[0];
    map = (swig_interface *)tmpSlice->array;
    tmpRow = arg1->getGSRowPtr();
    typeList = arg1->getGSTypeList();
    colNum = arg1->getColumnCount();
    if (colNum != tmpSlice->len) {
        SWIG_exception(SWIG_ValueError, "column number for update row is not correct");
    }
    for (i = 0; i < colNum; i++) {
        setRowFromObject(tmpRow, &map[i], typeList[i], i);
    }
%}

/**
* Typemaps for Container.multi_put() function
*/
%typemap(gotype) (GSRow** listRowdata) %{[][]interface{}%}
%typemap(imtype) (GSRow** listRowdata) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (GSRow** listRowdata) %{
    if ($input == nil) {
        panic("wrong input is nil\n")
    }
    tmp := make([][]swig_interface, len($input))
    $result = make([]uintptr, len($input))
    for i := range $input {
        tmpSize := len($input[i])
        tmp[i] = make([]swig_interface, tmpSize)
        for j := range tmp[i] {
            GoDataFromInterface(&tmp[i][j], &$input[i][j])
        }
        $result[i] = (uintptr)(unsafe.Pointer(&tmp[i]))
    }
%}
%typemap(in, fragment="cinterface", fragment="setRowFromObject") (GSRow** listRowdata, int rowCount)
(int i, int j, int colNum, GSType* typeList, GSRow **tmpListRow, GSContainer *mContainer,
swig_interface *tmpMap, uintptr_t *tmpData, _goslice_ *tmpSlice) %{
    tmpData = (uintptr_t *)($input.array);
    $2 = $input.len;
    if ($2 == 0) {
        $1 = NULL;
    } else {
        tmpListRow = new GSRow*[$2];
        mContainer = arg1->getGSContainerPtr();
        colNum = arg1->getColumnCount();
        typeList = arg1->getGSTypeList();
        for(i = 0; i < $2; i++) {
            GSResult ret = gsCreateRowByContainer(mContainer, &tmpListRow[i]);
            if (ret != GS_RESULT_OK) {
                for (int n = 0; n < i; n++) {
                    gsCloseRow(&tmpListRow[n]);
                }
                delete tmpListRow;
                SWIG_exception(SWIG_ValueError, "gsCreateRowByContainer failed");
            }
            tmpSlice = (_goslice_ *)tmpData[i];
            tmpMap = (swig_interface*)tmpSlice->array;
            if (colNum != tmpSlice->len) {
                SWIG_exception(SWIG_ValueError, "column number for container multi put row is not correct");
            }
            for(j = 0; j < colNum; j++) {
                setRowFromObject(tmpListRow[i], &tmpMap[j], typeList[j], j);
            }
        }
        $1 = tmpListRow;
    }
%}
%typemap(freearg) (GSRow** listRowdata, int rowCount) {
    if($1) {
        for (int rowNum = 0; rowNum < $2; rowNum++) {
            gsCloseRow(&$1[rowNum]);
        }
        delete $1;
    }
}

/*
* typemap for Container.get_row
*/
// Convert data for input
%typemap(gotype) (griddb::Field* keyFields) %{interface{}%}
%typemap(imtype) (griddb::Field* keyFields) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (griddb::Field* keyFields) %{
    tmpArr := make([]swig_interface, 1, 1)
    $result = make([]uintptr, 1, 1)
    GoDataFromInterface(&tmpArr[0], &$input)
    $result[0] = (uintptr)(unsafe.Pointer(&tmpArr))
%}
%typemap(in, fragment="cinterface", fragment = "convertObjectToFieldKey") (griddb::Field* keyFields)
(griddb::Field tmpField, swig_interface *map, uintptr_t *tmpData, _goslice_ *tmpSlice) %{
    tmpData = (uintptr_t *)($input.array);
    tmpSlice = (_goslice_ *)(*tmpData);
    map = (swig_interface *)tmpSlice->array;
    GSType* typeList = arg1->getGSTypeList();
    if(!convertObjectToFieldKey(tmpField, &map[0], typeList[0])) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for Container get row");
    }
    $1 = &tmpField;
%}
// Convert data for output
%typemap(in, numinputs = 1) (GSRow *rowdata) %{
    $1 = NULL;
%}
%typemap(gotype) (GSRow *rowdata) %{*[]interface{}%}
%typemap(imtype) (GSRow *rowdata) %{*[]swig_interface%}
%typemap(argout, fragment="convertGSRowToObject") (GSRow *rowdata)
(int i, GSRow *tmpRow, swig_interface *tmp, GSType *mType) %{
    if ($result == true) {
        $input->len = arg1->getColumnCount();
        $input->cap = arg1->getColumnCount();
        tmpRow = arg1->getGSRowPtr();
        tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
        if (tmp == NULL) {
            SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for get_row failed");
        }
        memset(tmp, 0x0, $input->len * sizeof(swig_interface));
        mType = arg1->getGSTypeList();
        for(i = 0; i < $input->len; i++) {
            convertGSRowToObject(&tmp[i], tmpRow, mType[i], i, arg1->timestamp_output_with_float);
        }
        $input->array = tmp;
    }
%}
%typemap(goargout, fragment="gointerface") (GSRow *rowdata) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterface(&slice[i], &tmp[i])
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
    *$input = tmp
%}

/*
* typemap for RowSet.next_row function
*/
%typemap(in, numinputs = 1) (bool* hasNextRow) (bool tmpHasNextRow) %{
    $1 = &tmpHasNextRow;
%}
%typemap(gotype) (bool* hasNextRow) %{*[]interface{}%}
%typemap(imtype) (bool* hasNextRow) %{*[]swig_interface%}
%typemap(argout, fragment="convertGSRowToObject") (bool* hasNextRow)
(int i, GSRow *tmpRow, swig_interface *tmp, GSType *mType) %{
    if (*$1) {
        $input->len = arg1->getColumnCount();
        $input->cap = arg1->getColumnCount();
        tmpRow = arg1->getGSRowPtr();
        tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
        if (tmp == NULL) {
            SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for next_row failed");
        }
        memset(tmp, 0x0, $input->len * sizeof(swig_interface));
        mType = arg1->getGSTypeList();
        for(i = 0; i < $input->len; i++) {
            convertGSRowToObject(&tmp[i], tmpRow, mType[i], i, arg1->timestamp_output_with_float);
        }
        $input->array = tmp;
    }
%}
%typemap(goargout, fragment="gointerface") (bool* hasNextRow) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterface(&slice[i], &tmp[i])
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
    *$input = tmp
%}
/*
* typemap for Store.multi_put function
*/
%typemap(gotype) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{map[string][][]interface{}%}
%typemap(imtype) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{[]uintptr%}
%typemap(goin, fragment="gointerface", fragment="goContainerListRow") (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) %{
    tmp := make([]swig_ContainerListRow, len($input))
    $result = make([]uintptr, len($input))
    i := 0
    for contanierName := range $input {
        if ($input[contanierName] == nil || len($input[contanierName]) == 0) {
            panic("wrong list row input is nil\n")
        }
        tmp[i].containerName = contanierName
        tmp[i].list_size = len($input[contanierName])
        tmp[i].listRow = make([][]swig_interface, tmp[i].list_size)
        for j := range $input[contanierName] {
            tmp[i].listRow[j] = make([]swig_interface, len($input[contanierName][j]))
            for k := range $input[contanierName][j] {
                GoDataFromInterface(&tmp[i].listRow[j][k], &$input[contanierName][j][k])
            }
        }
        $result[i] = (uintptr)(unsafe.Pointer(&tmp[i]))
        i = i +1
    }
%}
%typemap(in, numinputs = 1, fragment="cinterface", fragment="setRowFromObject", fragment= "cContainerListRow")
(GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
(swig_ContainerListRow *tmpInput, uintptr_t *tmpData,swig_interface *tmpMap,
griddb::Container* tmpContainer, int colNum, GSType* typeList,
_goslice_ *tmpSlice , int conNum, int i, int j) %{
    tmpData = (uintptr_t *)($input.array);
    $4 = $input.len;
    if ($4 == 0) {
        $1 = NULL;
        $2 = NULL;
        $3 = NULL;
    } else {
        $1 = new GSRow**[$4];
        $2 = new int [$4];
        $3 = new GSChar*[$4];
        // set data for each container
        for (conNum = 0; conNum < $4; conNum++) {
            tmpInput = (swig_ContainerListRow *)tmpData[conNum];
            $2[conNum]    = tmpInput->list_size;
            $3[conNum]    = setString(tmpInput->containerName.p, tmpInput->containerName.n);
            if ($2[conNum] == 0) {
                $1[conNum] = NULL;
            } else {
                $1[conNum] = new GSRow* [$2[conNum]];
                tmpContainer = arg1->get_container($3[conNum]);
                typeList = tmpContainer->getGSTypeList();
                colNum = tmpContainer->getColumnCount();
                // set data for each row
                for(i = 0; i < $2[conNum]; i++) {
                    GSResult ret = gsCreateRowByContainer(tmpContainer->getGSContainerPtr(), &$1[conNum][i]);
                    if (ret != GS_RESULT_OK) {
                        for (int n = 0; n < i; n++) {
                            gsCloseRow(&$1[conNum][n]);
                        }
                        for (int n = 0; n <= conNum; n++) {
                            delete $1[n];
                        }
                        delete $1;
                        delete $2;
                        delete $3;
                        SWIG_exception(SWIG_ValueError, "gsCreateRowByContainer failed");
                    }
                    tmpSlice  = (_goslice_ *)tmpInput->listRow.array;
                    tmpMap    = (swig_interface *)tmpSlice[i].array;
                    if (colNum != tmpSlice[i].len) {
                        SWIG_exception(SWIG_ValueError, "column number for store multi put row is not correct");
                    };
                    // set data for each field of row
                    for(j = 0; j < colNum; j++) {
                        setRowFromObject($1[conNum][i], &tmpMap[j], typeList[j], j);
                    }
                }
                // delete container after setting data for list of row
                delete tmpContainer;
            }
        }
    }
%}
%typemap(freearg) (GSRow*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) {
    for(int i = 0; i < $4; i++) {
        if($1[i]) {
            for(int j = 0; j < $2[i]; j++) {
                gsCloseRow(&$1[i][j]);
            }
            delete $1[i];
        }
        if($3) {
            if($3[i]) {
                free($3[i]);
            }
        }
    }
    if($1) delete $1;
    if($2) delete $2;
    if($3) delete $3;
}

/*
* typemap for Store.multi_get function
*/
//input for Store.multi_get() function
%typemap(gotype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{map[string]RowKeyPredicate%}
%typemap(imtype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{[]uintptr%}
%typemap(goin, fragment= "gostringrowkeypredicate") (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{
    tmpList := make([]swig_mapstringrowkeypredicate, len($input), len($input))
    $result = make([]uintptr, 1, 1)
    i := 0
    for containerName := range $input {
        tmpList[i].containerName = containerName
        tmpList[i].rowKeyPredicate = $input[containerName].Swigcptr()
        i ++
    }
    $result[0] = (uintptr)(unsafe.Pointer(&tmpList))
%}
%typemap(in, fragment= "cstringrowkeypredicate") (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount)
(swig_mapstringrowkeypredicate *mapper, GSRowKeyPredicateEntry *tmpEntry, GSChar *tmpStr, _goslice_ *tmpSlice, uintptr_t *tmpData)%{
    tmpData = (uintptr_t *)$input.array;
    tmpSlice = (_goslice_ *)tmpData[0];
    mapper = (swig_mapstringrowkeypredicate *) tmpSlice->array;
    $2 = tmpSlice->len;
    $1 = NULL;
    if($2 > 0) {
        tmpEntry = new GSRowKeyPredicateEntry[$2];
        // set data for each element of entry array
        for(int i = 0; i < $2; i++) {
            tmpEntry[i].containerName = setString(mapper[i].containerName.p, mapper[i].containerName.n);
            tmpEntry[i].predicate = (GSRowKeyPredicate *)mapper[i].rowKeyPredicate->gs_ptr();
        }
        $1 = &tmpEntry;
    }
%}
%typemap(freearg) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) {
    if(*$1) {
        for(int i = 0; i < $2; i++) {
            if((*$1)[i].containerName) {
                free((void *) (*$1)[i].containerName);
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
int **colNumList, GSType*** typeList, int **orderFromInput)%{*map[string][][]interface{}%}
%typemap(imtype) (GSContainerRowEntry **entryList, size_t* containerCount,
int **colNumList, GSType*** typeList, int **orderFromInput)%{*[]swig_ContainerListRow%}
%typemap(argout, fragment="convertGSRowToObject", fragment="cContainerListRow")
(GSContainerRowEntry **entryList, size_t* containerCount, int **colNumList, GSType*** typeList, int **orderFromInput)
(int i, int j, int k, swig_ContainerListRow *tmpEntry, GSChar *tmpStr, swig_interface* tmpMap,
GSRow *tmpRow, GSContainerRowEntry *tmpEntryList) %{
    $input->len = *$2;
    $input->cap = *$2;
    tmpEntry = (swig_ContainerListRow *)malloc($input->len * sizeof(swig_ContainerListRow));
    if (tmpEntry == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_ContainerListRow for multi_get failed");
    }
    memset(tmpEntry, 0x0, $input->len * sizeof(swig_ContainerListRow));
    //set for each container
    for(i = 0; i < $input->len; i++) {
        // set containerName
        tmpEntryList = &((*$1)[((*$5)[i])]);
        tmpEntry[i].containerName.n = strlen(tmpEntryList->containerName);
        tmpStr = (GSChar *)malloc(sizeof(GSChar) * tmpEntry[i].containerName.n + 1);
        if (tmpStr == NULL) {
            SWIG_exception(SWIG_ValueError, "allocate memory for container name for multi_get failed");
        }
        memset(tmpStr, 0x0, sizeof(GSChar) * tmpEntry[i].containerName.n + 1);
        memcpy(tmpStr,  tmpEntryList->containerName, tmpEntry[i].containerName.n);
        tmpEntry[i].containerName.p = tmpStr;
        // set data for each row
        tmpEntry[i].list_size = tmpEntryList->rowCount;
        tmpEntry[i].listRow.len = tmpEntry[i].list_size;
        tmpEntry[i].listRow.cap = tmpEntry[i].list_size;
        tmpEntry[i].listRow.array = (void *)new _goslice_[tmpEntry[i].list_size];
        for(j = 0; j < tmpEntry[i].list_size; j++) {
            ((_goslice_*)tmpEntry[i].listRow.array)[j].len  = (*$3)[i];
            ((_goslice_*)tmpEntry[i].listRow.array)[j].cap  = (*$3)[i];
            ((_goslice_*)tmpEntry[i].listRow.array)[j].array = (void *) new swig_interface[(*$3)[i]];
            tmpMap = (swig_interface*) ((_goslice_*)tmpEntry[i].listRow.array)[j].array;
            // set data for output
            tmpRow = (GSRow*)(tmpEntryList->rowList[j]);
            for(k = 0; k < (*$3)[i]; k++) {
                convertGSRowToObject(&tmpMap[k], tmpRow, (*$4)[i][k], k, arg1->timestamp_output_with_float);
            }
        }
    }
    if (*$4) {
        for (int j = 0; j < *$2;j++) {
            if ((*$4)[j]) {
                free ((void*) (*$4)[j]);
            }
        }
        delete (*$4);
    }
    delete (*$3);
    delete (*$5);
    $input->array = (void *)tmpEntry;
%}
%typemap(goargout, fragment="gointerface", fragment="goContainerListRow") (GSContainerRowEntry **entryList,
size_t* containerCount, int **colNumList, GSType*** typeList, int **orderFromInput) %{
    slice := *(*[]swig_ContainerListRow)(unsafe.Pointer($1))
    tmp := make(map[string][][]interface{})
    for i := range slice {
        tmpListRow := make([][]interface{}, slice[i].list_size)
        for j := range tmpListRow {
            tmpRow       := slice[i].listRow[j]
            tmpListRow[j] = make([]interface{}, len(tmpRow))
            for n := range tmpListRow[j] {
                GoDataTOInterface(&tmpRow[n], &tmpListRow[j][n])
            }
            tmpRow1 := *(*C._goslice_)(unsafe.Pointer(&slice[i].listRow[j]))
            Swig_free(uintptr(unsafe.Pointer(tmpRow1.array)))
        }
        tmp[slice[i].containerName] = tmpListRow

        tmpListRow1 := *(*C._goslice_)(unsafe.Pointer(&slice[i].listRow))
        Swig_free(uintptr(unsafe.Pointer(tmpListRow1.array)))
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)))
    *$input = tmp

%}

/**
 * Typemap for QueryAnalysisEntry.get()
 */
%typemap(gotype) (GSQueryAnalysisEntry* queryAnalysis) %{*[]interface{}%}
%typemap(imtype) (GSQueryAnalysisEntry* queryAnalysis) %{*[]swig_interface%}
%typemap(in, numinputs = 1) (GSQueryAnalysisEntry* queryAnalysis) (GSQueryAnalysisEntry queryAnalysis1) {
    $1 = &queryAnalysis1;
}
%typemap(argout, fragment="cinterface") (GSQueryAnalysisEntry* queryAnalysis)
(swig_interface *tmp, int num = 6, griddb::Field tmpQueryAnalysis [6]) %{
    // set data for all elements of tmpQueryAnalysis array
    tmpQueryAnalysis[0].type      = GS_TYPE_INTEGER;
    tmpQueryAnalysis[0].value.asInteger = $1->id;
    tmpQueryAnalysis[1].type      = GS_TYPE_INTEGER;
    tmpQueryAnalysis[1].value.asInteger = $1->depth;
    tmpQueryAnalysis[2].type      = GS_TYPE_STRING;
    tmpQueryAnalysis[2].value.asString = $1->type;
    tmpQueryAnalysis[3].type      = GS_TYPE_STRING;
    tmpQueryAnalysis[3].value.asString = $1->valueType;
    tmpQueryAnalysis[4].type      = GS_TYPE_STRING;
    tmpQueryAnalysis[4].value.asString = $1->value;
    tmpQueryAnalysis[5].type      = GS_TYPE_STRING;
    tmpQueryAnalysis[5].value.asString = $1->statement;
    // set data for output
    $input->len = num;
    $input->cap = num;
    tmp = (swig_interface *)malloc(num * sizeof(swig_interface));
    if (tmp == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for QueryAnalysisEntry.get failed");
    }
    memset(tmp, 0x0, num * sizeof(swig_interface));
    for(int i = 0; i < 6; i++) {
        convertFieldToObject(&tmp[i], &tmpQueryAnalysis[i].value, tmpQueryAnalysis[i].type);
    }
    $input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (GSQueryAnalysisEntry* queryAnalysis) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterface(&slice[i], &tmp[i])
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
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
(GSChar **tmp, griddb::Field tmpQueryAnalysis [6]) %{
    _gostring_ *str = (_gostring_*) malloc(*$2 * sizeof(_gostring_));
    if (str == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for _gostring_ for PartitionController.GetContainerNames failed");
    }
    for(int i = 0; i < *$2; i++) {
        str[i] = Swig_AllocateString((*$1)[i], strlen((*$1)[i]));
    }
    $input->len = *$2;
    $input->cap = *$2;
    $input->array = str;
%}
%typemap(goargout) (const GSChar * const ** stringList, size_t *size) %{
    slice := *(*[]string)(unsafe.Pointer($1))
    tmp := make([]string, len(slice), len(slice))
    for i := range slice {
        tmp[i] = swigCopyString(slice[i])
    }
    //Swig_free(uintptr(unsafe.Pointer(slice.array)));
    *$input = tmp
%}

/**
 * Typemap for RowKeyPredicate.set_range()
*/
%typemap(gotype) (griddb::Field* startKey) %{interface{}%}
%typemap(imtype) (griddb::Field* startKey) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (griddb::Field* startKey) %{
    tmpStart := make([]swig_interface, 1, 1)
    $result = make([]uintptr, 1, 1)
    GoDataFromInterface(&tmpStart[0], &$input)
    $result[0] = (uintptr)(unsafe.Pointer(&tmpStart))
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToFieldKey") (griddb::Field* startKey)
(griddb::Field tmpField, _goslice_ *tmpSlice, swig_interface *map, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)$input.array;
    tmpSlice = (_goslice_ *)tmpData[0];
    map = (swig_interface *)tmpSlice->array;
    GSType typeStartKey = arg1->get_key_type();
    if(!convertObjectToFieldKey(tmpField, &map[0], typeStartKey)) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for RowKeyPredicate set range startKey");
    }
    $1 = &tmpField;
%}
%typemap(gotype) (griddb::Field* finishKey) %{interface{}%}
%typemap(imtype) (griddb::Field* finishKey) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (griddb::Field* finishKey) %{
    tmpFinish := make([]swig_interface, 1, 1)
    $result = make([]uintptr, 1, 1)
    GoDataFromInterface(&tmpFinish[0], &$input)
    $result[0] = (uintptr)(unsafe.Pointer(&tmpFinish))
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToFieldKey") (griddb::Field* finishKey)
(griddb::Field tmpField, _goslice_ *tmpSlice, swig_interface *map, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)$input.array;
    tmpSlice = (_goslice_ *)tmpData[0];
    map = (swig_interface *)tmpSlice->array;
    GSType typeFinishKey = arg1->get_key_type();
    if(!convertObjectToFieldKey(tmpField, &map[0], typeFinishKey)) {
        SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for RowKeyPredicate set range finishKey");
    }
    $1 = &tmpField;
%}

/**
 * Typemaps output for RowKeyPredicate.set_distinct_keys()
*/
%typemap(gotype) (const griddb::Field *keys, size_t keyCount) %{[]interface{}%}
%typemap(imtype) (const griddb::Field *keys, size_t keyCount) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (const griddb::Field *keys, size_t keyCount) %{
    tmp := make([]swig_interface, len($input), len($input))
    $result = make([]uintptr, 1, 1)
    for i := range $input {
        GoDataFromInterface(&tmp[i], &$input[i])
    }
    $result[0] = (uintptr)(unsafe.Pointer(&tmp))
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToFieldKey") (const griddb::Field *keys, size_t keyCount)
(griddb::Field *tmpField, int i, _goslice_ *tmpSlice, swig_interface *map, uintptr_t *tmpData) %{
    tmpData = (uintptr_t *)$input.array;
    tmpSlice = (_goslice_ *)tmpData[0];
    map = (swig_interface *)tmpSlice->array;
    $2 = tmpSlice->len;
    tmpField = new griddb::Field[$2];
    GSType type = arg1->get_key_type();
    for(i = 0; i < $2; i++) {
        if(!(convertObjectToFieldKey(tmpField[i], &map[i], type))) {
            SWIG_exception(SWIG_ValueError, "can not convert interface to field for key for RowKeyPredicate set distinct keys");
        }
    }
    $1 = tmpField;
%}

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
%typemap(imtype) (griddb::Field* startField, griddb::Field* finishField) %{*[]swig_interface%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Field* startField, griddb::Field* finishField)
(swig_interface *tmp) %{
    $input->len = 2;
    $input->cap = 2;
    tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
    if (tmp == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for RowKeyPredicate.get_range failed");
    }
    memset(tmp, 0x0, $input->len * sizeof(swig_interface));
    if ($1->type == GS_TYPE_NULL) {
        tmp[0].type = GS_TYPE_NULL;
    } else {
        convertFieldToObject(&tmp[0], &$1->value, $1->type, arg1->timestamp_output_with_float);
    }
    if ($2->type == GS_TYPE_NULL) {
        tmp[1].type = GS_TYPE_NULL;
    } else {
        convertFieldToObject(&tmp[1], &$2->value, $2->type, arg1->timestamp_output_with_float);
    }
    $input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (griddb::Field* startField, griddb::Field* finishField) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterface(&slice[i], &tmp[i])
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
    *$input = tmp
%}
// typemap for ouput of RowKeyPredicate.get_distinct_keys()
%typemap(in, numinputs=1) (griddb::Field **keys, size_t* keyCount) (griddb::Field *tmpKeys, size_t tmpKeyCount) {
  $1 = &tmpKeys;
  $2 = &tmpKeyCount;
}
%typemap(gotype) (griddb::Field **keys, size_t* keyCount) %{*[]interface{}%}
%typemap(imtype) (griddb::Field **keys, size_t* keyCount) %{*[]swig_interface%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Field **keys, size_t* keyCount) (swig_interface *tmp) %{
    $input->len = *$2;
    $input->cap = *$2;
    tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
    if (tmp == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_interface for RowKeyPredicate.get_distinct_keys failed");
    }
    memset(tmp, 0x0, $input->len * sizeof(swig_interface));
    for(int i = 0; i < $input->len; i++) {
        convertFieldToObject(&tmp[i], &((*$1)[i].value), (*$1)[i].type, arg1->timestamp_output_with_float);
    }
    $input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (griddb::Field **keys, size_t* keyCount) %{
    slice := *(*[]swig_interface)(unsafe.Pointer($1))
    tmp := make([]interface{}, len(slice), len(slice))
    for i := range slice {
        GoDataTOInterface(&slice[i], &tmp[i])
    }
    tmpSlice1 := *(*C._goslice_)(unsafe.Pointer($1))
    Swig_free(uintptr(unsafe.Pointer(tmpSlice1.array)));
    *$input = tmp
%}

/*
 * Typemap for ContainerInfo.set_column_info_list
 */
%typemap(gotype) (ColumnInfoList columnInfoList) %{[][]interface{}%}
%typemap(imtype) (ColumnInfoList columnInfoList) %{[]uintptr%}
%typemap(goin, fragment="gointerface") (ColumnInfoList columnInfoList) %{
    $result = make([]uintptr, len($input))
        for i := range $input {
            tmpSize := len($input[i])
            tmp := make([]swig_interface, tmpSize)
            for j := range $input[i] {
                GoDataFromInterface(&tmp[j], &$input[i][j])
            }
            $result[i] = (uintptr)(unsafe.Pointer(&tmp))
        }
%}
%typemap(in, fragment="cinterface") (ColumnInfoList columnInfoList)
(int length, GSColumnInfo *tmpColumnInfo, int i, swig_interface *tmpMap, _goslice_ *tmpSlice, uintptr_t* tmpData) %{
    $1.size = $input.len;
    tmpData = (uintptr_t *)$input.array;
    tmpColumnInfo = (GSColumnInfo*)malloc(sizeof(GSColumnInfo) * $1.size);
    if (tmpColumnInfo == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for GSColumnInfo for ContainerInfo.set_column_info_list failed");
    }
    for(i = 0; i < $input.len; i++) {
        tmpSlice = (_goslice_ *)tmpData[i];
        tmpMap = (swig_interface *)(tmpSlice->array);
        length = tmpSlice->len;
        if (length < 2) {
            SWIG_exception(SWIG_ValueError, "columnInfoList is not correct");
        }
        tmpColumnInfo[i].name = setString(tmpMap[0].asString.p, tmpMap[0].asString.n);
        if (tmpMap[1].type != GS_TYPE_BYTE) {
            SWIG_exception(SWIG_ValueError, "type is not correct");
        }
        tmpColumnInfo[i].type = tmpMap[1].asByte;
#if GS_COMPATIBILITY_SUPPORT_3_5
        if(length > 2) {
            if (tmpMap[2].type != GS_TYPE_BYTE) {
                SWIG_exception(SWIG_ValueError, "option is not correct");
            }
            tmpColumnInfo[i].options = tmpMap[2].asByte;
        }
#endif
    }
    $1.columnInfo = tmpColumnInfo;
%}
%typemap(freearg) (ColumnInfoList columnInfoList) {
    size_t size = $1.size;
    for (int i =0; i < size; i++) {
        if ($1.columnInfo[i].name) {
            free((void*) $1.columnInfo[i].name);
        }
    }
    if ($1.columnInfo) {
        free ((void *)$1.columnInfo);
    }
}
/*
 * Typemap for ContainerInfo.get_column_info_list
 */
%typemap(gotype) (ColumnInfoList) %{[][]interface{}%}
%typemap(imtype) (ColumnInfoList) %{[]swig_stringintint%}
%typemap(out, fragment="cstringintint") (ColumnInfoList) (swig_stringintint *tmpColumnList) %{
    $result.len = $1.size;
    $result.cap = $1.size;
    tmpColumnList = (swig_stringintint *)malloc(sizeof(swig_stringintint) * $result.len);
    if (tmpColumnList == NULL) {
        SWIG_exception(SWIG_ValueError, "allocate memory for swig_stringintint for ContainerInfo.get_column_info_list failed");
    }
    for(int i = 0; i < $result.len; i++) {
        tmpColumnList[i].columnName.n = strlen($1.columnInfo[i].name);
        GSChar *tmpStr = (GSChar*)malloc(sizeof(GSChar) * tmpColumnList[i].columnName.n + 1);
        if (tmpStr == NULL) {
            SWIG_exception(SWIG_ValueError, "allocate memory for column name for ContainerInfo.get_column_info_list failed");
        }
        memset(tmpStr , 0x0, sizeof(GSChar) * tmpColumnList[i].columnName.n + 1);
        memcpy(tmpStr, $1.columnInfo[i].name, tmpColumnList[i].columnName.n);
        tmpColumnList[i].columnName.p = tmpStr;
        tmpColumnList[i].mType        = $1.columnInfo[i].type;
        tmpColumnList[i].options      = $1.columnInfo[i].options;
    }
    $result.array = tmpColumnList;
%}
%typemap(goout, fragment="gostringintint") (ColumnInfoList) %{
    var slice []swig_stringintint
    slice = $1
    $result = make([][]interface{}, len(slice))
    for i := range slice {
        $result[i] = make([]interface{}, 3)
        $result[i][0] = swigCopyString(slice[i].columnName)
        //Swig_free(uintptr(unsafe.Pointer(slice[i].columnName)));
        $result[i][1] = slice[i].mType
        $result[i][2] = slice[i].options
    }
%}

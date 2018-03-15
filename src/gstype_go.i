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

// rename all method to camel cases
%rename("%(lowercamelcase)s", %$isfunction) "";
%typemap(throws) griddb::GSException  %{_swig_gopanic($1.what());%}
%ignore griddb::Row;


%insert(go_wrapper) %{
const (
    CONTAINER_COLLECTION = iota
    CONTAINER_TIME_SERIES
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
    TIME_UNIT_YEAR = iota
    TIME_UNIT_MONTH
    TIME_UNIT_DAY
    TIME_UNIT_HOUR
    TIME_UNIT_MINUTE
    TIME_UNIT_SECOND
    TIME_UNIT_MILLISECOND
)
const (
    INDEX_DEFAULT = iota
    INDEX_TREE
    INDEX_HASH
    INDEX_SPATIAL
)
%}

//insert to wrap function which create ContainerInfo
%insert(go_wrapper) %{
func ContainerInfo__SWIG_1(arg1 string, arg2 [][]interface{}, arg3 int, arg4 bool, arg5 ExpirationInfo) (_swig_ret ContainerInfo, err error) {
	defer catch(&err)
	_swig_ret = NewContainerInfo__SWIG_1(arg1, arg2, arg3, arg4, arg5)
	return
}
func ContainerInfo__SWIG_2(arg1 string, arg2 [][]interface{}, arg3 int, arg4 bool) (_swig_ret ContainerInfo, err error) {
	defer catch(&err)
	_swig_ret = NewContainerInfo__SWIG_2(arg1, arg2, arg3, arg4)
	return
}
func CreateContainerInfo(a ...interface{}) (result ContainerInfo, err error) {
	defer catch(&err)
	argc := len(a)
	if argc == 4 {
		result, err = ContainerInfo__SWIG_2(a[0].(string), a[1].([][]interface{}), a[2].(int), a[3].(bool))
		return
	}
	if argc == 5 {
		result, err = ContainerInfo__SWIG_1(a[0].(string), a[1].([][]interface{}), a[2].(int), a[3].(bool), a[4].(ExpirationInfo))
		return
	}
	panic("No match for overloaded function call")
}

func ExpirationInfo__SWIG_1(arg1 int, arg2 int, arg3 int) (_swig_ret ExpirationInfo, err error) {
	defer catch(&err)
	_swig_ret = NewExpirationInfo__SWIG_1(arg1, arg2, arg3)
	return
}

func CreateExpirationInfo(a ...interface{}) (result ExpirationInfo, err error) {
	defer catch(&err)
	argc := len(a)
	if argc == 3 {
		if (a[0].(int) > math.MaxInt32 || a[0].(int) < math.MinInt32 ||
			a[1].(int) > math.MaxInt32 || a[1].(int) < math.MinInt32 ||
			a[2].(int) > math.MaxInt32 || a[2].(int) < math.MinInt32) {
			panic("Integer overflow")
		} else {
			result, err = ExpirationInfo__SWIG_1(a[0].(int), a[1].(int), a[2].(int))
			return
		}
	}
	panic("No match for overloaded function call")
}
%}
%typemap(gotype) (griddb::Container*) %{Container%}
%typemap(imtype) (griddb::Container*) %{SwigcptrWrapped_Container%}
namespace griddb {
%rename(Wrapped_Container) Container;
%rename(Wrapped_put) Container::put;
%rename(Wrapped_get) Container::get;
%rename(Wrapped_remove) Container::remove;
%rename(Wrapped_query) Container::query;
}
%insert(go_wrapper) %{
type Container interface {
	Wrapped_Container
	Get(interface{}) (row []interface{} , err error)
	Put(row []interface{}) (err error)
	Query(str string) (mQuery Query, err error)
	Remove(key interface{}) (err error)
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
func (e SwigcptrWrapped_Container) Query(str string) (mQuery Query, err error) {
	defer catch(&err)
	mQuery = e.Wrapped_query(str)
	return
}
%}
%typemap(gotype) (griddb::Query*) %{Query%}
%typemap(imtype) (griddb::Query*) %{SwigcptrWrapped_Query%}
namespace griddb {
%rename(Wrapped_Query) Query;
%rename(Wrapped_fetch) Query::fetch;
}
%insert(go_wrapper) %{
type Query interface {
	Wrapped_Query
	Fetch(for_update bool) (mRowSet RowSet, err error)
}
func (e SwigcptrWrapped_Query) Fetch(for_update bool) (mRowSet RowSet, err error) {
	defer catch(&err)
	mRowSet = e.Wrapped_fetch(for_update)
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
%rename(Wrapped_get_next_query_analysis) RowSet::get_next_query_analysis;
%rename(Wrapped_get_next_aggregation) RowSet::get_next_aggregation;
}
%insert(go_wrapper) %{
type RowSet interface {
	Wrapped_RowSet
	NextRow() (row []interface{} , err error)
	NextQueryAnalysis() (mQueryAnalysis QueryAnalysisEntry, err error)
	NextAggregation() (mAggregationResult AggregationResult, err error)
}

func (e SwigcptrWrapped_RowSet) NextRow() (row []interface{}, err error) {
	defer catch(&err)
	e.Wrapped_next_row(&row)
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
%typemap(gotype) (griddb::Store*) %{Store%}
%typemap(imtype) (griddb::Store*) %{SwigcptrWrapped_Store%}
namespace griddb {
%rename(Wrapped_Store) Store;
%rename(Wrapped_multi_get) Store::multi_get;
%rename(Wrapped_put_container) Store::put_container;
%rename(Wrapped_get_container) Store::get_container;
%rename(Wrapped_drop_container) Store::drop_container;
}
%insert(go_wrapper) %{
type Store interface {
	Wrapped_Store
	MultiGet(map[string]RowKeyPredicate) (mapRowList map[string][][]interface{})
	PutContainer(a ...interface{}) (container Container, err error)
	GetContainer(containerName string) (container Container, err error)
	DropContainer(containerName interface{}) (err error)
}
// inside the go_wrapper...
func catch(err *error) {
	if r := recover(); r != nil {
		*err = fmt.Errorf("%v", r)
	}
}
func (e SwigcptrWrapped_Store) MultiGet(predicate map[string]RowKeyPredicate) (mapRowList map[string][][]interface{}) {
	e.Wrapped_multi_get(predicate, &mapRowList)
	return
}
func (e SwigcptrWrapped_Store) PutContainer__SWIG_0(containerInfo ContainerInfo, modifiable bool) (container Container, err error) {
	defer catch(&err)
	container = e.Wrapped_put_container__SWIG_0(containerInfo, modifiable)
	return
}
func (e SwigcptrWrapped_Store) PutContainer__SWIG_1(containerInfo ContainerInfo) (container Container, err error) {
	defer catch(&err)
	container = e.Wrapped_put_container__SWIG_1(containerInfo)
	return
}
func (p SwigcptrWrapped_Store) PutContainer(a ...interface{}) (container Container, err error) {
	defer catch(&err)
	argc := len(a)
	if argc == 1 {
		return p.PutContainer__SWIG_1(a[0].(ContainerInfo))
	}
	if argc == 2 {
		return p.PutContainer__SWIG_0(a[0].(ContainerInfo), a[1].(bool))
	}
	panic("No match for overloaded function call")
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
    Get() (info []interface{})
}

func (e SwigcptrWrapped_QueryAnalysisEntry) Get() (info []interface{}) {
	e.Wrapped_get(&info)
	return
}
%}
%typemap(gotype) (griddb::PartitionController*) %{PartitionController%}
%typemap(imtype) (griddb::PartitionController*) %{SwigcptrWrapped_PartitionController%}
namespace griddb {
%rename(Wrapped_PartitionController) PartitionController;
%rename(Wrapped_get_container_names) PartitionController::get_container_names;
%rename(Wrapped_get_partition_hosts) PartitionController::get_partition_hosts;
%rename(Wrapped_get_partition_backup_hosts) PartitionController::get_partition_backup_hosts;
}
%insert(go_wrapper) %{
type PartitionController interface {
	Wrapped_PartitionController
	GetContainerNames(partition_index int,start int, limit int) (stringList []string)
	GetPartitionHosts(partitionIndex int) (stringList []string)
	GetPartitionBackupHosts(partitionIndex int) (stringList []string)
}

func (e SwigcptrWrapped_PartitionController) GetContainerNames(partition_index int,start int, limit int) (stringList []string) {
	e.Wrapped_get_container_names(partition_index, int64(start), &stringList, int64(limit))
	return
}
func (e SwigcptrWrapped_PartitionController) GetPartitionHosts(partition_index int) (stringList []string) {
	e.Wrapped_get_partition_hosts(partition_index, &stringList)
	return
}
func (e SwigcptrWrapped_PartitionController) GetPartitionBackupHosts(partition_index int) (stringList []string) {
	e.Wrapped_get_partition_backup_hosts(partition_index, &stringList)
	return
}
%}
%typemap(gotype) (griddb::RowKeyPredicate*) %{RowKeyPredicate%}
%typemap(imtype) (griddb::RowKeyPredicate*) %{SwigcptrWrapped_RowKeyPredicate%}
namespace griddb {
%rename(Wrapped_RowKeyPredicate) RowKeyPredicate;
%rename(Wrapped_get_range) RowKeyPredicate::get_range;
%rename(Wrapped_get_distinct_keys) RowKeyPredicate::get_distinct_keys;
}
%insert(go_wrapper) %{
type RowKeyPredicate interface {
    Wrapped_RowKeyPredicate
    GetRange() (rangeResult []interface{})
    GetDistinctKeys() (keys []interface{})
}

func (e SwigcptrWrapped_RowKeyPredicate) GetRange() (rangeResult []interface{}) {
	e.Wrapped_get_range(&rangeResult)
	return
}
func (e SwigcptrWrapped_RowKeyPredicate) GetDistinctKeys() (keys []interface{}) {
	e.Wrapped_get_distinct_keys(&keys)
	return
}
%}

//fragment to get data from _gostring_
%fragment("GetDataGoString", "header") %{
static GSChar* GetDataGoString(_gostring_ input) {
	if(input.p == NULL) {
		return NULL;
	}
	GSChar* result = (GSChar *)malloc(input.n + 1);
	memset(result, 0x0, input.n + 1);
	memcpy(result, input.p, input.n);
	return result;
}
%}
// represent for map[string]interface{} to support get_store
%fragment("cGetStoreListArg", "header", fragment="GetDataGoString") %{
struct swig_GetStoreListArg {
	_gostring_ host;
	intgo port;
	_gostring_ cluster_name;
	_gostring_ database;
	_gostring_ username;
	_gostring_ password;
	_gostring_ notification_member;
	_gostring_ notification_provider;
};
%}
%fragment("goGetStoreListArg", "go_runtime") %{
type swig_GetStoreListArg struct {
	host string;
	port int;
	cluster_name string;
	database string;
	username string;
	password string;
	notification_member string;
	notification_provider string;
}
%}

// represent for []interface{}{string, int , int}
%fragment("cstringintint", "header") %{
struct swig_stringintint {
	_gostring_ columnName;
	long mType;
//	long options;
};
%}
%fragment("gostringintint", "go_runtime") %{
type swig_stringintint struct {
	columnName string;
	mType int;
//	options int;
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
	int32_t asInteger;
	int64_t asLong;
	bool asBool;
	double asDouble;
	float asFloat;
	_goslice_ asBlob;
	int64_t asTimestamp;
	int8_t asByte;
	int16_t asShort;
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
	asInteger int32
	asLong int64
	asBool bool
	asDouble float64
	asFloat float32
	asBlob []byte
	asTimestamp int64
	asByte int8
	asShort int16
}
const (
STRING = iota
BOOL
BYTE
SHORT
INTEGER
LONG
FLOAT
DOUBLE
TIMESTAMP
GEOMETRY
BLOB
STRING_ARRAY
BOOL_ARRAY
BYTE_ARRAY
SHORT_ARRAY
INTEGER_ARRAY
LONG_ARRAY
FLOAT_ARRAY
DOUBLE_ARRAY
TIMESTAMP_ARRAY
NULL
)

const (
COLLECTION = iota
TIME_SERIES
)
func GoDataFromInterface(mResult *swig_interface, mInput *interface{}) {
	if((*mInput) == nil) {
		(*mResult).mtype = NULL
	} else {
		switch reflect.ValueOf((*mInput)).Kind() {
			case reflect.String:
				value, ok := (*mInput).(string)
				if(!ok) {
					panic("can not interface convert to string")
				}
				(*mResult).asString = value
				(*mResult).mtype = STRING
			case reflect.Bool:
				value, ok := (*mInput).(bool)
				if(!ok) {
					panic("can not interface convert to bool")
				}
				(*mResult).asBool = value
				(*mResult).mtype = BOOL
			case reflect.Int:
				value, ok := (*mInput).(int)
				if(!ok) {
					panic("can not interface convert to int")
				}
				if ((math.MinInt8 <= value) && (value <= math.MaxInt8)){
					(*mResult).asByte = int8(value)
					(*mResult).mtype = BYTE
				} else if ((math.MinInt16 <= value) && (value <= math.MaxInt16)){
					(*mResult).asShort = int16(value)
					(*mResult).mtype = SHORT
				} else if ((math.MinInt32 <= value) && (value <= math.MaxInt32)){
					(*mResult).asInteger = int32(value)
					(*mResult).mtype = INTEGER
				} else {
					(*mResult).asLong = int64(value)
					(*mResult).mtype = LONG
				}
			case reflect.Float32:
				value, ok := (*mInput).(float32)
				if(!ok) {
					panic("can not interface convert to float")
				}
				(*mResult).asFloat = value
				(*mResult).mtype = FLOAT
			case reflect.Float64:
				value, ok := (*mInput).(float64)
				if(!ok) {
					panic("can not interface convert to double")
				}
				if ((math.SmallestNonzeroFloat32 < value) && (value <= math.MaxFloat32)){
					(*mResult).asFloat = float32(value)
					(*mResult).mtype = FLOAT
				} else {
					(*mResult).asDouble = float64(value)
					(*mResult).mtype = DOUBLE
				}
			case reflect.Struct:
				tmp, ok := (*mInput).(time.Time)
				if (!ok) {
					panic("can not interface convert to time object")
				}
				(*mResult).mtype = TIMESTAMP
				(*mResult).asTimestamp = tmp.Unix()
				var tmpMili int64
				tmpMili = 0
				if (strings.Contains(tmp.String(), ".")) {
					strList := strings.Split(tmp.String(), " ")
					mstr := strList[1]
					strList = strings.Split(mstr, ".")
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
				(*mResult).asTimestamp = (*mResult).asTimestamp * 1000 + tmpMili
			case reflect.Slice:
				value, ok := (*mInput).([]byte)
				if(!ok) {
					panic("can not interface convert to blob")
				}
				(*mResult).asBlob = value
				(*mResult).mtype = BLOB
			default:
				panic("no type of interface found for row")
		}
	}
}

func GoDataTOInterface(mInput *swig_interface, mResult *interface{}) {
	switch (*mInput).mtype {
		case STRING:
			*mResult = (*mInput).asString
		case BOOL:
			*mResult = (*mInput).asBool
		case INTEGER:
			*mResult = (*mInput).asInteger
		case LONG:
			*mResult = (*mInput).asLong
		case SHORT:
			*mResult = (*mInput).asShort
		case BYTE:
			*mResult = (*mInput).asByte
		case FLOAT:
			*mResult = (*mInput).asFloat
		case DOUBLE:
			*mResult = (*mInput).asDouble
		case TIMESTAMP:
			tmp := time.Unix((*mInput).asTimestamp / 1000, ((*mInput).asTimestamp % 1000)*1000000).UTC()
			*mResult = tmp
		case BLOB:
			*mResult = (*mInput).asBlob
		case -1:
			*mResult = nil
		default:
			panic("no type found for row to convert to interface\n")
	}
}
%}

/*
* fragment to support converting data for GSRow
*/
%fragment("convertFieldToObject", "header", fragment = "cinterface") {
static bool convertFieldToObject(swig_interface *map, griddb::Field *field) {
	switch (field->type) {
		case GS_TYPE_BLOB:
			map->asBlob.len = field->value.asBlob.size;
			map->asBlob.cap = field->value.asBlob.size;
			map->asBlob.array = malloc(sizeof(GSChar) * map->asBlob.len + 1);
			memset(map->asBlob.array, 0x0, sizeof(GSChar) * map->asBlob.len + 1);
			memcpy(map->asBlob.array, field->value.asBlob.data, map->asBlob.len);
			map->type = GS_TYPE_BLOB;
			return true;
		case GS_TYPE_BOOL:
			map->asBool =  field->value.asBool;
			map->type = GS_TYPE_BOOL;
			return true;
		case GS_TYPE_INTEGER:
			map->asInteger =  field->value.asInteger;
			map->type = GS_TYPE_INTEGER;
			return true;
		case GS_TYPE_LONG:
			map->asLong =  field->value.asLong;
			map->type = GS_TYPE_LONG;
			return true;
		case GS_TYPE_FLOAT:
			map->asFloat =  field->value.asFloat;
			map->type = GS_TYPE_FLOAT;
			return true;
		case GS_TYPE_DOUBLE:
			map->asDouble =  field->value.asDouble;
			map->type = GS_TYPE_DOUBLE;
			return true;
		case GS_TYPE_STRING:
			map->asString.n = strlen(field->value.asString);
			map->asString.p = (GSChar *)malloc(sizeof(GSChar) * map->asString.n + 1);
			memset(map->asString.p, 0x0, sizeof(GSChar) * map->asString.n + 1);
			memcpy(map->asString.p, field->value.asString, strlen(field->value.asString));
			map->type = GS_TYPE_STRING;
			return true;
		case GS_TYPE_TIMESTAMP:
			map->asTimestamp = field->value.asTimestamp;
			map->type = GS_TYPE_TIMESTAMP;
			return true;
		case GS_TYPE_SHORT:
			map->asShort = field->value.asShort;
			map->type    = GS_TYPE_SHORT;
			return true;
		case GS_TYPE_BYTE:
			map->asByte = field->value.asByte;
			map->type   = GS_TYPE_BYTE;
			return true;
%#if GS_COMPATIBILITY_SUPPORT_3_5
		case GS_TYPE_NULL:
			map->type = GS_TYPE_NULL;
%#endif
		default:
			printf("not found type of field to convert to object\n");
			return false;
	}
	return false;
}
}
%fragment("convertObjectToField", "header", fragment = "cinterface") {
	static bool convertObjectToField(griddb::Field &field, swig_interface *map) {
		if (map->type == GS_TYPE_STRING) {
			GSChar *tmp = (GSChar*)malloc(sizeof(GSChar) * map->asString.n);
			memset(tmp, 0x0, sizeof(GSChar) * map->asString.n);
			memcpy(tmp, map->asString.p, map->asString.n);
			field.value.asString = (const GSChar*)tmp;
			field.type = GS_TYPE_STRING;
		} else if (map->type == GS_TYPE_BOOL) {
			field.value.asBool = map->asBool;
			field.type = GS_TYPE_BOOL;
		} else if (map->type == GS_TYPE_INTEGER) {
			field.value.asInteger = map->asInteger;
			field.type = GS_TYPE_INTEGER;
		} else if (map->type == GS_TYPE_LONG) {
			field.value.asLong = map->asLong;
			field.type = GS_TYPE_LONG;
		} else if (map->type == GS_TYPE_FLOAT) {
			field.value.asFloat = map->asFloat;
			field.type = GS_TYPE_FLOAT;
		} else if (map->type == GS_TYPE_DOUBLE) {
			field.value.asDouble = map->asDouble;
			field.type = GS_TYPE_DOUBLE;
		} else if (map->type == GS_TYPE_TIMESTAMP) {
			field.value.asTimestamp = map->asTimestamp;
			field.type = GS_TYPE_TIMESTAMP;
		} else if (map->type == GS_TYPE_BLOB) {
			field.value.asBlob.size = map->asBlob.len;
			void *tmp = malloc(sizeof(GSChar) * map->asBlob.len + 1);
			memset(tmp, 0x0 , sizeof(GSChar) * map->asBlob.len + 1);
			memcpy(tmp, map->asBlob.array, field.value.asBlob.size);
			field.value.asBlob.data = (const void*)tmp;
			field.type = GS_TYPE_BLOB;
		} else if (map->type == GS_TYPE_SHORT) {
			field.value.asShort = map->asShort;
			field.type = GS_TYPE_SHORT;
		} else if (map->type == GS_TYPE_BYTE) {
			field.value.asByte = map->asByte;
			field.type = GS_TYPE_BYTE;
%#if GS_COMPATIBILITY_SUPPORT_3_5
		} else if (map->type == 20) {
			field.type = GS_TYPE_NULL;
%#endif
		} else {
			printf("not found type of object to convert to field, type of object = %d\n", map->type);
			return false;
		}
		return true;
	}
}

/**
* Typemaps for StoreFactory.get_store() function
*/
%typemap(gotype) (const char* host=NULL, int32_t port=NULL, const char* cluster_name=NULL,
		const char* database=NULL, const char* username=NULL, const char* password=NULL,
		const char* notification_member=NULL, const char* notification_provider=NULL)
%{map[string]interface{}%}
%typemap(imtype) (const char* host=NULL, int32_t port=NULL, const char* cluster_name=NULL,
		const char* database=NULL, const char* username=NULL, const char* password=NULL,
		const char* notification_member=NULL, const char* notification_provider=NULL)
%{[]swig_GetStoreListArg%}
%typemap(goin, fragment="goGetStoreListArg") (const char* host=NULL, int32_t port=NULL, const char* cluster_name=NULL,
		const char* database=NULL, const char* username=NULL, const char* password=NULL,
		const char* notification_member=NULL, const char* notification_provider=NULL) %{
	// init zero struct
	$result = make([]swig_GetStoreListArg, 1, 1)
	$result[0].host                  = ""
	$result[0].port                  = 0
	$result[0].cluster_name          = ""
	$result[0].database              = ""
	$result[0].username              = ""
	$result[0].password              = ""
	$result[0].notification_member   = ""
	$result[0].notification_provider = ""
	// set data from input
	for arg := range $input {
		switch(arg) {
		case "host":
			$result[0].host = $input[arg].(string)
		case "port":
			$result[0].port = $input[arg].(int)
		case "cluster_name":
			$result[0].cluster_name = $input[arg].(string)
		case "database":
			$result[0].database = $input[arg].(string)
		case "username":
			$result[0].username = $input[arg].(string)
		case "password":
			$result[0].password = $input[arg].(string)
		case "notification_member":
			$result[0].notification_member = $input[arg].(string)
		case "notification_provider":
			$result[0].notification_provider = $input[arg].(string)
		default:
			panic("not match argument's name")
		}
	}
%}
%typemap(in, fragment="cGetStoreListArg") (const char* host=NULL, int32_t port=NULL, const char* cluster_name=NULL,
		const char* database=NULL, const char* username=NULL, const char* password=NULL,
		const char* notification_member=NULL, const char* notification_provider=NULL)
(swig_GetStoreListArg *map)%{
	map = (swig_GetStoreListArg *)$input.array;
	$1 = GetDataGoString(map[0].host);
	$2 = map[0].port;
	$3 = GetDataGoString(map[0].cluster_name);
	$4 = GetDataGoString(map[0].database);
	$5 = GetDataGoString(map[0].username);
	$6 = GetDataGoString(map[0].password);
	$7 = GetDataGoString(map[0].notification_member);
	$8 = GetDataGoString(map[0].notification_provider);
%}
%typemap(freearg) (const char* host=NULL, int32_t port=NULL, const char* cluster_name=NULL,
		const char* database=NULL, const char* username=NULL, const char* password=NULL,
		const char* notification_member=NULL, const char* notification_provider=NULL) {
	if($1) {
		free((void *)$1);
	}
	if($3) {
		free((void *)$3);
	}
	if($4) {
		free((void *)$4);
	}
	if($5) {
		free((void *)$5);
	}
	if($6) {
		free((void *)$6);
	}
	if($7) {
		free((void *)$7);
	}
	if($8) {
		free((void *)$8);
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
			printf("Memory allocation for  GSPropertyEntry error\n");
		}
		for(int i = 0; i < $2; i++){
			$1[i].name = (char*)malloc((prop_map[i].key.n + 1) * sizeof(char));
			$1[i].value = (char*)malloc((prop_map[i].value.n + 1) * sizeof(char));
			memset((void *) $1[i].name, 0x0, prop_map[i].key.n + 1);
			memset((void *) $1[i].value, 0x0, prop_map[i].value.n + 1);
			memcpy((void *) $1[i].name, prop_map[i].key.p, prop_map[i].key.n);
			memcpy((void *) $1[i].value, prop_map[i].value.p, prop_map[i].value.n);
		}
	}
%}
%typemap(freearg) (const GSPropertyEntry* props, int propsCount) {
	if ($1) {
		for(int i = 0; i < $2; i++){
			if($1[i].name) {
				free((void *) $1[i].name);
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
%typemap(imtype) (const GSColumnInfo* props, int propsCount) %{[]swig_stringintint%}
%go_import("fmt")
%typemap(goin, fragment="gostringintint") (const GSColumnInfo* props, int propsCount) %{
	$result = make([]swig_stringintint, len($input), len($input))
	for i := range $input {
		$result[i].columnName = $input[i][0].(string)
		$result[i].mType      = $input[i][1].(int)
//		if(len($input[i]) >= 3) {
//			$result[i].options = $input[i][2].(int)
//		}
	}
%}
%typemap(in, fragment="cstringintint") (const GSColumnInfo* props, int propsCount)
(swig_stringintint *map, GSChar *tmpStr) %{
	map = (swig_stringintint *)$input.array;
	$2 = $input.len;
	if($2 <= 0) {
		printf("column list for GSColumnInfo is not valid\n");
	}
	$1 = (GSColumnInfo *) malloc($2 * sizeof(GSColumnInfo));
	memset($1, 0x0, $2 * sizeof(GSColumnInfo));
	if($1 == NULL) {
		printf("Memory allocation for GSColumnInfo error");
	}
	for(int i = 0; i < $2; i++) {
		tmpStr = (GSChar*) malloc(map[i].columnName.n + 1);
		memset(tmpStr, 0x0, map[i].columnName.n + 1);
		memcpy(tmpStr, map[i].columnName.p, map[i].columnName.n);
		$1[i].name = tmpStr;
		$1[i].type = (int32_t) map[i].mType;
#if GS_COMPATIBILITY_SUPPORT_3_5
		$1[i].options = (int32_t) map[i].options;
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
			printf("Memory allocation for GSQuery error");
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
	memset(tmp, 0x0, $input->len * sizeof(swig_interface));
	if(!convertFieldToObject(tmp, $1)) {
		printf("can not convert from filed input to object for creating row\n");
	}
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
%typemap(gotype) (griddb::Row *rowContainer) %{[]interface{}%}
%typemap(imtype) (griddb::Row *rowContainer) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Row *rowContainer) %{
	$result = make([]swig_interface, len($input), len($input))
	for i := range $input {
		GoDataFromInterface(&$result[i], &$input[i])
	}
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (griddb::Row *rowContainer)
(int length, griddb::Row tmpRow, griddb::Field *tmpField, int i, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	length = $input.len;
	tmpRow.resize(length);
	tmpField = tmpRow.get_field_ptr();
	for(i = 0; i < length; i++) {
		if(!(convertObjectToField(tmpField[i], &map[i]))) {
			printf("can not convert interface number %d to field for row based on input\n", i);
		}
	}
	$1 = &tmpRow;
%}

/**
* Typemaps for RowSet.update() function
*/
%typemap(gotype) (griddb::Row *row) %{[]interface{}%}
%typemap(imtype) (griddb::Row *row) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Row *row) %{
	$result = make([]swig_interface, len($input), len($input))
	for i := range $input {
		GoDataFromInterface(&$result[i], &$input[i])
	}
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (griddb::Row *row)
(int length, griddb::Row tmpRow, griddb::Field *tmpField, int i, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	length = $input.len;
	tmpRow.resize(length);
	tmpField = tmpRow.get_field_ptr();
	for(i = 0; i < length; i++) {
		if(!(convertObjectToField(tmpField[i], &map[i]))) {
			printf("can not convert interface number %d to field for row based on input\n", i);
		}
	}
	$1 = &tmpRow;
%}

/**
* Typemaps for Container.multi_put() function
*/
%typemap(gotype) (griddb::Row** listRowdata) %{[][]interface{}%}
%typemap(imtype) (griddb::Row** listRowdata) %{[][]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Row** listRowdata) %{
	$result = make([][]swig_interface, len($input))
	for i := range $input {
		tmpSize := len($input[i])
		$result[i] = make([]swig_interface, tmpSize)
		for j := range $result[i] {
			GoDataFromInterface(&$result[i][j], &$input[i][j])
		}
	}
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (griddb::Row** listRowdata, int rowCount)
(int length, griddb::Row **tmpListRow, griddb::Field *tmpField, int i, swig_interface *tmpMap, _goslice_ *tmpSlice) %{
	$2 = $input.len;
	tmpListRow = (griddb::Row **)malloc(sizeof(griddb::Row *) * $2);
	for(int i = 0; i < $input.len; i++) {
		tmpListRow[i] = new griddb::Row;
		tmpSlice = (_goslice_ *)$input.array;
		tmpMap = (swig_interface *)tmpSlice[i].array;
		length = tmpSlice[i].len;
		tmpListRow[i]->resize(length);
		tmpField = tmpListRow[i]->get_field_ptr();
		for(int j = 0; j < length; j++) {
			if(!(convertObjectToField(tmpField[j], &tmpMap[j]))) {
				printf("can not convert interface number %d to field for row based on input\n", i);
			}
		}
	}
	$1 = tmpListRow;
%}
%typemap(freearg) (griddb::Row** listRowdata, int rowCount) {
	if($1) {
		for(int i = 0; i < $2; i++) {
			if($1[i]) {
				delete $1[i];
			}
		}
		free((void *)$1);
	}
}

/*
* typemap for Container.get_row
*/
// Convert data for input
%typemap(gotype) (griddb::Field* keyFields) %{interface{}%}
%typemap(imtype) (griddb::Field* keyFields) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Field* keyFields) %{
	$result = make([]swig_interface, 1, 1)
	GoDataFromInterface(&$result[0], &$input)
%}
%typemap(in, fragment="cinterface", fragment = "convertObjectToField") (griddb::Field* keyFields)
(griddb::Field tmpField, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	if(!convertObjectToField(tmpField, &map[0])) {
		printf("can not convert interface to field for keyFields data based on input");
	}
	$1 = &tmpField;
%}
%typemap(freearg) (griddb::Field* keyFields) {
	if(tmpField$argnum.type == GS_TYPE_STRING) free((void *) tmpField$argnum.value.asString);
	if(tmpField$argnum.type == GS_TYPE_BLOB) free((void *) tmpField$argnum.value.asBlob.data);
}
// Convert data for output
%typemap(in, numinputs = 1) (griddb::Row *rowdata) (griddb::Row tmpRow) %{
	$1 = &tmpRow;
%}
%typemap(gotype) (griddb::Row *rowdata) %{*[]interface{}%}
%typemap(imtype) (griddb::Row *rowdata) %{*[]swig_interface%}
%typemap(argout, fragment="convertFieldToObject") (griddb::Row *rowdata) (griddb::Field *tmpField) %{
	$input->len = $1->get_count();
	$input->cap = $1->get_count();
	tmpField = $1->get_field_ptr();
	swig_interface *tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
	memset(tmp, 0x0, $input->len * sizeof(swig_interface));
	for(int i = 0; i < $input->len; i++) {
		if(!convertFieldToObject(&tmp[i], &tmpField[i])) {
			printf("can not convert from field number %d to object for get row\n", i);
		}
	}
	$input->array = tmp;
%}
%typemap(goargout, fragment="gointerface") (griddb::Row *rowdata) %{
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
* typemap for RowSet.next function
*/
// Convert data for output is reused from Container's function get()
%typemap(in, numinputs = 0) (bool* hasNextRow) (bool tmpHasNextRow) %{
	$1 = &tmpHasNextRow;
%}

/*
* typemap for Store.multi_put function
*/
%typemap(gotype) (griddb::Row*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{map[string][][]interface{}%}
%typemap(imtype) (griddb::Row*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
%{[]swig_ContainerListRow%}
%typemap(goin, fragment="gointerface", fragment="goContainerListRow") (griddb::Row*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) %{
	$result = make([]swig_ContainerListRow, len($input))
	i := 0
	for contanierName := range $input {
		$result[i].containerName = contanierName
		$result[i].list_size = len($input[contanierName])
		$result[i].listRow = make([][]swig_interface, $result[i].list_size)
		for j := range $input[contanierName] {
			$result[i].listRow[j] = make([]swig_interface, len($input[contanierName][j]))
			for k := range $input[contanierName][j] {
				GoDataFromInterface(&$result[i].listRow[j][k], &$input[contanierName][j][k])
			}
		}
		i = i +1
	}
%}
%typemap(in, numinputs = 1, fragment="cinterface", fragment="convertObjectToField", fragment= "cContainerListRow")
(griddb::Row*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount)
(swig_ContainerListRow *tmpInput, int tmplen, griddb::Field *tmpField, swig_interface *tmpMap, _goslice_ *tmpSlice) %{
	// set data for entry
	$4 = $input.len;
	tmpInput = (swig_ContainerListRow *)$input.array;
	$1 = (griddb::Row ***)malloc(sizeof(griddb::Row**) * $4);
	$2 = (int *)malloc(sizeof(int) * $4);
	$3 = (GSChar **)malloc(sizeof(GSChar*) * $4);
	// set data for each container
	for(int m = 0; m < $4; m++) {
		$2[m]    = tmpInput[m].list_size;
		$3[m]    = (GSChar *)malloc(sizeof(GSChar) * (int)tmpInput[m].containerName.n + 1);
		memset($3[m], 0x0, sizeof(GSChar) * (int)tmpInput[m].containerName.n + 1);
		memcpy($3[m], tmpInput[m].containerName.p, tmpInput[m].containerName.n);
		$1[m] = (griddb::Row **)malloc(sizeof(griddb::Row*) * $2[m]);
		// set data for each row
		for(int i = 0; i < $2[m]; i++) {
			$1[m][i]  = new griddb::Row;
			tmpSlice  = (_goslice_ *)tmpInput[m].listRow.array;
			tmpMap    = (swig_interface *)tmpSlice[i].array;
			tmplen    = tmpSlice[i].len;
			$1[m][i]->resize(tmplen);
			tmpField = $1[m][i]->get_field_ptr();
			// set data for each field of row
			for(int j = 0; j < tmplen; j++) {
				if(!(convertObjectToField(tmpField[j], &tmpMap[j]))) {
					printf("can not convert interface number %d to field for row based on input\n", i);
				}
			}
		}
	}
%}
%typemap(freearg) (griddb::Row*** listRow, const int *listRowContainerCount, const char ** listContainerName, size_t containerCount) {
	for(int i = 0; i < $4; i++) {
		if($1[i]) {
			for(int j = 0; j < $2[i]; j++) {
				if($1[i][j]) {
					delete $1[i][j];
				}
			}
			free((void*)$1[i]);
		}
		if($3) {
			if($3[i]) {
				free($3[i]);
			}
		}
	}
	if($1) free((void *)$1);
	if($2) free((void *)$2);
	if($3) free((void *)$3);
}

/*
* typemap for Store.multi_get function
*/
//input for Store.multi_get() function
%typemap(gotype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{map[string]RowKeyPredicate%}
%typemap(imtype) (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{[]swig_mapstringrowkeypredicate%}
%typemap(goin, fragment= "gostringrowkeypredicate") (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount) %{
	$result = make([]swig_mapstringrowkeypredicate, len($input), len($input))
	i := 0
	for containerName := range $input {
		$result[i].containerName = containerName
		$result[i].rowKeyPredicate = $input[containerName].Swigcptr()
		i ++
	}
%}
%typemap(in, numinputs = 1, fragment= "cstringrowkeypredicate") (const GSRowKeyPredicateEntry* const * predicateList, size_t predicateCount)
(swig_mapstringrowkeypredicate *mapper, GSRowKeyPredicateEntry *tmpEntry, GSChar *tmpStr)%{
	mapper = (swig_mapstringrowkeypredicate *) $input.array;
	$2 = $input.len;
	$1 = NULL;
	if($2 > 0) {
		tmpEntry = new GSRowKeyPredicateEntry[$2];
		if(tmpEntry == NULL) {
			printf("Memory allocation for GSRowKeyPredicateEntry error");
			return;
		}
		// set data for each element of entry array
		for(int i = 0; i < $2; i++) {
			tmpStr = (GSChar*) malloc(sizeof(GSChar) * mapper[i].containerName.n + 1);
			memset(tmpStr, 0x0, mapper[i].containerName.n + 1);
			memcpy(tmpStr, mapper[i].containerName.p, mapper[i].containerName.n);
			tmpEntry[i].containerName = tmpStr;
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
%typemap(in, numinputs = 1) (std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount)
(std::vector<griddb::Row*> listRow1, size_t *listRowContainerCount1, char** listContainerName1, size_t containerCount1) {
	$1 = &listRow1;
	$2 = &listRowContainerCount1;
	$3 = &listContainerName1;
	$4 = &containerCount1;
}
%typemap(freearg) (std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount) {
	for(int i = 0; i < (*$1).size(); i++) {
		if((*$1).at(i)) {
			delete (*$1).at(i);
		}
	}
	if(*$2) {
		free((void*) (*$2));
	}
	if(*$3) {
		for(int i = 0; i < *$4; i++) {
			if((*$3)[i]) {
				free((void*) (*$3)[i]);
			}
		}
		free((void *)(*$3));
	}
}
%typemap(gotype) (std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount)
%{*map[string][][]interface{}%}
%typemap(imtype) (std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount)
%{*[]swig_ContainerListRow%}
%typemap(argout, fragment="convertFieldToObject", fragment="cContainerListRow") (std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount)
(swig_ContainerListRow *tmpEntry, GSChar *tmpStr, swig_interface* tmpRow, griddb::Row* rowPtr, griddb::Field *tmpField, int startPoint) %{
	$input->len = *$4;
	$input->cap = *$4;
	tmpEntry = (swig_ContainerListRow *)malloc($input->len * sizeof(swig_ContainerListRow));
	memset(tmpEntry, 0x0, $input->len * sizeof(swig_ContainerListRow));
	//set for each container
	startPoint = 0;
	for(int i = 0; i < $input->len; i++) {
		tmpEntry[i].containerName.n = strlen((*$3)[i]);
		tmpStr = (GSChar *)malloc(sizeof(GSChar) * tmpEntry[i].containerName.n + 1);
		memset(tmpStr, 0x0, sizeof(GSChar) * tmpEntry[i].containerName.n + 1);
		memcpy(tmpStr,  (*$3)[i], tmpEntry[i].containerName.n);
		tmpEntry[i].containerName.p = tmpStr;
		tmpEntry[i].list_size = (*$2)[i];
		tmpEntry[i].listRow.len = (*$2)[i];
		tmpEntry[i].listRow.cap = (*$2)[i];
		tmpEntry[i].listRow.array = (void *)new _goslice_[tmpEntry[i].list_size];
		// set for all rows of container
		for(int j = 0; j < tmpEntry[i].list_size; j++) {
			// Get data from field array of row
			rowPtr = (*$1).at(startPoint + j);
			tmpField = rowPtr->get_field_ptr();
			// init data for output
			((_goslice_*)tmpEntry[i].listRow.array)[j].len  = rowPtr->get_count();
			((_goslice_*)tmpEntry[i].listRow.array)[j].cap  = rowPtr->get_count();
			((_goslice_*)tmpEntry[i].listRow.array)[j].array = (void *) new swig_interface[rowPtr->get_count()];
			tmpRow = (swig_interface*) ((_goslice_*)tmpEntry[i].listRow.array)[j].array;
			// set data for output
			for(int n = 0; n < rowPtr->get_count(); n++) {
				if(!convertFieldToObject(&tmpRow[n], &tmpField[n])) {
					printf("can not convert from field number %d to object for get row\n", i);
				}
			}
		}
		startPoint += tmpEntry[i].list_size;
	}
	$input->array = (void *)tmpEntry;
%}
%typemap(goargout, fragment="gointerface", fragment="goContainerListRow")
(std::vector<griddb::Row*> *listRow, size_t **listRowContainerCount, char*** listContainerName, size_t* containerCount) %{
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
		//tmpContainerName := *(*C._gostring_)(unsafe.Pointer(&slice[i].containerName))
		//Swig_free(uintptr(unsafe.Pointer(tmpContainerName.p)))
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
	memset(tmp, 0x0, num * sizeof(swig_interface));
	for(int i = 0; i < 6; i++) {
		if(!convertFieldToObject(&tmp[i], &tmpQueryAnalysis[i])) {
			printf("can not convert from field number %d to object for get row\n", i);
		}
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
	*$input = tmp
%}

/**
 * Typemap for RowKeyPredicate.set_range()
*/
%typemap(gotype) (griddb::Field* startKey) %{interface{}%}
%typemap(imtype) (griddb::Field* startKey) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Field* startKey) %{
	$result = make([]swig_interface, 1, 1)
	GoDataFromInterface(&$result[0], &$input)
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (griddb::Field* startKey)
(griddb::Field tmpField, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	if(!convertObjectToField(tmpField, &map[0])) {
		printf("can not convert interface to field for creating field data based on input");
	}
	$1 = &tmpField;
%}
%typemap(gotype) (griddb::Field* finishKey) %{interface{}%}
%typemap(imtype) (griddb::Field* finishKey) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (griddb::Field* finishKey) %{
	$result = make([]swig_interface, 1, 1)
	GoDataFromInterface(&$result[0], &$input)
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (griddb::Field* finishKey)
(griddb::Field tmpField, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	if(!convertObjectToField(tmpField, &map[0])) {
		printf("can not convert interface to field for creating field data based on input");
	}
	$1 = &tmpField;
%}

/**
 * Typemaps output for RowKeyPredicate.set_distinct_keys()
*/
%typemap(gotype) (const griddb::Field *keys, size_t keyCount) %{[]interface{}%}
%typemap(imtype) (const griddb::Field *keys, size_t keyCount) %{[]swig_interface%}
%typemap(goin, fragment="gointerface") (const griddb::Field *keys, size_t keyCount) %{
	$result = make([]swig_interface, len($input), len($input))
	for i := range $input {
		GoDataFromInterface(&$result[i], &$input[i])
	}
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (const griddb::Field *keys, size_t keyCount)
(griddb::Field *tmpField, int i, swig_interface *map) %{
	map = (swig_interface *)$input.array;
	$2 = $input.len;
	tmpField = new griddb::Field[$2];
	for(i = 0; i < $2; i++) {
		if(!(convertObjectToField(tmpField[i], &map[i]))) {
			printf("can not convert interface number %d to field for row based on input\n", i);
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
(swig_interface *tmp, griddb::Field *tmpField) %{
	$input->len = 2;
	$input->cap = 2;
	tmp = (swig_interface *)malloc($input->len * sizeof(swig_interface));
	memset(tmp, 0x0, $input->len * sizeof(swig_interface));
	if(!convertFieldToObject(&tmp[0], $1)) {
		printf("can not convert from filed to object for startField\n");
	}
	if(!convertFieldToObject(&tmp[1], $2)) {
		printf("can not convert from field to object for finishField\n");
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
	memset(tmp, 0x0, $input->len * sizeof(swig_interface));
	for(int i = 0; i < $input->len; i++) {
		if(!convertFieldToObject(&tmp[i], &((*$1)[i]))) {
			printf("can not convert from field number %d to object for get row\n", i);
		}
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
%typemap(imtype) (ColumnInfoList columnInfoList) %{[][]swig_interface%}
%typemap(goin, fragment="gointerface") (ColumnInfoList columnInfoList) %{
	$result = make([][]swig_interface, len($input))
		for i := range $input {
			tmpSize := len($input[i])
			$result[i] = make([]swig_interface, tmpSize)
			for j := range $result[i] {
				GoDataFromInterface(&$result[i][j], &$input[i][j])
			}
		}
%}
%typemap(in, fragment="cinterface", fragment="convertObjectToField") (ColumnInfoList columnInfoList)
(int length, GSColumnInfo *tmpColumnInfo, griddb::Field *tmpField, int i, swig_interface *tmpMap, _goslice_ *tmpSlice) %{
	$1.size = $input.len;
	tmpColumnInfo = (GSColumnInfo*)malloc(sizeof(GSColumnInfo) * $1.size);
	for(int i = 0; i < $input.len; i++) {
		tmpSlice = (_goslice_ *)$input.array;
		tmpMap = (swig_interface *)tmpSlice[i].array;
		length = tmpSlice[i].len;
#if GS_COMPATIBILITY_SUPPORT_3_5
		if(length < 3) {
			printf("Expect column info has 3 elements");
		}
		GSChar *tmp = (GSChar*)malloc(sizeof(GSChar) * tmpMap[0].asString.n);
        memset(tmp, 0x0, sizeof(GSChar) * tmpMap[0].asString.n);
        memcpy(tmp, tmpMap[0].asString.p, tmpMap[0].asString.n);
		tmpColumnInfo[i].name = tmp;
		tmpColumnInfo[i].type = tmpMap[1].asInteger;
		tmpColumnInfo[i].options = tmpMap[2].asInteger;
#else
		if (length < 2) {
			printf("Expect column info has 2 elements");
		}
		GSChar *tmp = (GSChar*)malloc(sizeof(GSChar) * tmpMap[0].asString.n);
        memset(tmp, 0x0, sizeof(GSChar) * tmpMap[0].asString.n);
        memcpy(tmp, tmpMap[0].asString.p, tmpMap[0].asString.n);
		tmpColumnInfo[i].name = tmp;
		tmpColumnInfo[i].type = tmpMap[1].asInteger;
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
	for(int i = 0; i < $result.len; i++) {
		tmpColumnList[i].columnName.n = strlen($1.columnInfo[i].name);
		GSChar *tmpStr = (GSChar*)malloc(sizeof(GSChar) * tmpColumnList[i].columnName.n + 1);
		memset(tmpStr , 0x0, sizeof(GSChar) * tmpColumnList[i].columnName.n + 1);
		memcpy(tmpStr, $1.columnInfo[i].name, tmpColumnList[i].columnName.n);
		tmpColumnList[i].columnName.p = tmpStr;
		tmpColumnList[i].mType        = $1.columnInfo[i].type;
#if GS_COMPATIBILITY_SUPPORT_3_5
		tmpColumnList[i].options      = $1.columnInfo[i].options;
#endif
	}
	$result.array = tmpColumnList;
%}
%typemap(goout, fragment="gostringintint") (ColumnInfoList) %{
	var slice []swig_stringintint
	slice = $1
	$result = make([][]interface{}, len(slice))
	for i := range slice {
		$result[i] = make([]interface{}, 2)
		$result[i][0] = swigCopyString(slice[i].columnName)
		$result[i][1] = slice[i].mType
//#if GS_COMPATIBILITY_SUPPORT_3_5
//		$result[i][2] = slice[i].options
//#endif
	}
%}

package griddb_go

import "C"

import (
    "unsafe"
    "time"
    "reflect"
)

const (
    RESULT_OK    = 0
    RESULT_FALSE = -1
)
const (
    UTC_TIMESTAMP_MILI_MAX = 253402300799999
    MILI_SECOND       = 1000
)
const (
    TYPE_OPTION_NULLABLE = 2
    TYPE_OPTION_NOT_NULL = 4
)
const (
    INDEX_FLAG_DEFAULT = -1
    INDEX_FLAG_TREE = 1
    INDEX_FLAG_HASH = 2
    INDEX_FLAG_SPATIAL = 4
)
const (
    FETCH_OPTION_LIMIT_MAX = 2147483647
)
const (
    CONTAINER_COLLECTION = iota
    CONTAINER_TIME_SERIES
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

//export lenTimestampArray
func lenTimestampArray(dataInput uintptr) (lenArray int64, convertResult int32) {
    tmpData := (*interface{})(unsafe.Pointer(dataInput))
    data, g := (*tmpData).([]interface{})
    if (g) {
        lenArray = int64(len(data))
        convertResult = RESULT_OK
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export eachElementTimestampArray
func eachElementTimestampArray(dataInput uintptr, arrayElement []uintptr) (convertResult int32) {
    tmpData := (*interface{})(unsafe.Pointer(dataInput))
    data, g := (*tmpData).([]interface{})
    if (g) {
        for i := range data {
            arrayElement[i] = (uintptr)(unsafe.Pointer(&data[i]))
        }
        convertResult = RESULT_OK
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export eachElementRowStoreMulPut
func eachElementRowStoreMulPut(dataInput uintptr, arrayElement [][]uintptr) (result int32){
    data := *(*[][]interface{})(unsafe.Pointer(dataInput))
    for i := range data {
        for j := range data[i] {
            if (len(data[i]) != len(arrayElement[i])) {
                result = RESULT_FALSE
                return
            }
            arrayElement[i][j] = (uintptr)(unsafe.Pointer(&(data[i][j])))
        }
    }
    result = RESULT_OK
    return
}

//export lenRow
func lenRow(dataInput uintptr) (lenResult int64) {
    data := *(*[]interface{})(unsafe.Pointer(dataInput))
    lenResult = int64(len(data))
    return
}

//export eachElementRow
func eachElementRow(dataInput uintptr, arrayElement []uintptr) {
    data := *(*[]interface{})(unsafe.Pointer(dataInput))
    for i := range data {
        arrayElement[i] = (uintptr)(unsafe.Pointer(&(data[i])))
    }
    return
}

//export GetInterfaceArrayLength
func GetInterfaceArrayLength(dataInput uintptr, colType int) (length int, convertResult int32) {

    data := (*interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    if (colType == TYPE_STRING || colType == TYPE_GEOMETRY) {
        value, ok := (*data).(string)
        if (ok) {
            length = len(value)
        } else {
            convertResult = RESULT_FALSE
        }
    } else if (colType == TYPE_BLOB) {
        value, ok := (*data).([]byte)
        if (ok) {
            length = len(value)
        } else {
            convertResult = RESULT_FALSE
        }
    } else if (colType == TYPE_STRING_ARRAY) {
        value, ok := (*data).([]string)
        if (ok) {
            length = len(value)
        } else {
            convertResult = RESULT_FALSE
        }
    } else {
        value, ok := (*data).([]interface{})
        if (ok) {
            length = len(value)
        } else {
            convertResult = RESULT_FALSE
        }
    }

    return
}

//export checkNil
func checkNil(dataInput uintptr) (isNil bool) {
    data := (*interface{})(unsafe.Pointer(dataInput))
    if ((*data) == nil) {
        isNil = true
    } else {
        isNil = false
    }
    return
}

//export SetForBlobString
func SetForBlobString(dataInput uintptr, blob []byte) (convertResult int32) {

    data := (*interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    value, ok := (*data).([]byte)
    if (ok) {
        for i := 0; i < len(value); i++ {
            blob[i] = value[i]
        }
    } else {
        s, result := (*data).(string)
        if (result) {
            for i := 0; i < len(s); i++ {
                blob[i] = s[i]
            }
        } else {
            convertResult = RESULT_FALSE
        }
    }
    return
}

//export SetForStringArray
func SetForStringArray(dataInput uintptr, stringArray [][]byte) (convertResult int32) {

    data := (*interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    value, ok := (*data).([]string)
    if (ok) {
        for i := 0; i < len(value); i++ {
            for j := 0; j < len(value[i]); j++ {
                stringArray[i][j] = value[i][j]
            }
        }
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export SetForLongArray
func SetForLongArray(dataInput uintptr, longArray []int64, colType int) (convertResult int32) {

    tmpData := (*interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    data, g := (*tmpData).([]interface{})
    if (g) {
        for i := 0; i < len(data); i++ {
            switch reflect.ValueOf(data[i]).Kind() {
                case reflect.Bool: {
                    if(colType != TYPE_BOOL_ARRAY) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    value, ok := (data[i]).(bool)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    if value {
                        longArray[i] = 1
                    } else {
                        longArray[i] = 0
                    }
                }
                case reflect.Int8: {
                    value, ok := (data[i]).(int8)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    longArray[i] = int64(value)
                }
                case reflect.Int16: {
                    value, ok := (data[i]).(int16)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    longArray[i] = int64(value)
                }
                case reflect.Int32: {
                    value, ok := (data[i]).(int32)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    longArray[i] = int64(value)
                }
                case reflect.Int: {
                    value, ok := (data[i]).(int)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    longArray[i] = int64(value)
                }
                case reflect.Int64: {
                    value, ok := (data[i]).(int64)
                    if(!ok) {
                        convertResult = RESULT_FALSE
                        return
                    }
                    longArray[i] = int64(value)
                }
                default:
                    convertResult = RESULT_FALSE
                    return
            }
        }
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export SetForDoubleArray
func SetForDoubleArray(dataInput uintptr, doubleArray []float64) (convertResult int32) {

    tmpData := (*interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    data, g := (*tmpData).([]interface{})
    if (g) {
        for i := 0; i < len(data); i++ {
            switch reflect.ValueOf(data[i]).Kind() {
            case reflect.Int8: {
                value, ok := (data[i]).(int8)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Int16: {
                value, ok := (data[i]).(int16)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Int32: {
                value, ok := (data[i]).(int32)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Int: {
                value, ok := (data[i]).(int)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Int64: {
                value, ok := (data[i]).(int64)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Float32: {
                value, ok := (data[i]).(float32)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = float64(value)
            }
            case reflect.Float64: {
                value, ok := (data[i]).(float64)
                if(!ok) {
                    convertResult = RESULT_FALSE
                }
                doubleArray[i] = value
            }
            default:
                convertResult = RESULT_FALSE
                return
            }
        }
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export GetNumericInterface
func GetNumericInterface(dataInput uintptr, colType int) (
        mType int32,
        asLong int64,
        asDouble float64,
        convertResult int32) {

    data := (*interface{})(unsafe.Pointer(dataInput))

    switch colType {
    case TYPE_BOOL, TYPE_BYTE, TYPE_SHORT, TYPE_INTEGER, TYPE_LONG: {
        convertResult = RESULT_OK
        mType = TYPE_LONG
        {
            value, ok := (*data).(bool)
            if (ok) {
                if (colType != TYPE_BOOL) {
                    convertResult = RESULT_FALSE
                }
                if asLong = 0; value {
                    asLong = 1
                }
                return
            }
        }
        {
            value, ok := (*data).(int8)
            if (ok) {
                asLong = (int64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int16)
            if (ok) {
                asLong = (int64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int32)
            if (ok) {
                asLong = (int64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int)
            if (ok) {
                asLong = (int64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int64)
            if (ok) {
                asLong = (int64)(value)
                return
            }
        }
        convertResult = RESULT_FALSE
        return
    }
    case TYPE_FLOAT, TYPE_DOUBLE:
        convertResult = RESULT_OK
        mType = TYPE_DOUBLE
        {
            value, ok := (*data).(int8)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int16)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int32)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(int64)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(float32)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        {
            value, ok := (*data).(float64)
            if (ok) {
                asDouble = (float64)(value)
                return
            }
        }
        convertResult = RESULT_FALSE
        return
    case TYPE_TIMESTAMP:
        convertResult = RESULT_OK
        mType = TYPE_LONG
        // cast for numerical input
        {
            value, ok := (*data).(int8)
            if (ok) {
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            value, ok := (*data).(int16)
            if (ok) {
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            value, ok := (*data).(int32)
            if (ok) {
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            value, ok := (*data).(int)
            if (ok) {
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            value, ok := (*data).(int64)
            if (ok) {
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            value, ok := (*data).(float32)
            if (ok) {
                tmp := value * MILI_SECOND
                if (tmp > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                } else {
                    asLong = (int64)(tmp)
                }
                return
            }
        }
        {
            value, ok := (*data).(float64)
            if (ok) {
                tmp := value * MILI_SECOND
                if (tmp > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                } else {
                    asLong = (int64)(tmp)
                }
                return
            }
        }
        {
            // cast for datetime input
            value, ok := (*data).(time.Time)
            if (ok) {
                asLong   = value.Unix() // get second
                tmpMili := int64(value.Nanosecond() / 1000000) // get mili second for timestamp
                asLong   = asLong * 1000 + tmpMili
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        }
        {
            // cast for string input
            value, ok := (*data).(string)
            if (ok) {
                mType = TYPE_STRING
                asLong = int64(len(value))
                return
            }
        }
        convertResult = RESULT_FALSE
        return
    default:
        convertResult = RESULT_FALSE
        return
    }

    return
}

//export lenColumnName
func lenColumnName(dataInput uintptr) (lenName int64, convertResult int32) {
    data := *(*[]interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    if (len(data) <= 0) {
        convertResult = RESULT_FALSE
        return
    }
    value, ok := (data[0]).(string)
    if (ok) {
        lenName = (int64)(len(value))
    } else {
        convertResult = RESULT_FALSE
    }
    return
}

//export getColumnInfo
func getColumnInfo(dataInput uintptr, colName []byte) (mType int64, option int64, convertResult int32) {
    data := *(*[]interface{})(unsafe.Pointer(dataInput))
    convertResult = RESULT_OK
    if (len(data) <= 0 || len(data) >= 4) {
        convertResult = RESULT_FALSE
        return
    }
    value, ok := (data[0]).(string)
    if (ok) {
        for i := 0; i < len(value); i++ {
            colName[i] = value[i]
        }
        mType = int64(data[1].(int))
        if (len(data) == 3) {
            option = int64(data[2].(int))
        } else {
            option = 0
        }
    } else {
        convertResult = RESULT_FALSE
    }
    return
}
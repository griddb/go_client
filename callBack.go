package griddb_go

// #cgo CXXFLAGS: -DGRIDDB_GO -std=c++0x
// #cgo LDFLAGS: -lrt -lgridstore
import "C"

import (
    "unsafe"
    "time"
)

const (
    RESULT_OK    = 0
    RESULT_FALSE = -1
)
const (
    UTC_TIMESTAMP_MILI_MAX = 253402300799999
    MILI_SECOND            = 1000
)
const (
    TYPE_OPTION_NULLABLE = 2
    TYPE_OPTION_NOT_NULL = 4
)
const (
    INDEX_FLAG_DEFAULT = -1
    INDEX_FLAG_TREE    = 1
    INDEX_FLAG_HASH    = 2
    INDEX_FLAG_SPATIAL = 4
)
const (
    FETCH_OPTION_LIMIT_MAX  = 2147483647
    FETCH_LIMIT             = 0
    FETCH_SIZE              = 1
    FETCH_PARTIAL_EXECUTION = 2
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
    // TYPE_STRING_ARRAY
    // TYPE_BOOL_ARRAY
    // TYPE_BYTE_ARRAY
    // TYPE_SHORT_ARRAY
    // TYPE_INTEGER_ARRAY
    // TYPE_LONG_ARRAY
    // TYPE_FLOAT_ARRAY
    // TYPE_DOUBLE_ARRAY
    // TYPE_TIMESTAMP_ARRAY
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

//export eachElementRowStoreMulPut
func eachElementRowStoreMulPut(dataInput uintptr, arrayElement [][]uintptr) (result int32){
    data := *(*[][]interface{})(unsafe.Pointer(dataInput))
    if (len(data) != len(arrayElement)) {
        result = RESULT_FALSE
        return
    }
    for i := range data {
        if (data[i] == nil) {
            result = RESULT_FALSE
            return
        }

        if (len(data[i]) != len(arrayElement[i])) {
            result = RESULT_FALSE
            return
        }
        for j := range data[i] {   
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
    // } else if (colType == TYPE_STRING_ARRAY) {
    //     value, ok := (*data).([]string)
    //     if (ok) {
    //         length = len(value)
    //     } else {
    //         convertResult = RESULT_FALSE
    //     }
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
        switch (*data).(type) {
        case bool:
            {
                value, _ := (*data).(bool)
                if (colType != TYPE_BOOL) {
                    convertResult = RESULT_FALSE
                }
                if asLong = 0; value {
                    asLong = 1
                }
                return
            }
        case int8:
            {
                asLong = (int64)((*data).(int8))
                return
            }
        case int16:
            {
                asLong = (int64)((*data).(int16))
                return
            }
        case int32:
            {
                asLong = (int64)((*data).(int32))
                return
            }
        case int:
            {
                asLong = (int64)((*data).(int))
                return
            }
        case int64:
            {
                asLong = (int64)((*data).(int64))
                return
            }
        default:
            convertResult = RESULT_FALSE
            return
        }
    }
    case TYPE_FLOAT, TYPE_DOUBLE: {
        convertResult = RESULT_OK
        mType = TYPE_DOUBLE
        switch (*data).(type) {
        case int8: 
            {
                asDouble = (float64)((*data).(int8))
                return
            }
        case int16:
            {
                asDouble = (float64)((*data).(int16))
                return
            }
        case int32:
            {
                asDouble = (float64)((*data).(int32))
                return
            }
        case int:
            {
                asDouble = (float64)((*data).(int))
                return
            }
        case int64:
            {
                asDouble = (float64)((*data).(int64))
                return
            }
        case float32:
            {
                asDouble = (float64)((*data).(float32))
                return
            }
        case float64:
            {
                asDouble = (float64)((*data).(float64))
                return
            }
        default:
            convertResult = RESULT_FALSE
            return
        }
    }
    case TYPE_TIMESTAMP: {
        convertResult = RESULT_OK
        mType = TYPE_LONG
        switch (*data).(type) {
        // cast for numerical input
        case int8:
            {
                value, _ := (*data).(int8)
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case int16:
            {
                value, _ := (*data).(int16)
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case int32:
            {
                value, _ := (*data).(int32)
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case int:
            {
                value, _ := (*data).(int)
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case int64:
            {
                value, _ := (*data).(int64)
                asLong = (int64)(value) * MILI_SECOND
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case float32:
            {
                value, _ := (*data).(float32)
                tmp := value * MILI_SECOND
                if (tmp > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                } else {
                    asLong = (int64)(tmp)
                }
                return
            }
        case float64:
            {
                value, _ := (*data).(float64)
                tmp := value * MILI_SECOND
                if (tmp > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                } else {
                    asLong = (int64)(tmp)
                }
                return
            }
        case time.Time:
            {
                // cast for datetime input
                value, _ := (*data).(time.Time)
                asLong   = value.Unix() // get second
                tmpMili := int64(value.Nanosecond() / 1000000) // get mili second for timestamp
                asLong   = asLong * 1000 + tmpMili
                if (asLong > UTC_TIMESTAMP_MILI_MAX) {
                    convertResult = RESULT_FALSE
                }
                return
            }
        case string:
            {
                // cast for string input
                value, _ := (*data).(string)
                mType = TYPE_STRING
                asLong = int64(len(value))
                return
            }
        default:
            convertResult = RESULT_FALSE
            return
        }
    }
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
    if (len(data) != 2 && len(data) != 3) {
        convertResult = RESULT_FALSE
        return
    }
    value, ok := (data[0]).(string)
    if (!ok) {
        convertResult = RESULT_FALSE
        return
    }
    for i := 0; i < len(value); i++ {
        colName[i] = value[i]
    }
    mTypeTmp, ok2 := data[1].(int)
    if (!ok2) {
        convertResult = RESULT_FALSE
        return
    }
    mType = int64(mTypeTmp)
    if (len(data) == 3) {
        optionTmp, ok3 := data[2].(int)
        if (!ok3) {
            convertResult = RESULT_FALSE
            return
        }
        option = int64(optionTmp)
    } else {
        option = 0
    }
    return
}
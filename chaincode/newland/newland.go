/********************************************
 * Copyright Newland Corp All Rights Reserved
*********************************************/

package main

import (
	"fmt"
    "bytes"
    "strconv"
    "time"

	"github.com/hyperledger/fabric-chaincode-go/shim"
	"github.com/hyperledger/fabric-protos-go/peer"
)

type Newland struct {
}

func (t *Newland) Init(stub shim.ChaincodeStubInterface) peer.Response {
    // 做些初始化的动作...
	return shim.Success(nil)
}

func (t *Newland) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	fn, args := stub.GetFunctionAndParameters()

	var result string
	var err error

	if fn == "SetData" {
		result, err = set(stub, args)
    } else if fn == "GetData" {
		result, err = get(stub, args)
    } else if fn == "GetHistory" {
		result, err = getHistory(stub, args)
	} else {
		return shim.Error(err.Error())
	}

	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success([]byte(result))
}

// 记录数据 
func set(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 2 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key and a value")
	}

	err := stub.PutState(args[0], []byte(args[1]))
	if err != nil {
		return "", fmt.Errorf("Failed to set asset: %s", args[0])
	}
	return args[1], nil
}

// 获取数据
func get(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 1 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key")
	}

	value, err := stub.GetState(args[0])
	if err != nil {
		return "", fmt.Errorf("Failed to get asset: %s with error: %s", args[0], err)
	}
	if value == nil {
		return "", fmt.Errorf("Asset not found: %s", args[0])
	}
	return string(value), nil
}

func getHistory(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 1 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key")
	}

	iterator, err := stub.GetHistoryForKey(args[0])
	if err != nil {
		return "", fmt.Errorf("Failed to get History: %s with error: %s", args[0], err)
	}

	iterator.Close()

	var buffer bytes.Buffer
	buffer.WriteString("[")
	bArrayMemberAlreadyWritten := false
	for iterator.HasNext() {
		queryResponse, err := iterator.Next()
		if err != nil {
			shim.Error(err.Error())
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"TxId\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.TxId)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Value\":")
		// if it was a delete operation on given key, then we need to set the
		//corresponding value null. Else, we will write the response.Value
		if queryResponse.IsDelete {
			buffer.WriteString("null")
		} else {
			buffer.WriteString("\"")
			buffer.WriteString(string(queryResponse.Value))
			buffer.WriteString("\"")
		}

		buffer.WriteString(", \"Timestamp\":")
		buffer.WriteString("\"")
		buffer.WriteString(time.Unix(queryResponse.Timestamp.Seconds, int64(queryResponse.Timestamp.Nanos)).String())
		buffer.WriteString("\"")

		buffer.WriteString(", \"IsDelete\":")
		buffer.WriteString("\"")
		buffer.WriteString(strconv.FormatBool(queryResponse.IsDelete))
		buffer.WriteString("\"")

		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")


	return buffer.String(), nil
}
func main() {
	if err := shim.Start(new(Newland)); err != nil {
		fmt.Printf("Error starting SimpleAsset chaincode: %s", err)
	}
}

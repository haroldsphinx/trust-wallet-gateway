package main

import (
	"bytes"
	"encoding/json"
	"log"
	"net/http"
	"fmt"
	"os"
)

type RpcRequestPayload struct {
	JSONRPC string        `json:"jsonrpc"`
	Method  string        `json:"method"`
	Params  []interface{} `json:"params"`
	ID      int           `json:"id"`
}

type RpcResponsePayload struct {
	JSONRPC string      `json:"jsonrpc"`
	ID      int         `json:"id"`
	Result  interface{} `json:"result"`
}

var RpcURL string


func getBlockNumber(w http.ResponseWriter, r *http.Request) {
	requestBody := RpcRequestPayload{
		JSONRPC: "2.0",
		Method:  "eth_blockNumber",
		ID:      1,
	}

	responseBody, err := postRPCRequest(requestBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(responseBody)
}

func getBlockByNumber(w http.ResponseWriter, r *http.Request) {
	requestBody := RpcRequestPayload{
		JSONRPC: "2.0",
		Method:  "eth_getBlockByNumber",
		Params: []interface{}{
			"0x134e82a",
			true,
		},
		ID: 2,
	}

	responseBody, err := postRPCRequest(requestBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(responseBody)
}

func postRPCRequest(requestBody RpcRequestPayload) (RpcResponsePayload, error) {
	RpcURL := os.Getenv("RPC_URL")
	log.Println("RPC_URL: ", RpcURL)

	if RpcURL == "" {
		log.Fatal("RPC_URL environment variable is not set")
	}

	requestBytes, err := json.Marshal(requestBody)
	if err != nil {
		return RpcResponsePayload{}, err
	}

	resp, err := http.Post(RpcURL, "application/json", bytes.NewBuffer(requestBytes))
	if err != nil {
		return RpcResponsePayload{}, err
	}
	defer resp.Body.Close()

	var responseBody RpcResponsePayload
	err = json.NewDecoder(resp.Body).Decode(&responseBody)
	if err != nil {
		return RpcResponsePayload{}, err
	}

	return responseBody, nil
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "TrustWallet RPC Gateway!")
	})

	http.HandleFunc("/getBlock", getBlockNumber)
	http.HandleFunc("/getBlockByNumber", getBlockByNumber)

	port := os.Getenv("APP_PORT")
	if port == "" {
		port = "3000"
	}

	log.Println("Gateway listening on port 3000...")
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
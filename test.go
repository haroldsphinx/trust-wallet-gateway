package main

import (
        "net/http"
        "testing"
        "encoding/json"
        "net/http/httptest"

)

func Test_getBlockNumber(t *testing.T) {
        req, err := http.NewRequest("GET", "/getBlock", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(GetBlockNumber)

	handler.ServeHTTP(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	var response RpcResponsePayload
	err = json.Unmarshal(rr.Body.Bytes(), &response)
	if err != nil {
		t.Errorf("error decoding JSON response: %v", err)
	}
}

func Test_getBlockByNumber(t *testing.T) {
        req, err := http.NewRequest("GET", "/getBlockByNumber", nil)
        if err != nil {
                t.Fatal(err)
        }

        rr := httptest.NewRecorder()
        handler := http.HandlerFunc(GetBlockByNumber)

        handler.ServeHTTP(rr, req)

        if status := rr.Code; status != http.StatusOK {
                t.Errorf("handler returned wrong status code: got %v want %v",
                        status, http.StatusOK)
        }

        var response RpcResponsePayload
        err = json.Unmarshal(rr.Body.Bytes(), &response)
        if err != nil {
                t.Errorf("error decoding JSON response: %v", err)
        }
}


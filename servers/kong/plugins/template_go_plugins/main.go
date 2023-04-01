package main

import (
	"github.com/Kong/go-pdk"
	"github.com/Kong/go-pdk/server"
)

type MyPlugin struct {
}

// New
// This function is called when your plugin is initialized by Kong. It should return a new instance of your plugin.
func New() interface{} {
	return &MyPlugin{}
}

// Access
// This function is called for each incoming API request.
// It's where you can modify the request before it's sent to the upstream server,
// or modify the response before it's sent back to the client.
func (conf *MyPlugin) Access(kong *pdk.PDK) {
	kong.Response.SetHeader("X-My-Plugin", "Hello from my custom Go plugin")
	kong.Log.Info("Hello from MyPlugin Access")
}

// HeaderFilter
// This function is called for each incoming API request, after Access.
// It's where you can modify the headers in the request or response.
func (conf *MyPlugin) HeaderFilter(kong *pdk.PDK) {
	kong.Log.Info("Hello from MyPlugin HeaderFilter")
}

// BodyFilter
// This function is called for each incoming API request, after HeaderFilter.
// It's where you can modify the body of the request or response.
func (conf *MyPlugin) BodyFilter(kong *pdk.PDK) {
	kong.Log.Info("Hello from MyPlugin BodyFilter")
}

// Log
// This function is called after the request has completed.
// It's where you can log information about the request and response.
func (conf *MyPlugin) Log(kong *pdk.PDK) {
	kong.Log.Info("Hello from MyPlugin Log")
}

func main() {
	server.StartServer(New, "0.1", 1)
}

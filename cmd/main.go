package main

import "github.com/jmechavez/emaillist-v3/internal"

func main() {
	// Start the HTTP server
	// This function will initialize the server and its routes
	// It will also handle any necessary middleware or configuration
	internal.Start()
}

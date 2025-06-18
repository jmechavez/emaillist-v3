package internal

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/jmechavez/emaillist-v3/web/templates/pages"
)

func Start() {
	r := mux.NewRouter()

	// Serve static files - Fixed to match template paths
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("web/static"))))

	// Home page
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		pages.Home().Render(r.Context(), w)
	})

	r.HandleFunc("/dashboard", func(w http.ResponseWriter, r *http.Request) {
		pages.Dashboard().Render(r.Context(), w)
	})

	log.Println("Server running at http://localhost:8082")
	log.Fatal(http.ListenAndServe(":8082", r))
}



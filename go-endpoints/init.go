package main

import (
	"github.com/GoogleCloudPlatform/go-endpoints/endpoints"
	//"github.com/pamescan/greeting-crud-example/go-endpoints/services"
)

/////////////////////////////////////////
//
// INIT
//
func init() {
	greetService := &GreetingService{}

	api, err := endpoints.RegisterService(greetService, "greeting", "v1", "Greetings API", true)
	if err != nil {
		panic(err.Error())
	}

	info := api.MethodByName("List").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "greets.list", "GET", "greetings", "Obtiene un listado."

	info = api.MethodByName("Create").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "greets.create", "PUT", "greetings", "Crea entidad"

	info = api.MethodByName("Update").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "greets.update", "POST", "greetings/{id}", "Modifica entidad"

	info = api.MethodByName("Destroy").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "greets.destroy", "DELETE", "greetings/{id}", "Elimina entidad"

	info = api.MethodByName("Show").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "greets.show", "GET", "greetings/{id}", "Obtiene una entidad"

	//endpoints.HandleHTTP()

	/////////////////////////////////////////
	//
	// INIT books
	//

	bookservice := &BookService{}

	api, err = endpoints.RegisterService(bookservice, "Book", "v1", "Books API", true)
	if err != nil {
		panic(err.Error())
	}

	info = api.MethodByName("List").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "books.list", "GET", "Books", "Obtiene un listado."

	info = api.MethodByName("Create").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "books.create", "PUT", "Books", "Crea entidad"

	info = api.MethodByName("Update").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "books.update", "POST", "Books/{id}", "Modifica entidad"

	info = api.MethodByName("Destroy").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "books.destroy", "DELETE", "Books/{id}", "Elimina entidad"

	info = api.MethodByName("Show").Info()
	info.Name, info.HTTPMethod, info.Path, info.Desc = "books.show", "GET", "Books/{id}", "Obtiene una entidad"

	endpoints.HandleHTTP()
}

// Greeting is a datastore entity that represents a single greeting.
// It also serves as (a part of) a response of GreetingService.
package main

import (
	"appengine/datastore"

	"github.com/GoogleCloudPlatform/go-endpoints/endpoints"
	"net/http"
	"time"
)

/////////////////////////////
//
//	Definición de los datos
//

// entidad base de saludo
type Greeting struct {
	Key     *datastore.Key `json:"id" datastore:"-"`
	Author  string         `json:"author"`
	Content string         `json:"content" datastore:",noindex" endpoint:"req"`
	Date    time.Time      `json:"date"`
}

// respuesta del metodo de listado de saludos
type GreetingsList struct {
	Items []*Greeting `json:"items"`
}

type GreetingsListReq struct {
	Limit int `json:"limit" endpoint:"d=10"`
}

// modelo para la insercción de nuevo dato
type GreetingReq struct {
	Author  string
	Content string
}

// modelo de respuesta en la eliminación
type GreetingsD struct {
}

//modelo parametro eliminación
type GreetingReqId struct {
	Key *datastore.Key `json:"id"`
}

////////////////////////////
//
//	Servicio
//

type GreetingService struct {
}

//List responde con una lista  ordenados por fecha
func (gs *GreetingService) List(r *http.Request, req *GreetingsListReq, resp *GreetingsList) error {

	// corrección del limite de elementos a rescatar
	if req.Limit <= 0 {
		req.Limit = 10
	}
	//Crea un nuevo contexto para comunicarse con con el servicio de app engine
	c := endpoints.NewContext(r)
	// genera una query
	q := datastore.NewQuery("Greeting").Order("-Date").Limit(req.Limit)
	greets := make([]*Greeting, 0, req.Limit)
	keys, err := q.GetAll(c, &greets)
	if err != nil {
		return err
	}

	for i, k := range keys {
		greets[i].Key = k
	}
	resp.Items = greets

	return nil
}

// Inserta nueva entidad y devuelve la entidad insertada como respuesta correcta
func (gs *GreetingService) Create(r *http.Request, req *GreetingReq, resp *Greeting) error {

	// nuevo contexto
	c := endpoints.NewContext(r)

	// se monta el paquete conla información
	resp.Author = req.Author
	resp.Content = req.Content
	resp.Date = time.Now()
	// se carga el dato con la key que nos devuelve a partir de  una llamada a la entidad, para que quede almacenada en el mismo grupo de entidades
	key, err := datastore.Put(c, datastore.NewIncompleteKey(c, "Greeting", nil), resp)
	if err != nil {
		return err
	}
	resp.Key = key
	return nil
}

//borrar entidad
func (gs *GreetingService) Destroy(r *http.Request, req *GreetingReqId, resp *GreetingsD) error {

	c := endpoints.NewContext(r)
	if err := datastore.Delete(c, req.Key); err != nil {
		return err
	}

	return nil
}

//modificar entidad
func (gs *GreetingService) Update(r *http.Request, req *Greeting, resp *Greeting) error {
	// nuevo contexto
	c := endpoints.NewContext(r)
	// se monta el paquete conla información
	resp.Author = req.Author
	resp.Content = req.Content
	resp.Date = time.Now()
	// se carga el dato con la key que nos devuelve a partir de una llamada a la entidad, para que quede almacenada en el mismo grupo de entidades
	key, err := datastore.Put(c, req.Key, resp)
	if err != nil {
		return err
	}
	resp.Key = key
	return nil

}

func (gs *GreetingService) Show(r *http.Request, req *GreetingReqId, resp *Greeting) error {
	c := endpoints.NewContext(r)

	if err := datastore.Get(c, req.Key, resp); err != nil {
		return err
	}

	return nil
}

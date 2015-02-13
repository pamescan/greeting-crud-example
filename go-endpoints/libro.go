// Book is a datastore entity that represents a single Book.
// It also serves as (a part of) a response of BookService.

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

// entidad Libro a guardar en el datastore
type Book struct {
	Key           *datastore.Key `json:"id" datastore:"-"`
	Title         string         `json:"title" endpoint:"req"`
	Author        string         `json:"author"`
	Content       string         `json:"content" datastore:",noindex" endpoint:"req"`
	Image         string         `json:"urlImage"`
	PublishedDate time.Time      `json:"publishedDate" datastore:"-"`
	ModifiedDate  time.Time      `json:"lastModifiedDate" datastore:"-"`
}

// respuesta del metodo de listado de libros
type BooksList struct {
	Items []*Book `json:"items"`
}

type BooksListReq struct {
	Limit int `json:"limit" endpoint:"d=10"`
}

// modelo para la insercción de nuevo dato
type BookReq struct {
	Title         string
	Author        string
	Content       string
	Image         string
	PublishedDate time.Time
}

type BooksD struct {
}

//modelo parametro eliminación
type BookReqId struct {
	Key *datastore.Key `json:"id"`
}

////////////////////////////
//
//	Servicio
//

type BookService struct {
}

//List responde con una lista  ordenados por fecha
func (gs *BookService) List(r *http.Request, req *BooksListReq, resp *BooksList) error {

	// corrección del limite de elementos a rescatar
	if req.Limit <= 0 {
		req.Limit = 10
	}
	//Crea un nuevo contexto para comunicarse con con el servicio de app engine
	c := endpoints.NewContext(r)
	// genera una query
	q := datastore.NewQuery("Book").Order("-Title").Limit(req.Limit)
	books := make([]*Book, 0, req.Limit)
	keys, err := q.GetAll(c, &books)
	if err != nil {
		return err
	}

	for i, k := range keys {
		books[i].Key = k
	}
	resp.Items = books

	return nil
}

// Inserta nueva entidad y devuelve la entidad insertada como respuesta correcta
func (gs *BookService) Create(r *http.Request, req *BookReq, resp *Book) error {

	// nuevo contexto
	c := endpoints.NewContext(r)

	// se monta el paquete conla información
	resp.Title = req.Title
	resp.Author = req.Author
	resp.Content = req.Content
	resp.Image = req.Image
	resp.PublishedDate = req.PublishedDate
	resp.ModifiedDate = time.Now()
	// se carga el dato con la key que nos devuelve a partir de  una llamada a la entidad, para que quede almacenada en el mismo grupo de entidades
	key, err := datastore.Put(c, datastore.NewIncompleteKey(c, "Book", nil), resp)
	if err != nil {
		return err
	}
	resp.Key = key
	return nil
}

//borrar entidad
func (gs *BookService) Destroy(r *http.Request, req *BookReqId, resp *BooksD) error {

	c := endpoints.NewContext(r)
	if err := datastore.Delete(c, req.Key); err != nil {
		return err
	}
	return nil
}

//modificar entidad
func (gs *BookService) Update(r *http.Request, req *Book, resp *Book) error {
	// nuevo contexto
	c := endpoints.NewContext(r)
	// se monta el paquete conla información
	resp.Title = req.Title
	resp.Author = req.Author
	resp.Content = req.Content
	resp.Image = req.Image
	resp.PublishedDate = req.PublishedDate
	resp.ModifiedDate = time.Now()
	// se carga el dato con la key que nos devuelve a partir de una llamada a la entidad, para que quede almacenada en el mismo grupo de entidades
	key, err := datastore.Put(c, req.Key, resp)
	if err != nil {
		return err
	}
	resp.Key = key
	return nil

}

func (gs *BookService) Show(r *http.Request, req *BookReqId, resp *Book) error {
	c := endpoints.NewContext(r)

	if err := datastore.Get(c, req.Key, resp); err != nil {
		return err
	}

	return nil
}

/*
/////////////////////////////////////////
//
// INIT
//
func init() {
	bookservice := &BookService{}

	api, err := endpoints.RegisterService(bookservice, "Book", "v1", "Books API", true)
	if err != nil {
		panic(err.Error())
	}

	info := api.MethodByName("List").Info()
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
*/

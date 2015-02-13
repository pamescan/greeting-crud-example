import 'package:polymer/polymer.dart';
import 'book/v1.dart';
import 'dart:html' show Event, Node;

import 'package:http/browser_client.dart' show BrowserClient;
@CustomTag('list-book')
class ListBook extends PolymerElement {

  @observable Book newBook = new Book();
  @observable List<Book> books = toObservable([]);

//  @observable List<Book>orderBooks =toObservable([]);

  ListBook.created() : super.created() {
    BookApi api = new BookApi(new BrowserClient());
    api.books.list().then((BooksList list) {
      if (list.items != null) for (var item in list.items) books.add(item);

    }).catchError(error);

  }

  void loadNew(Event e) {
    //books = null;

    BookApi api = new BookApi(new BrowserClient());
    api.books.list().then((BooksList list) {
      //list.items.forEach((Book g) => addToDom(g));
      books = list.items;

    }).catchError((e) {
      //querySelector('#error-message').innerHtml = e.toString();

    });
  }
  //
  void msg(e) {
    print(e.toString());
    /*querySelector('#error-message')
            ..hidden=false
            ..text=e.toString();*/

  }

  // Error
  void error(e) {
    print(e.toString());

    /*querySelector('#error-message')
        ..hidden=false
        ..text=e.toString();*/
  }

  //
  resetForm() {
    newBook = new Book();

  }

  //////////////////////////////////////
  //
  // Gestión de los evento de los hijos
  //
  createBook(Event e, var detail, Node sender) {
    e.preventDefault();
    // el tipo de datos esperado por el servcio de creación es un struct con dos string
    BookReq req = new BookReq.fromJson({
      'Author': detail['book'].author,
      'Content': detail['book'].content
    });

    //llamada al servicio
    BookApi api = new BookApi(new BrowserClient());
    api.books.create(req).then((Book g) {
      books.add(g);

    }).catchError(error);

    resetForm();

  }
  //
  deleteBook(Event e, var detail, Node sender) {
    e.preventDefault();
    BookApi api = new BookApi(new BrowserClient());
    api.books.destroy(detail['book'].id).then((Book g) {
      //print(detail['book'].id);

    }).catchError(error);

    books.remove(detail['book']);

  }
}

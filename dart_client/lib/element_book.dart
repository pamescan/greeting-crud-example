import 'dart:html';
import 'package:polymer/polymer.dart';
import 'book/v1.dart';
import 'package:http/browser_client.dart' show BrowserClient;

@CustomTag('element-book')
class BookElement extends PolymerElement {
  @published Book book;
  @observable bool editing = false;

  Book _cachedBook;

  BookElement.created() : super.created();
// Operativas sobre los elementos

  updateCodelab(Event e, var detail, Node sender) {
    e.preventDefault();
    editing = false;
    // Actualización en servicio
    BookApi api = new BookApi(new BrowserClient());
    api.books.update(book, book.id).then((Book g) {
    });

  }

  startEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    _cachedBook = new Book();
    copyCodelab(book, _cachedBook);
    editing = true;

  }

  cancelEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    copyCodelab(_cachedBook, book);
    editing = false;
  }

  deleteBook(Event e, var detail, Node sender) {
    e.preventDefault();
    dispatchEvent(new CustomEvent('deletebook', detail: {
      'book': book
    }));

  }
  copyCodelab(source, destination) {
    destination.title = source.title;
    destination.author = source.author;
    destination.content = source.content;
    destination.urlImage= source.urlImage;
    destination.publishedDate = source.publishedDate;

  }


}

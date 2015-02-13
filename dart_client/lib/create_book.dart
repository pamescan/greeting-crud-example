import'dart:html';
import 'package:polymer/polymer.dart';
import 'book/v1.dart';
/// A Polymer `<create-book>` element.

@CustomTag('create-book')
class CreateBook extends PolymerElement {
@published Book book;
  CreateBook.created():super.created(){}


  void create(Event e, var detail, Node sender){

    e.preventDefault();
    dispatchEvent(new CustomEvent('createbook',detail:{'book':book}));

  }

}
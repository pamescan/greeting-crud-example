import 'package:polymer/polymer.dart';
import 'greeting/v1.dart';
import 'dart:html' show Event, Node;

import 'package:http/browser_client.dart' show BrowserClient;

@CustomTag('list-greeting')
class ListGreeting extends PolymerElement {

  @observable Greeting newGreeting = new Greeting();
  @observable List<Greeting> greetings = toObservable([]);

//  @observable List<Greeting>orderGreetings =toObservable([]);

  ListGreeting.created() : super.created() {
    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.list().then((GreetingsList list) {
if(list.items!=null)
      for (var item in list.items) greetings.add(item);

    }).catchError(error);

  }




//al cargar
  /*ready() {
    super.ready();
    //greetings = null;

    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.list().then((GreetingsList list) {
      greetings = list.items;

    }) ;
  }*/

//equivalente al pulsar el botón
  //'hardcodeado' la carga de contactos... debe ir en un evento
  //var _loadButton;
  void loadNew(Event e) {
    //greetings = null;

    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.list().then((GreetingsList list) {
      //list.items.forEach((Greeting g) => addToDom(g));
      greetings = list.items;

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
    newGreeting = new Greeting();

  }

  //////////////////////////////////////
  //
  // Gestión de los evento de los hijos
  //
  createGreeting(Event e, var detail, Node sender) {
    e.preventDefault();
    // el tipo de datos esperado por el servcio de creación es un struct con dos string
    GreetingReq req = new GreetingReq.fromJson({
      'Author': detail['greeting'].author,
      'Content': detail['greeting'].content
    });

    //llamada al servicio
    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.create(req).then((Greeting g){
      print(g.author);
      print(g.date);
      greetings.add(g);

    }).catchError(error);
    //print(detail['greeting']);
//    greetings.add(detail['greeting']);

    resetForm();

  }
  //
  deleteGreeting(Event e, var detail, Node sender) {
    e.preventDefault();
    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.destroy(detail['greeting'].id).then((Greeting g) {
      //print(detail['greeting'].id);

    }).catchError(error);

    greetings.remove(detail['greeting']);

  }

}

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'greeting/v1.dart';
import 'package:http/browser_client.dart' show BrowserClient;

@CustomTag('element-greeting')
class GreetingElement extends PolymerElement {
  @published Greeting greeting;
  @observable bool editing = false;

  Greeting _cachedGreeting;

  GreetingElement.created() : super.created();
// Operativas sobre los elementos

  updateCodelab(Event e, var detail, Node sender) {
    e.preventDefault();
    editing = false;
    // Actualización en servicio
    GreetingApi api = new GreetingApi(new BrowserClient());
    api.greets.update(greeting, greeting.id).then((Greeting g) {
    });

  }

  startEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    _cachedGreeting = new Greeting();
    copyCodelab(greeting, _cachedGreeting);
    editing = true;

  }

  cancelEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    copyCodelab(_cachedGreeting, greeting);
    editing = false;
  }

  deleteGreeting(Event e, var detail, Node sender) {
    e.preventDefault();
    dispatchEvent(new CustomEvent('deletegreeting', detail: {
      'greeting': greeting
    }));

  }
  copyCodelab(source, destination) {

    destination.author = source.author;
    destination.content = source.content;
    destination.date = source.date;

  }


}

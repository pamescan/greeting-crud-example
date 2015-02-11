import'dart:html';
import 'package:polymer/polymer.dart';
import 'greeting/v1.dart';
/// A Polymer `<create-greeting>` element.

@CustomTag('create-greeting')
class CreateGreeting extends PolymerElement {
  @published Greeting greeting;

  /// Constructor used to create instance of MainApp.
  CreateGreeting.created() : super.created();

  void create(Event e, var detail, Node sender){

    e.preventDefault();
    dispatchEvent(new CustomEvent('creategreeting',detail:{'greeting':greeting}));

  }


  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}

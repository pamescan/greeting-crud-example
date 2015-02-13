import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_tabs.dart';
import 'package:paper_elements/paper_tab.dart';

/// A Polymer `<main-app>` element.

@CustomTag('main-app')
class MainApp extends PolymerElement {
  @observable int selectedTab;

  MainApp.created() : super.created() {
    selectedTab = 1;
  }




}

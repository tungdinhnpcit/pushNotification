import 'package:flutter/material.dart';
import 'package:mba_ex01/main.dart';

import '../page/ViewPage.dart';

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => MyApp());
      case '/viewPage':
        return MaterialPageRoute(builder: (context) => ViewPage());

      default:
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Center(
            child: Text("Not found ${settings.name}"),
          ),
        ));
    }
  }
}
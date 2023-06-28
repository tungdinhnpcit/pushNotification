import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ViewPage'),
          brightness: Brightness.dark,
        ),
        body: Column(
          children: [Text('Content')],
        ));
  }
}
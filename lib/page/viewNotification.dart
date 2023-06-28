import 'package:flutter/material.dart';

import '../model/screen_argument_model.dart';

class ViewNotificationPage extends StatefulWidget {
  @override
  State<ViewNotificationPage> createState() => _ViewNotificationPage();
}

class _ViewNotificationPage extends State<ViewNotificationPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ViewNotificationArguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('${args.title}'),
          brightness: Brightness.dark,
        ),
        body: Column(
          children: [Text('${args.message}')],
        ));
  }
}

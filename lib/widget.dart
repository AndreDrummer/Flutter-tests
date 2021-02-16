import 'package:flutter/material.dart';

class WidgetForTest extends StatelessWidget {
  const WidgetForTest({
    this.title,
    this.message,
  });

  final String title;
  final String message;

  Widget childWidget() {
    return Container(
      key: ValueKey('containerWithUSB'),
      child: Icon(Icons.usb_rounded),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            Container(
              key: ValueKey('containerWithUSB'),
              child: Icon(Icons.usb_rounded),
            )
          ],
        ),
      ),
    );
  }
}

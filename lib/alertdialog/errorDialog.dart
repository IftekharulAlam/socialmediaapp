import 'package:flutter/material.dart';

Future<dynamic> errordialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, StateSetter setState) {
        return AlertDialog(
          title: const Column(
            children: [
              Icon(Icons.error, size: 30.0),
              Text("Error"),
            ],
          ),
          content: Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      });
    },
  );
}

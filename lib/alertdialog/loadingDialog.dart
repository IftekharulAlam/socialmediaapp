import 'package:flutter/material.dart';

const IconData check_circle_rounded =
    IconData(0xf635, fontFamily: 'MaterialIcons');

Future<dynamic> loadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pop(); // Close the dialog
      });
      return const AlertDialog(
        title: Column(
          children: [
             Center(
            child: CircularProgressIndicator(),
          ),
            Text("Loading"),
          ],
        ),
      );
    },
  );
}
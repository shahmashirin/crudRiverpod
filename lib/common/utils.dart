import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../models/userdata_model.dart';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(text),
    ));
}
void showErrorToast(BuildContext context, String message) {
  MotionToast.error(
      title: Text(
        'Error !',
      ),
      enableAnimation: true,
      position: MotionToastPosition.center,
      description: Text(message))
      .show(context);
}

void showSuccessToast(BuildContext context, String message) {
  MotionToast.success(
      title: Text(
        'Success !',
      ),
      enableAnimation: true,
      position: MotionToastPosition.center,
      description: Text(message))
      .show(context);
}
void showUploadErrorMessage(BuildContext context, String message, Color color,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: showLoading
            ? const Duration(minutes: 30)
            : const Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
Future<bool> alert(BuildContext context, String message,
    ) async {
  bool result=  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0)
        ),
        title: Text('Are you sure ?'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text(
                'No',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                )
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text(
                'Yes',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                )
            ),
          )
        ],
      )
  );
  return result;

}
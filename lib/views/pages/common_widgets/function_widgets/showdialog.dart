// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
  required Future<void> Function() onConfirm,
  VoidCallback? onCancel,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
              cancelButtonText,
              style: const TextStyle(
                color: red,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onConfirm();

              // Dismiss the dialog
            },
            child: Text(confirmButtonText,
                style: const TextStyle(
                  color: green,
                  fontSize: 16,
                )),
          ),
        ],
      );
    },
  );
}

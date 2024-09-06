import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

Future<void> confirmationDialog({
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
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), 
        ),
        title: Row(
          children: <Widget>[
            const Icon(Icons.warning, color: Colors.orange, size: 30),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$content 😢',
                style: const TextStyle(
                  color: red,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
             
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(context).pop(); 
            },
            style: TextButton.styleFrom(
              
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              cancelButtonText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onConfirm();
            },
            style: TextButton.styleFrom(
             
              backgroundColor: red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              confirmButtonText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}

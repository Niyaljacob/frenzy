import 'package:flutter/material.dart';

Widget userNameAndBio(String userName,String bio) {
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(userName, style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
)),
      Text(bio)
    ],
  );
}
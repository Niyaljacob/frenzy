import 'package:flutter/material.dart';

ListTile SettingsListTile(
  {required VoidCallback onTap,
    required Widget leading,
    required String title,
    required Widget trailing}
){
  return ListTile(
    onTap: onTap,
    leading: leading,
    title: Text(title),
    trailing: trailing,
  );
}
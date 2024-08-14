import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.cvImage, required this.prImage});
final String cvImage;
  final String prImage;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
    final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
  final ValueNotifier<String> coverImageNotifier = ValueNotifier('');

  String profileImageUrl = '';
  String coverImageUrl = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _EditProfileScreenState();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
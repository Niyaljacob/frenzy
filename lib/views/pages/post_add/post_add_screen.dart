import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/post_add/widgets/post_discribstion_textfield.dart';
import 'package:image_picker/image_picker.dart';


final ValueNotifier<String> imagePick = ValueNotifier('');

// ignore: must_be_immutable
class PostAddScreen extends StatelessWidget {
   PostAddScreen({super.key});

  final _formKey =GlobalKey<FormState>();
  final textController = TextEditingController();
  late XFile? file;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('New Post',style: TextStyle(fontWeight: FontWeight.bold),)),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: imagePick, 
                  builder: (context, value, child){
                    return GestureDetector(
                      onTap: () async{
                        file=await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(file!=null){
                          imagePick.value=file!.path;
                        }
                      },
                      child: Container(
                        color: grey,
                        width: size.width,
                        height: size.height*0.4,
                        child: imagePick.value==''
                        ? Image.asset(imagepicker,)
                        : Image.file(File(imagePick.value),
                        fit: BoxFit.cover,
                        )
                        ),
                    );
                  }),
                  kheight20,
                  const Row(
                    children: [
                      Text("Write a caption...",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  kheight,
                  PostDiscribstionTextfield(
                    controller: textController, 
                    hintText: 'Maximum 120 words', 
                    keyboard: TextInputType.text,
                    validator: validatePostdesctiption,),
                    kheight20,
                CustomButton(
                  media: MediaQuery.sizeOf(context), 
                  buttonText: 'Post', 
                  onPressed: (){}, 
                  color: primary),
                  kheight,
                  Image.asset(singupdark,height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
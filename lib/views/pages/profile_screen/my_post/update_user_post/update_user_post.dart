import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/my_post_model/my_post_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/post_add/widgets/post_discribstion_textfield.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/round_material_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ScreenUpdateUserPost extends StatelessWidget {
  final MyPostModel model;
ScreenUpdateUserPost({super.key, required this.model}) {
    textController.text = model.description.toString();
  }

  final ValueNotifier<String> pickNewImage = ValueNotifier('');
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  late XFile? file;
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Post', style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
),),
        ),
        body: BlocConsumer<FetchmypostBloc, FetchmypostState>(
           listener:(context, state) {
             if(state is EditUserPostSuccesState){
              customSnackbar(context, 'Post edited successfully', green);
              Navigator.pop(context);
             }else if (state is EditUserPosterrorState) {
              customSnackbar(context, state.error, red);
            }
           },
           builder:(context, state) {
             return SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  ValueListenableBuilder(
                    valueListenable: pickNewImage, 
                    builder:(context, value, child) {
                      return GestureDetector(
                        onTap: ()async{
                          file= await ImagePicker().pickImage(
                            source: ImageSource.gallery
                            );
                            if (file!=null){
                              pickNewImage.value=file!.path;
                            }
                        },
                         child: Container(
                              color: grey,
                              width: size.width,
                              height: size.height * 0.3,
                              child: pickNewImage.value == ''
                                  ? CachedNetworkImage(
                                      imageUrl: model.image.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return LoadingAnimationWidget
                                            .fourRotatingDots(
                                                color: grey, size: 30);
                                      },
                                    )
                                  : Image.file(File(pickNewImage.value),
                                      fit: BoxFit.cover),
                            ),
                      );
                    },),
                    kheight20,
                      PostDiscribstionTextfield(
                        controller: textController,
                        hintText: 'Write a caption...',
                        keyboard: TextInputType.text,
                        validator:
                            validatePostdesctiption, // Use the new validation function
                      ),
                      kheight50,
                      BlocBuilder<FetchmypostBloc, FetchmypostState>(
                        builder: (context, state) {
                          if (state is EditUserPostLoadingState ||
                              state is FetchMyPostLoadingState) {
                            return loadingButton(
                                media: size,
                                onPressed: () {},
                                color: primary);
                          }
                          return roundMaterialButtonround(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<FetchmypostBloc>().add(
                                        OnEditPostButtonClicked(
                                          image: pickNewImage.value,
                                          description: textController.text,
                                          imageUrl: model.image.toString(),
                                          postId: model.id.toString(),
                                        ),
                                      );
                                }
                              },
                              text: 'Save',
                              borderRadius: 20,
                              color: primary,
                              width: size.width,
                              height: size.height * 0.06);
                        },
                      )
                ],
                )
                ),
                ),
             );
           },),
      ),
    );
  }
}
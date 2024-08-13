import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingAnimationWidget() {
  return Center(
    child:
        LoadingAnimationWidget.fourRotatingDots(color: primary, size: 30),
  );
}

Widget errorStateWidget(String text,TextStyle style) {
  return Center(
    child: Text(text,style: style,),
  );
}


MaterialButton loadingButton(
    {required Size media,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: black,
      size: 40,
    )),
  );
}
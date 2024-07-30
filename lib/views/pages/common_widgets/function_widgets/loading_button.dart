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

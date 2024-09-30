


import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/all_message_model.dart';
import 'package:frenzy/views/pages/chat/chat_page/otheruser_message_card.dart';
import 'package:frenzy/views/pages/chat/chat_page/our_message_card.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';

Widget getMessageCard(AllMessagesModel message) {
  if (message.senderId == logginedUserId) {
    return OwnMessageCard(
      message: message.text.trim(),
      time: message.createdAt,
    );
  } else {
    return ReplayCard(
      message: message.text.trim(),
      time: message.updatedAt,
    );
  }
}
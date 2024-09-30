
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/main.dart';
import 'package:frenzy/model/common_model/all_message_model.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:frenzy/views/bloc/conversation_bloc/conversation_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket socket = io.io(
    '51.21.38.66',
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  void connectSocket({required BuildContext context}) async {
    final BuildContext? ctx = NavigationService.navigatorKey.currentContext;

    if (socket.disconnected) {
      socket.connect();

      socket.off("getMessage");

      socket.on("getMessage", (data) {
        debugPrint('inside get message - ${data['text']}');
        final message = AllMessagesModel(
          id: '',
          senderId: data['senderId'],
          recieverId: data['recieverId'],
          conversationId: '',
          text: data['text'],
          isRead: false,
          deleteType: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0,
        );

        if (ctx != null) {
          ctx
              .read<ConversationBloc>()
              .add(AddNewMessageEvent(message: message));
        }
        //   context
        //       .read<FetchAllConversationsBloc>()
        //       .add(AllConversationsInitialFetchEvent());
        context
            .read<ConversationBloc>()
            .add(AddNewMessageEvent(message: message));
      });
    }

    socket.onConnect((data) {
      debugPrint('Connection established');
    });
    socket.onConnectError((data) => debugPrint('connect error:$data'));
    socket.onDisconnect((data) => debugPrint('Socket.IO server disconnected'));

    final id = await getUserId();

    socket.emit("addUser", id);
  }

  sendMessgage(String message, String receiverId, String senderId) {
    socket.emit('sendMessage', {
      "senderId": senderId,
      "recieverId": receiverId,
      "text": message,
    });
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.clearListeners();
  }
}

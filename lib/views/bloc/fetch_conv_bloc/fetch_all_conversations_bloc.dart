// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/conversation_model.dart';
import 'package:frenzy/model/common_model/user_chat_get_model.dart';
import 'package:frenzy/repository/chat/chat_repository.dart';
import 'package:frenzy/repository/user_repository/user_repo.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:http/http.dart';
part 'fetch_all_conversations_event.dart';
part 'fetch_all_conversations_state.dart';

class FetchAllConversationsBloc
    extends Bloc<FetchAllConversationsEvent, FetchAllConversationsState> {
 

  FetchAllConversationsBloc() : super(FetchAllConversationsInitial()) {
    on<FetchAllConversationsEvent>((event, emit) {});
    on<AllConversationsInitialFetchEvent>(allConversationsInitialFetchEvent);
   
  }

  FutureOr<void> allConversationsInitialFetchEvent(
      AllConversationsInitialFetchEvent event,
      Emitter<FetchAllConversationsState> emit) async {
    emit(FetchAllConversationsLoadingState());
    final userid = await getUserId();
    final Response response = await ChatRepository.getAllConversations();
    debugPrint('conversation fetch statuscode is-${response.statusCode}');
    debugPrint('fetchall conversations body is -${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> conversationsData = responseData['data'];

      final List<ConversationModel> conversations = conversationsData
          .map((conversationJson) =>
              ConversationModel.fromJson(conversationJson))
          .toList();
      final List<String> otherUserIds = conversations
          .expand((conversation) => conversation.members)
          .where((userId) => userId != userid)
          .toList();

      List<GetUserModel> otherUsers = [];

      for (String userId in otherUserIds) {
        final Response userResponse =
            await UserRepo.getSingleUser(userid: userId);
        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
          final GetUserModel user = GetUserModel.fromJson(userJson);
          otherUsers.add(user);
        }
      }


      if (otherUsers.length == otherUserIds.length) {
        emit(FetchAllConversationsSuccesfulState(
          conversations: conversations,
          otherUsers: otherUsers,
          // filteredUsers: otherUsers,
        ));
      } else {
        emit(FetchAllConversationsErrorState());
      }
    } else {
      emit(FetchAllConversationsErrorState());
    }
  }

  
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/all_message_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/add_message_bloc/add_message_bloc.dart';
import 'package:frenzy/views/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:frenzy/views/bloc/fetch_conv_bloc/fetch_all_conversations_bloc.dart';
import 'package:frenzy/views/pages/chat/chat_page/chat_card.dart';
import 'package:frenzy/views/pages/chat/chat_page/date_divider.dart';
import 'package:frenzy/views/pages/chat/socket/socket.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String recieverid;
  final String name;
  final String username;
  final String profilepic;
  const ChatScreen({super.key, required this.conversationId, required this.recieverid, required this.name, required this.username, required this.profilepic});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final scrollController = ScrollController();

@override
  void initState() {
    context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : black,
        surfaceTintColor: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : black,
                title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(widget.profilepic),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.username,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      widget.name.isEmpty
                          ? 'Guest User'
                          : widget.name.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: grey))
                ],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
         
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/d2bfd3ea45910c01255ae022181148c4.jpg"), 
              fit: BoxFit.cover,
            ),
          ),
        ),
          Form(
            key: _formkey,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocConsumer<ConversationBloc, ConversationState>(
                        listener: (context, state) {
                          
                        },
                        builder: (context, state) {
                          if(state is GetAllMessagesLoadingState){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if(state is GetAllMessagesSuccesfulState){
                            List<DateTime>dates=[];
                            List<List<AllMessagesModel>> messagesByDate = [];
                            for(var message in state.messagesList){
                              DateTime date = DateTime(message.createdAt.year,
                              message.createdAt.month, message.createdAt.day);
                             if (!dates.contains(date)) {
                                dates.add(date);
                                messagesByDate.add([message]);
                              } else {
                                messagesByDate.last.add(message);
                              }
                            }
                            dates = dates.reversed.toList();
                            messagesByDate = messagesByDate.reversed.toList();
                            return ListView.builder(
                              controller: scrollController,
                              itemCount: dates.length,
                              reverse: true,
          
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    DateDivider(date: dates[index]),
                                    ...messagesByDate[index]
                                    .map((message) => getMessageCard(message)),
                                  ],
                                );
                              },
                              );
                          }else {
                            return const SizedBox();
                          }
                        },
                      )
          
                      ),
                      Row(
                      children: [
                        Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 440),
                            width: MediaQuery.of(context).size.width - 55,
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: _messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                decoration: const InputDecoration(
                                    prefix: SizedBox(
                                      width: 10,
                                    ),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'Type a message...',
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_messageController.text.isNotEmpty) {
                              SocketService().sendMessgage(_messageController.text,
                                  widget.recieverid, logginedUserId);
                              final message = AllMessagesModel(
                                  id: '',
                                  senderId: logginedUserId,
                                  recieverId: widget.recieverid,
                                  conversationId: widget.conversationId,
                                  text: _messageController.text,
                                  isRead: false,
                                  deleteType: '',
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  v: 0);
                              BlocProvider.of<ConversationBloc>(context)
                                  .add(AddNewMessageEvent(message: message));
                              context.read<AddMessageBloc>().add(
                                  AddMessageButtonClickEvent(
                                      message: _messageController.text,
                                      senderId: logginedUserId,
                                      recieverId: widget.recieverid,
                                      conversationId: widget.conversationId));
                              context
                                  .read<FetchAllConversationsBloc>()
                                  .add(AllConversationsInitialFetchEvent());
                              _messageController.clear();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 8, right: 2),
                            child: CircleAvatar(
                              backgroundColor: primary,
                              radius: 25,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }
}
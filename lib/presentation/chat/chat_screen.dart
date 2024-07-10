import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/data/model/technician.dart';

import '../../data/model/client.dart';
import '../../data/model/conversation.dart';
import '../../data/model/message.dart';
import '../../domain/cubit/chat/chat_cubit.dart';
import '../../domain/cubit/user/user_cubit.dart';
import 'chat_bubble.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.technician,
  });
  // final ConversationModel conversation;
  final Technician technician;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Client client = context.read<UserCubit>().user as Client;

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatContain) {
          ChatCubit.get(context).getChatMessages(state.conversationId!);
        }
        if (state is SendMessagesSuccess) {
          ChatCubit.get(context).getChatMessages(state.conversationId!);
        }
      },
      builder: (context, state) {
        List<MessageModel> messages = ChatCubit.get(context).chatMessages;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  // ChatCubit.get(context).getUserChats();
                  // GroupsCubit.get(context).getGroupsData();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Text(
              "${technician.fName} ${technician.lName}",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (client.id == messages[index].senderId) {
                          return ChatBubble(
                            message: messages[index],
                          );
                        } else {
                          return ChatBubbleForFriend(
                            message: messages[index],
                          );
                        }
                      })),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextField(
                  controller: messageController,
                  onSubmitted: (data) {
                    //send msg
                    if (ChatCubit.get(context).conversationId == null) {
                      ChatCubit.get(context)
                          .startConversation(technician.id!, client.id!, data);
                    } else {
                      ChatCubit.get(context)
                          .sendMessage(data, client.id!, technician.id!);
                    }

                    messageController.clear();

                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                  },
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                      hintText: "الرساله ...",
                      hintStyle: const TextStyle(color: Colors.black87),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(26))),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

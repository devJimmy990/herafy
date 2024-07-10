import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/domain/cubit/chat/chat_cubit.dart';
import 'package:herafy/presentation/chat/chat_item.dart';

import '../../core/helper/shared_preferences.dart';
import '../../data/model/client.dart';
import '../../data/model/conversation.dart';
import '../../domain/cubit/user/user_cubit.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ChatCubit>(context)
        .getUserConversations(SharedPreference().getString(key: "userID")!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        List<ConversationModel> conversations =
            ChatCubit.get(context).conversations;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "المحادثات",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: conversations.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    return ChatItem(
                      conversation: conversations[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

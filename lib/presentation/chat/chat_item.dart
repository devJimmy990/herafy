import 'package:flutter/material.dart';
import 'package:herafy/presentation/chat/chat_screen.dart';

import '../../core/helper/shared_preferences.dart';
import '../../data/model/conversation.dart';
import '../../domain/cubit/chat/chat_cubit.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.conversation,
  });

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    String type = SharedPreference().getString(key: "userType")!;
    String userId = SharedPreference().getString(key: "userID")!;
    String receiverId = conversation.participantsIds.firstWhere(
      (element) => element != userId,
    );
    String reciverName = type == "client"
        ? conversation.technician['name']
        : conversation.client;

    String technicianSpeciality = conversation.technician['specialty'];

    return InkWell(
      onTap: () {
        ChatCubit.get(context).checkConversation(userId, receiverId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      receiverId: receiverId,
                      receiverName: reciverName,
                      technicianSpeciality: technicianSpeciality,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 37,
              backgroundColor: Colors.amber,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/technicain.png"),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  SharedPreference().getString(key: "userType") == "client"
                      ? conversation.technician['name']
                      : conversation.client,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  SharedPreference().getString(key: "userType") == "client"
                      ? conversation.technician['specialty']
                      : "",
                  style: const TextStyle(color: Colors.black38, fontSize: 15),
                ),
              ],
            ),
            const Spacer(),
            Text(
              conversation.lastUpdatedAt.substring(11, 16).toString(),
              style: const TextStyle(color: Colors.black38, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

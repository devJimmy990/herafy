import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/conversation.dart';
import '../../../data/model/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  List<MessageModel> chatMessages = [];
  List<ConversationModel> conversations = [];

  String? conversationId;

  void getUserConversations(String userId) {
    emit(ChatsLoading());
    try {
      FirebaseFirestore.instance
          .collection('conversations')
          .where(
            'participantsIds',
            arrayContains: userId,
          )
          .orderBy('lastUpdatedAt', descending: true)
          .snapshots()
          .listen((event) {
        conversations.clear();
        for (var element in event.docs) {
          conversations.add(ConversationModel.fromJson(element.data()));
        }
        emit(ChatsSuccess(conversations: conversations));
      });
    } on Exception catch (e) {
      emit(ChatsFailure(error: e.toString()));
    }
  }

  void getChatMessages(String conversationId) {
    emit(GetMessagesLoading());
    try {
      FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) {
        chatMessages.clear();

        for (var element in event.docs) {
          chatMessages.add(MessageModel.fromJson(element.data()));
        }
        emit(GetMessagesSuccess());
      });
    } on Exception catch (e) {
      emit(GetMessagesFailure(error: e.toString()));
    }
  }

  void startConversation(String receiverId, String userId, String message,
      String clientName, String technicianName, String technicianSpecialty) {
    FirebaseFirestore.instance.collection('conversations').add({
      'participantsIds': [userId, receiverId],
      'lastUpdatedAt': DateTime.now().toString(),
      'lastMessages': message,
      'client': clientName,
      'technician': {'name': technicianName, 'specialty': technicianSpecialty},
    }).then((value) {
      FirebaseFirestore.instance
          .collection("conversations")
          .doc(value.id)
          .update({
        'id': value.id,
      });
      emit(StartConSuccess());
      conversationId = value.id;
      sendMessage(message, userId, receiverId);
    });
  }

  void sendMessage(String message, String userId, String receiverId) {
    try {
      emit(SendMessagesLoading());
      FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversationId)
          .collection("messages")
          .add({
        'message': message,
        'senderId': userId,
        'receiverId': receiverId,
        'date': DateTime.now().toString(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection("conversations")
            .doc(conversationId)
            .update({
          'lastUpdatedAt': DateTime.now().toString(),
          'lastMessages': message
        });
        emit(SendMessagesSuccess(
          conversationId: conversationId,
        ));
      });
    } on Exception catch (e) {
      emit(SendMessagesFailure(error: e.toString()));
    }
  }

  void checkConversation(String userId, String receiverId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot1 = await firestore
        .collection('conversations')
        .where('participantsIds', arrayContains: userId)
        .get();

    List<DocumentSnapshot> filteredDocs = querySnapshot1.docs.where((doc) {
      List<dynamic> arrayField = doc['participantsIds'];
      return arrayField.contains(receiverId);
    }).toList();

    if (filteredDocs.isEmpty) {
      conversationId = null;
      emit(ChatEmpty());
    } else {
      conversationId = filteredDocs[0]['id'];
      emit(ChatContain(
        conversationId: conversationId,
      ));
    }
  }
}

part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatsLoading extends ChatState {}

final class ChatsSuccess extends ChatState {
  final List conversations;

  ChatsSuccess({required this.conversations});
}

final class ChatsFailure extends ChatState {
  final String error;

  ChatsFailure({required this.error});
}

final class GetMessagesLoading extends ChatState {}

final class GetMessagesSuccess extends ChatState {}

final class GetMessagesFailure extends ChatState {
  final String error;
  GetMessagesFailure({required this.error});
}

final class SendMessagesLoading extends ChatState {}

final class SendMessagesSuccess extends ChatState {
  final String? conversationId;

  SendMessagesSuccess({required this.conversationId});
}

final class SendMessagesFailure extends ChatState {
  final String error;
  SendMessagesFailure({required this.error});
}

final class StartConSuccess extends ChatState {}

final class ChatEmpty extends ChatState {}

final class ChatContain extends ChatState {
  final String? conversationId;

  ChatContain({required this.conversationId});
}

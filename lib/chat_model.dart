class ChatMessage {
  final String message;
  final bool isMe;

  ChatMessage({required this.message, required this.isMe});

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message: map['message'],
      isMe: map['is_me'],
    );
  }
}

import 'package:chat/chat_model.dart';
import 'package:chat/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider = StreamProvider<List<ChatMessage>>((ref) {
  return supabase.from('Chat').stream(primaryKey: ['id']).map((data) {
    return data.map((map) => ChatMessage.fromMap(map)).toList();
  });
});
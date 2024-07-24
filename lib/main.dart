// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// void main() async {
//   await Supabase.initialize(
//     url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
//   );
//   runApp(const MyApp());
// }

// final supabase = Supabase.instance.client;

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatPage(),
//     );
//   }
// }

// class ChatPage extends StatefulWidget {
//   ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   late TextEditingController message;

//   @override
//   void initState() {
//     message = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     message.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder(
//           stream: supabase.from('Chat').select('*').asStream(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               print(snapshot.data);
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return snapshot.data![index].values.elementAt(3)
//                                   as bool
//                               ? SizedBox(
//                                   width: 100,
//                                   height: 60,
//                                   child: Align(
//                                     alignment: Alignment.topRight,
//                                     child: Card(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.blue,
//                                             borderRadius: BorderRadius.only(
//                                                 bottomLeft: Radius.circular(20),
//                                                 topLeft: Radius.circular(20),
//                                                 topRight: Radius.circular(20))),
//                                         width: 300,
//                                         height: 100,
//                                         child: Center(
//                                           child: Text(snapshot
//                                               .data![index].values
//                                               .elementAt(2)
//                                               .toString()),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : SizedBox(
//                                   width: 100,
//                                   height: 60,
//                                   child: Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Card(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.only(
//                                                 bottomRight:
//                                                     Radius.circular(20),
//                                                 topLeft: Radius.circular(20),
//                                                 topRight: Radius.circular(20))),
//                                         width: 300,
//                                         height: 100,
//                                         child: Center(
//                                           child: Text(snapshot
//                                               .data![index].values
//                                               .elementAt(2)
//                                               .toString()),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                         }),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                             width: MediaQuery.sizeOf(context).width * 0.8,
//                             child: TextField(
//                               controller: message,
//                               decoration:
//                                   InputDecoration(border: OutlineInputBorder()),
//                             )),
//                       ),
//                       IconButton(
//                           onPressed: () async {
//                             var temp = await supabase.from('Chat').insert({
//                               "message": message.text,
//                               "is_me": false
//                             }).select();
//                             setState(() {});
//                             message.clear();
//                           },
//                           icon: Icon(Icons.send))
//                     ],
//                   )
//                 ],
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// // Initialize Supabase
// void main() async {
//   await Supabase.initialize(
//     url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
//   );
//   runApp(const ProviderScope(child: MyApp()));
// }

// final supabase = Supabase.instance.client;

// // Chat message model
// class ChatMessage {
//   final String message;
//   final bool isMe;

//   ChatMessage({required this.message, required this.isMe});

//   factory ChatMessage.fromMap(Map<String, dynamic> map) {
//     return ChatMessage(
//       message: map['message'],
//       isMe: map['is_me'],
//     );
//   }
// }

// // Riverpod provider for chat messages
// final chatMessagesProvider = StreamProvider<List<ChatMessage>>((ref) {
//   return supabase.from('Chat').stream(primaryKey: ['id']).map((data) {
//     return data.map((map) => ChatMessage.fromMap(map)).toList();
//   });
// });

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatPage(),
//     );
//   }
// }

// class ChatPage extends ConsumerStatefulWidget {
//   const ChatPage({super.key});

//   @override
//   ConsumerState<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends ConsumerState<ChatPage> {
//   late TextEditingController messageController;

//   @override
//   void initState() {
//     messageController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatMessages = ref.watch(chatMessagesProvider);

//     return Scaffold(
//       body: Center(
//         child: chatMessages.when(
//           data: (messages) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return Align(
//                         alignment: message.isMe
//                             ? Alignment.topRight
//                             : Alignment.topLeft,
//                         child: Card(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: message.isMe ? Colors.blue : null,
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                                 bottomRight: message.isMe
//                                     ? Radius.circular(0)
//                                     : Radius.circular(20),
//                               ),
//                             ),
//                             width: 300,
//                             height: 50,
//                             child: Center(
//                               child: Text(message.message),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.8,
//                         child: TextField(
//                           controller: messageController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () async {
//                         await supabase.from('Chat').insert({
//                           "message": messageController.text,
//                           "is_me": true,
//                         });
//                         messageController.clear();
//                       },
//                       icon: Icon(Icons.send),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//           loading: () => CircularProgressIndicator(),
//           error: (error, stack) => Text('Error: $error'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// // Initialize Supabase
// void main() async {
//   await Supabase.initialize(
//     url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
//   );
//   runApp(const ProviderScope(child: MyApp()));
// }

// final supabase = Supabase.instance.client;

// // Chat message model
// class ChatMessage {
//   final String message;
//   final bool isMe;

//   ChatMessage({required this.message, required this.isMe});

//   factory ChatMessage.fromMap(Map<String, dynamic> map) {
//     return ChatMessage(
//       message: map['message'],
//       isMe: map['is_me'],
//     );
//   }
// }

// // StateNotifier for chat messages
// class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
//   ChatMessagesNotifier() : super([]) {
//     fetchMessages();
//   }

//   Future<void> fetchMessages() async {
//     final response = await supabase.from('Chat').select('*').get();
//     final data = response.data as List<dynamic>;
//     state = data.map((map) => ChatMessage.fromMap(map)).toList();
//   }

//   Future<void> addMessage(String message) async {
//     await supabase.from('Chat').insert({
//       "message": message,
//       "is_me": true,
//     });
//     fetchMessages();
//   }
// }

// // Provider for ChatMessagesNotifier
// final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
//   return ChatMessagesNotifier();
// });

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatPage(),
//     );
//   }
// }

// class ChatPage extends ConsumerStatefulWidget {
//   const ChatPage({super.key});

//   @override
//   ConsumerState<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends ConsumerState<ChatPage> {
//   late TextEditingController messageController;

//   @override
//   void initState() {
//     messageController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatMessages = ref.watch(chatMessagesProvider);

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: chatMessages.length,
//                 itemBuilder: (context, index) {
//                   final message = chatMessages[index];
//                   return Align(
//                     alignment: message.isMe ? Alignment.topRight : Alignment.topLeft,
//                     child: Card(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: message.isMe ? Colors.blue : null,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                             bottomRight: message.isMe ? Radius.circular(0) : Radius.circular(20),
//                           ),
//                         ),
//                         width: 300,
//                         height: 50,
//                         child: Center(
//                           child: Text(message.message),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: MediaQuery.sizeOf(context).width * 0.8,
//                     child: TextField(
//                       controller: messageController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     await ref.read(chatMessagesProvider.notifier).addMessage(messageController.text);
//                     messageController.clear();
//                   },
//                   icon: Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:chat/chat_model.dart';
import 'package:chat/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase
void main() async {
  await Supabase.initialize(
    url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
  );
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

// Chat message model

// Riverpod provider for chat messages


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatMessagesProvider);

    return Scaffold(
      body: Center(
        child: chatMessages.when(
          data: (messages) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.isMe
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: message.isMe ? Colors.blue : null,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: message.isMe
                                    ? Radius.circular(0)
                                    : Radius.circular(20),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            child: Center(
                              child: Text(message.message),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await supabase.from('Chat').insert({
                          "message": messageController.text,
                          "is_me": true,
                        });
                        messageController.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}

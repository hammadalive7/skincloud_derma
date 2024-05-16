import 'package:firebase_chat_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../provider/firebase_provider.dart';
import '../widgets/chat_messages.dart';
import '../widgets/chat_text_field.dart';
import 'auth/skin_report_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(receiverId: widget.userId),
            ChatTextField(receiverId: widget.userId)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Consumer<FirebaseProvider>(
          builder: (context, value, child) => value.user != null
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => SkinReportScreen(uid: value.user!.uid));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(value.user!.image),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            value.user!.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   value.user!.isOnline
                          //       ? 'Online'
                          //       : 'Offline',
                          //   style: TextStyle(
                          //     color: value.user!.isOnline
                          //         ? Colors.green
                          //         : Colors.grey,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Provider.of<FirebaseProvider>(context, listen: false)
                      .endSession(widget.userId);
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Text(
                  'End Session',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
}

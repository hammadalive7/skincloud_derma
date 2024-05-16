import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/message.dart';
import '../model/user.dart';
import '../service/firebase_firestore_service.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<UserModel> users = [];
  UserModel? user;
  List<Message> messages = [];
  List<UserModel> search = [];

  List<UserModel> getAllUsers() {
    FirebaseFirestore.instance
        .collection('chat_user')
        .where('isDoctor', isEqualTo: false)
        .where('consultationFeePaid', isEqualTo: true)
        // .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('chat_user')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('chat_user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search = await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }

  //endSession

  Future<void> endSession(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('chat_user').doc(userId).set({
        'consultationFeePaid': false,
      }, SetOptions(merge: true));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

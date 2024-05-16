

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/user_report.dart';

class UserReportController extends GetxController {

  Future<UserReport?> fetchUserReport(String uid) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (docSnapshot.exists) {
        return UserReport.fromFirestore(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("User with UID $uid does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      // You might want to handle errors here, like showing a message to the user
      return null;
    }
  }




}
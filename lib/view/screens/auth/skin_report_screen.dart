import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_report.dart';
import '../../../provider/user_report_provider.dart';

class SkinReportScreen extends StatelessWidget {
  final String uid;

  SkinReportScreen({required this.uid});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(UserReportController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Skin Report'),
      ),
      body: FutureBuilder<UserReport?>(
        future: controller.fetchUserReport(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            UserReport user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const //image
                  Text(
                    'Skin Image',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (user.image == '')
                        const Text("No Image Found")
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            user.image,
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Username: ${user.username}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email: ${user.email}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Age: ${user.age}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey[200],

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Gender: ${user.gender}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      )),
                  Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey[200],

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ethnicity: ${user.ethnicity}',
                          style: const TextStyle(fontSize: 20.0),
                        ),)
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'City: ${user.city}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Region: ${user.region}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detection Results:',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: user.detectionResults.map((result) {
                                return Text(
                                  '- $result',
                                  style: const TextStyle(fontSize: 18.0),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lifestyles:',
                            style:
                            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: user.lifeStyles.map((lifestyle) {
                                return Text(
                                  '- $lifestyle',
                                  style: const TextStyle(fontSize: 18.0),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[200],

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Skin Concerns:',
                            style:
                            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: user.skinConcerns.map((concern) {
                                return Text(
                                  '- $concern',
                                  style: const TextStyle(fontSize: 18.0),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No data found'),
            );
          }
        },
      ),
    );
  }
}

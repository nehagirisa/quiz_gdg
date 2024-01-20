import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataTable extends StatefulWidget {
  @override
  _UserDataTableState createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  late List<DocumentSnapshot> users;

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          users = querySnapshot.docs;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Table'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: users != null
              ? DataTable(
                  columns: [
                    // DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Userame')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Score')),
                    // Add more columns as needed
                  ],
                  rows:
                   users.map((user) {
                    Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
                    return DataRow(cells: [
                    
                      DataCell(Text(userData['name'] ?? '')),
                      DataCell(Text(userData['email'] ?? '')),
                      DataCell(Text(userData['score'].toString() ?? '')),
                      // Add more cells as needed
                    ]);
                  }).toList(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
               ),
         ),
      ),
    );
  }
}



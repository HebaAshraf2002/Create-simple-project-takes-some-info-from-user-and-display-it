import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRealtimeList extends StatefulWidget {
  @override
  _UserRealtimeListState createState() => _UserRealtimeListState();
}

class _UserRealtimeListState extends State<UserRealtimeList> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 71, 113)),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
      
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['name'] ?? '--'),
                    subtitle: Text(data['age']?.toString() ?? '--'),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
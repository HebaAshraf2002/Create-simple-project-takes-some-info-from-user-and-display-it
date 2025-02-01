import 'package:firebasefirestore/models/Firestore_User_Model.dart';
import 'package:firebasefirestore/service/User_Firestore_service.dart';
import 'package:flutter/material.dart';

class SavedData extends StatefulWidget {
  const SavedData({super.key});

  @override
  State<SavedData> createState() => _SavedDataState();
}

class _SavedDataState extends State<SavedData> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    getMyUsers();
  }

  getMyUsers() async {
    // ignore: non_constant_identifier_names
    var UsersList = await UserFirestoreService().getUserFromFirebase();
    setState(() {
      users = UsersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Users Data',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 71, 113),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            " Name: ${users[index].name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            ' Age: ${users[index].age}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(Icons.accessibility_new),
                          Text(
                            ' Favourite Hobby: ${users[index].hobby}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefirestore/views/SavedData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInput extends StatefulWidget {
  const UserInput({super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameContrller = TextEditingController();
  final TextEditingController _ageContrller = TextEditingController();
  final TextEditingController _hobbyContrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'User Input',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 71, 113),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Enter Your Data',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 18, 71, 113),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameContrller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 18, 71, 113),
                        width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _ageContrller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 18, 71, 113),
                        width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _hobbyContrller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hobby';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Favourite Hobby',
                  prefixIcon: Icon(Icons.accessibility_new),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 18, 71, 113),
                        width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 18, 71, 113)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    minimumSize: MaterialStateProperty.all(Size(300, 50))),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var db = FirebaseFirestore.instance;
                    final data = {
                      'name': _nameContrller.text,
                      'age': _ageContrller.text,
                      'hobby': _hobbyContrller.text
                    };

                    db.collection("users").add(data).then((documentSnapshot) {
                      _nameContrller.clear();
                      _ageContrller.clear();
                      _hobbyContrller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("The data is saved sccessfuly")));
                    });
                  }
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text(
                        ' Save Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 18, 71, 113)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    minimumSize: MaterialStateProperty.all(Size(300, 50))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SavedData()),
                  );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.storage),
                      Text(
                        ' View Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

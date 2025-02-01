import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final String? age;
  final String? hobby;


  User({
    this.name,
    this.age,
    this.hobby
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return User(
      name: data?['name'],
      age: data?['age'],
      hobby: data?['hobby'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (hobby != null) "hobby": hobby,
    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  DateTime? createdAt;
  int? status;

  UserModel( {this.email, this.password, this.uid, this.name, this.createdAt, this.status,} );

  factory UserModel.fromJson(DocumentSnapshot data) {
    return UserModel(
      email: data['email'],
      password: data['password'],
      uid: data['uid'],
      name: data['name'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "password": password,
      "name": name,
      "status": status,
      "createdAt": createdAt,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String? title;
  String? body;
  int? status;
  DateTime? createdAt;

   TaskModel({this.id,this.title,this.body,this.status,this.createdAt});

   factory TaskModel.fromjson( DocumentSnapshot json) {
    Timestamp? timestamp =json['createdAt'];
    return TaskModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      status: json['status'],
      createdAt: timestamp?.toDate(),
    );
   }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'body':body,
      'status':status,
      'createdAt':createdAt
    };
  }

}
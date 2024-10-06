import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginfire/models/task_model.dart';

class TaskService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');
  
  //create

  Future <TaskModel?> createTask (TaskModel task) async {

    try{

      final taskMap = task.toMap();
      await 
      _taskCollection.doc(task.id).set(taskMap);
      return task;

    }on FirebaseException catch(e){
      print(e.toString());
    }

  }

  //getall
   Stream<List<TaskModel>> getAllTask(){

    try{
      return _taskCollection.snapshots().map((QuerySnapshot snapshot ){
        return snapshot.docs.map((DocumentSnapshot doc){
          return TaskModel.fromjson(doc);
        }).toList();
      });
    }on FirebaseException catch(e){
      print(e);
      throw(e);
    }
   }
  //update

  //delete





}
import 'package:flutter/material.dart';
import 'package:loginfire/models/task_model.dart';
import 'package:loginfire/service/task_service.dart';
import 'package:loginfire/widgets/textfield.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskKey = GlobalKey<FormState> ();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descrptionController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descrptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _taskKey,
          child: Column(
            children: [
              const Text("Add Task",style: TextStyle(fontSize: 19),),
              const SizedBox(height: 20,),
               MyTextField(hintText: "Task Name", titlee: "Task Name", controller: _titleController, ),
               MyTextField(hintText: "Describe task", titlee: "Task",controller: _descrptionController,),
              InkWell(
                onTap: (){

                  if(_taskKey.currentState!.validate()){

                   _addTask();
                  
                  }
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[400]
                  ),
                  child: Center(child: Text("Add Task",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
 
 _addTask() async{
  var id = Uuid().v1();
  TaskModel _taskModel = TaskModel(title: _titleController.text,body: _descrptionController.text,id: id,status: 1,createdAt: DateTime.now());

  TaskService _taskService = TaskService();

  final task = await _taskService.createTask(_taskModel);

  if(task != null){
     Navigator.pop(context);
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("TaskCreated")));
  }
  
 }

}
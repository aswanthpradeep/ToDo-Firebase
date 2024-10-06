import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loginfire/Pages/add_task.dart';
import 'package:loginfire/Pages/homepage.dart';
import 'package:loginfire/models/task_model.dart';
import 'package:loginfire/service/auth_service.dart';
import 'package:loginfire/service/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskService _taskService = TaskService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const AddTask(),));
          
        });
       },backgroundColor: Colors.grey[400],child: const Icon(Icons.add, ),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text("Hi",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                    Text("Name",style: TextStyle(fontSize: 20),)
                  ],
                ),
                CircleAvatar( backgroundColor: Colors.grey[600] ,
                child: IconButton(onPressed: (){
               AuthService().logout().then((value)=>Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),)));
                }, icon: const Icon(Icons.logout)),)
              ],
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text("Your Todo's",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 21),),

            ),
            Expanded(
              child: StreamBuilder <List<TaskModel>>  (
                stream: _taskService.getAllTask() ,
                 builder: (context,snapshot){
                  
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return  Center(child: SpinKitCircle(color: Colors.black,));
                  }

                  if(snapshot.hasError){
                   return Center(child: Text("Some Error Occoured"),);
                  }
                  if(snapshot.hasData && snapshot.data!.length ==0){
                   return Center(child: Text("NO TASK ADDED !"),);
                   
                  } 

                  if(snapshot.hasData && snapshot.data!.length >=1){
                    List<TaskModel> tasks = snapshot.data ??[];
                  return  ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final _task = tasks[index];
                return Card(
                  child: ListTile(   
                    leading: const Icon(Icons.circle_outlined),
                    title:  Text("${_task.title}"),
                    subtitle: Text("${_task.body}"),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: const Icon(Icons.edit_outlined)),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline))
                        ],
                      ),
                    )
                  ),
                );
              },);}

                return  Center(child: SpinKitCircle(color: Colors.red,));
              
                 })
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 String? name;
 String? email;
 String? uid;
 String? token;

 getData () async{
  
  

  SharedPreferences _pref = await SharedPreferences.getInstance();
  token = await _pref.getString('token');
  name = await _pref.getString('name');
  email = await _pref.getString('email');
  uid = await _pref.getString('uid');

 
 }


@override
  void initState() {
    getData(); 
    Future.delayed(const Duration(seconds: 4),(){

    checkLoginStatus();
    });
    super.initState();
  }

Future<void>checkLoginStatus()async{

if(token ==null){
  Navigator.pushReplacementNamed(context,'/');
}else{
  Navigator.pushReplacementNamed(context,'/homeScreen');
  
}

}

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
       child: Text("TO DOO",style: TextStyle(color: Colors.white,fontSize: 22),),
      ),
    );
  }
}
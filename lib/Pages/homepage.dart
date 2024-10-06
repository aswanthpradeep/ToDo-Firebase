import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfire/Pages/homescreen.dart';
import 'package:loginfire/Pages/registerpage.dart';
import 'package:loginfire/service/auth_service.dart';
import 'package:loginfire/models/usermodel.dart';
import 'package:loginfire/widgets/textfield.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoginError = false;
  bool isLoading = false;



  UserModel _userModel = UserModel();
  AuthService _authService =AuthService();


  void _login (){

    setState(() async{
      isLoading = true;
      try{
          await Future.delayed(const Duration(seconds: 3));

        _userModel = UserModel(email: _emailController.text,password: _passwordController.text);
        final data = await _authService.login(_userModel);
       
                if (data != null) {
                Navigator.push( context,MaterialPageRoute( builder: (context) => const HomeScreen(),));
                              }
        }on FirebaseAuthException catch(e){
          setState(() {
            isLoading =false;
            List err = e.toString().split("]");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1 ])));
          });
        }

    });


  }
 @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(alignment: const Alignment(0, 0),
          children: [
            Form(

              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 70),
                  MyTextField(
                    hintText: "Email",
                    titlee: "Email",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    hintText: "Password",
                    titlee: "Password",
                    isPassword: true,
                    controller: _passwordController,
                    validator_: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (isLoginError) {
                        return "Wrong Email or Password";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          _login();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registerpage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Visibility(visible: isLoading, child: const CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  // Future<void> _login() async {
  //   try {
  //     UserCredential userData = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     if (userData != null) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreen(),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoginError = true;
  //     });
  //     _formKey.currentState?.validate();  // Trigger validation to show the error message
  //   }
  // }
}

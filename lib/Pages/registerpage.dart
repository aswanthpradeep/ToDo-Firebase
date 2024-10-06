import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfire/Pages/homepage.dart';
import 'package:loginfire/Pages/homescreen.dart';
import 'package:loginfire/service/auth_service.dart';
import 'package:loginfire/models/usermodel.dart';
import 'package:loginfire/widgets/textfield.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  UserModel _userModel = UserModel();
  AuthService _authService = AuthService();
  bool isLoading = false;

  void _register() async {
    setState(() {
      isLoading = true;
    });
    _userModel = UserModel(
        email: _emailController.text,
        password: _passwordController.text,
        name: _firstNameController.text,
        createdAt: DateTime.now(),
        status: 1);


        try{
          await Future.delayed(const Duration(seconds: 2));
               final userData = await _authService.registerUser(_userModel);
         
                if (userData != null) {
                Navigator.push( context,MaterialPageRoute( builder: (context) => const HomeScreen(),));
                              }
        }on FirebaseAuthException catch(e){
          setState(() {
            isLoading =false;
            List err = e.toString().split("]");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1 ])));
          });
        }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: const Alignment(0, 0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  MyTextField(
                    hintText: "FirstName",
                    titlee: 'FirstName',
                    controller: _firstNameController,
                  ),
                  // MyTextField(
                  //   hintText: "LastName",
                  //   titlee: "LastName",
                  //   controller: _lastNameController,
                  // ),
                  MyTextField(
                    hintText: "Email",
                    titlee: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  //  MyTextField(
                  //   hintText: "Phone",
                  //   titlee: "Phone",
                  //   keyboardType: TextInputType.phone,
                  //   controller: _phoneController,
                  // ),
                  MyTextField(
                    hintText: "Password",
                    titlee: "Password",
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  //    MyTextField(
                  //     hintText: "Confirm Password",
                  //     titlee: "Confirm Password",
                  //     isPassword: true,
                  //     controller: _confirmPasswordController,
                  //     validator_: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please confirm your password';
                  //   }

                  //   return null;
                  // },
                  //   ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black)),
                        onPressed: () {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                          setState(() async {
                            if (_formKey.currentState!.validate()) {
                                _register();
                            }
                          });
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ));
                        },
                        child: const Text(
                          "Login",
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
}

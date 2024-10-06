import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String titlee;
  final bool isPassword;
  final TextInputType? keyboardType;
    final String? Function(String?)? validator_;
  
  
  
  const MyTextField({super.key,
  this.controller,
  required this.hintText,
  required this.titlee,
  this.isPassword = false,
  this.keyboardType,
  this.validator_
  
  
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = false ;
 // TextEditingController _textEditingController = TextEditingController();
   void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
       Text(widget.titlee,style: const TextStyle(fontWeight:FontWeight.w600),),
          TextFormField(
            keyboardType:widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
      
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              suffixIcon: widget.isPassword? IconButton(
                  icon: Icon(
                    _obscureText ?  Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ): null
            ),
            obscureText: _obscureText, 
              validator:widget.validator_ ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return "The ${widget.hintText} can't be empty";
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
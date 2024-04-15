import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
 final TextInputType textInputType;

  const CustomTextField({super.key, 
    required this.hintText,
    this.obscureText = false,
    required this.controller,
     this.textInputType =TextInputType.name
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        validator: (value) {
          if(value==null)
          {
            return '$hintText cannot be empty';
          }
          return null;
        },
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'enter $hintText',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          
        ),
      ),
    );
  }
}
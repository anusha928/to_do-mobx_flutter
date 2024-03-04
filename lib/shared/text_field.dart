import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/shared/constants/color_constants.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  Function()? onTap;
   CommonTextfield({super.key, required this.controller, required this.hintText,this.onTap,this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child:TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14,color: Colors.grey),
          icon:icon ,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

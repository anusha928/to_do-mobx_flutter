import 'package:flutter/material.dart';
import 'package:to_do/shared/constants/color_constants.dart';

void showSnackBar(String message,BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.primaryColor,
    duration:const Duration(seconds: 1),
    content: Text(message,style:const TextStyle(color: Colors.white),),
  ));
}

import 'dart:io';

import 'package:to_do/feature/entity/todo_model.dart';
abstract class Response {
  static String defaultErrorMessage = "Internal Server Error";

  static String defaultConnectionError =
       "No Internet Connection";

  static String getErrorMessage(Object error) {
    String errorMessage;
    if (error is SocketException) {
      errorMessage = Response.defaultConnectionError;
    } else {
      errorMessage = Response.defaultErrorMessage;
    }
    return errorMessage;
  }
}
class TodoResponse extends Response{
  bool hasError;
  String? errorMessage;
  TodoModel? response;

  TodoResponse({
    this.hasError = false,
    this.errorMessage = "",
    this.response,
  });
}

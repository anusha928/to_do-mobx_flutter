import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/feature/entity/todo_model.dart';
import 'package:to_do/feature/store/to_do_store.dart';
import 'package:to_do/shared/constants/color_constants.dart';
import 'package:to_do/shared/show_snackbar.dart';
import 'package:to_do/shared/size_config.dart';
import 'package:to_do/shared/text_field.dart';
import 'package:uuid/uuid.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({super.key});

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  ToDoStore store = ToDoStore();
  double height = 0.0;
  double width = 0.0;

  @override
  void didChangeDependencies() {
    store = Provider.of<ToDoStore>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      content: SizedBox(
          width: width,
          child: Form(
              child: Column(children: [
            CommonTextfield(
              controller: titleController,
              hintText: "Add Task",
              icon:  Icon(CupertinoIcons.square_list,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),
            CommonTextfield(
              controller: desController,
              hintText: "Description",
              icon:  Icon(CupertinoIcons.bubble_left_bubble_right,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),
          ]))),
      actions: [
        InkWell(
          onTap: () {
            String randomId = const Uuid().v4();
            TodoModel taskModel = TodoModel(
                id: randomId,
                title: titleController.text,
                description: desController.text);
            store.createTask(taskModel);
            Navigator.pop(context);
            showSnackBar("Task Added Successfully", context);
          },
          child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.primaryColor),
              child: const Text("Add Task",style: TextStyle(color: Colors.white),)),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.primaryColor),
              child: const Text("Cancel",style: TextStyle(color: Colors.white),)),
        ),

      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/feature/entity/task_model.dart';
import 'package:to_do/feature/store/task_store.dart';
import 'package:to_do/shared/constants/color_constants.dart';
import 'package:to_do/shared/show_snackbar.dart';
import 'package:to_do/shared/text_field.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  String? title;
  String? description;
  String? id;

  UpdateTaskAlertDialog({super.key, this.title, this.description, this.id});

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TaskStore store = TaskStore();
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    titleController.text = widget.title ?? "";
    desController.text = widget.description ?? "";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    store = Provider.of<TaskStore>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor),
      ),
      content: SizedBox(
          width: width,
          child: Form(
              child: Column(children: [
            CommonTextfield(
              controller: titleController,
              hintText: "Add Task",
              icon: const Icon(CupertinoIcons.square_list,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),
            CommonTextfield(
              controller: desController,
              hintText: "Description",
              icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                  color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),
          ]))),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              )),
        ),
        InkWell(
          onTap: () {
            createUpdateTask();
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor),
              child: const Text(
                "Save Update",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  createUpdateTask() async {
    if (titleController.text.isNotEmpty || desController.text.isNotEmpty) {
      TaskModel taskModel = TaskModel(
          id: widget.id,
          title: titleController.text,
          description: desController.text);
      final update = await store.updateTask(taskModel);
      update.fold((l) {
        print(l.toString());
        showSnackBar(l.toString(), context);
      }, (r) => showSnackBar("Task updated Successfully", context));
      Navigator.pop(context);
    }
  }
}

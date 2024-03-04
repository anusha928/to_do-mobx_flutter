import 'package:flutter/material.dart';
import 'package:to_do/feature/entity/task_model.dart';
import 'package:to_do/feature/store/task_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:to_do/shared/constants/color_constants.dart';
import 'package:to_do/shared/show_snackbar.dart';
import 'package:to_do/shared/widgets/add_task_alert_dialog.dart';
import 'package:to_do/shared/widgets/update_task_alert_dialog.dart';

class MobileTaskView extends StatefulWidget {
  const MobileTaskView({super.key});

  @override
  State<MobileTaskView> createState() => _MobileTaskViewState();
}

class _MobileTaskViewState extends State<MobileTaskView> {
  TaskStore store = TaskStore();
  double height = 0.0;
  double width = 0.0;

  @override
  void didChangeDependencies() async {
    store = Provider.of<TaskStore>(context, listen: false);
    await store.getTask();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Task List",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Observer(
            builder: (context) {
              return store.isLoading ? const SizedBox.shrink() : _createBody();
            },
          ),
          Observer(builder: (context) {
            return Visibility(
                visible: store.isLoading,
                child: const Center(child: CircularProgressIndicator()));
          })
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _createFloatingActionButton(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        shape: const  CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               InkWell(
                 onTap: ()async{
                   await store.getTask();
                 },
                 child: Container(
                     padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.primaryColor),
                     child:const Text("Refresh",style: TextStyle(color: Colors.white),)),
               ),
              InkWell(
                onTap: ()async{
                  await store.deleteAllTask();
                  await store.getTask();
                },
                child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppColors.primaryColor),
                    child:const Text("Clear Task",style: TextStyle(color: Colors.white),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return  AddTaskAlertDialog();
            }).then((value) async {
          await store.getTask();
        });
      },
      backgroundColor: AppColors.primaryColor,
      shape: const CircleBorder(),
      child: const Text(
        'Add',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  _createBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await store.getTask();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              store.taskList.isNotEmpty
                  ? Observer(builder: (context) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: store.taskList.length,
                              itemBuilder: (context, index) {
                                var data = store.taskList[index];
                                return _createTaskContainer(data);
                              }));
                    })
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Image.asset("assets/add_task.png"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _createTaskContainer(TaskModel data) {
    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return  UpdateTaskAlertDialog(title:   data.title,description: data.description,id: data.id);
            }).then((value) async {
          await store.getTask();
        });

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFFF0F3E5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 5.0,
              offset: Offset(0, 5), // shadow direction: bottom right
            ),
          ],
        ),
        child: ListTile(
          title: Text(data.title!,style:  const TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 16)),
          subtitle: Text(data.description ?? "",style: const TextStyle(color: AppColors.primaryColor),),
          trailing: IconButton(
              onPressed: () async {
                await store.deleteTaskWithId(data.id!);
                await store.getTask().then((value) =>
                    showSnackBar("Task Deleted Successfully", context));
              },
              icon: const Icon(Icons.delete_outline_outlined,color: AppColors.primaryColor,)),
        ),
      ),
    );
  }
}

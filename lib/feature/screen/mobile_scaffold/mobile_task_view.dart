import 'package:flutter/material.dart';
import 'package:to_do/feature/entity/todo_model.dart';
import 'package:to_do/feature/store/to_do_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:to_do/shared/constants/color_constants.dart';
import 'package:to_do/shared/show_snackbar.dart';
import 'package:to_do/shared/widgets/add_task_alert_dialog.dart';

class MobileTaskView extends StatefulWidget {
  const MobileTaskView({super.key});

  @override
  State<MobileTaskView> createState() => _MobileTaskViewState();
}

class _MobileTaskViewState extends State<MobileTaskView> {
  ToDoStore store = ToDoStore();
  double height = 0.0;
  double width = 0.0;

  @override
  void didChangeDependencies() async {
    store = Provider.of<ToDoStore>(context, listen: false);
    await store.getToDo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title:const Text("Task List",style: TextStyle(color: Colors.white,fontSize: 22),),
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
      bottomNavigationBar:  BottomAppBar(
        color: const Color(0xFFF0F3E5),
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0), // Adjust the horizontal padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  const Text("Clear All Task"),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
              const Text("Clear Task"),
              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: () {},
              // ),
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
              return const AddTaskAlertDialog();
            }).then((value) async {
          await store.getToDo();
        });
      },
      backgroundColor: AppColors.primaryColor,
      shape:const CircleBorder(),
      child: const Text('Add',style: TextStyle(color: Colors.white,fontSize: 16),),
    );
  }

  _createBody() {
    return RefreshIndicator(
      onRefresh: ()async{
        await store.getToDo();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              store.taskList.isNotEmpty
                  ? Observer(
                    builder: (context) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: store.taskList.length,
                              itemBuilder: (context, index) {
                                var data = store.taskList[index];
                                return _createTaskContainer(data);
                              }));
                    }
                  )
                  : const Text("No Task"),
              _createClearButton()
            ],
          ),
        ),
      ),
    );
  }

  _createTaskContainer(TodoModel data) {
    return Container(
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
        title: Text(data.title!),
        subtitle: Text(data.description ?? ""),
        trailing: IconButton(
            onPressed: ()async{
              await store.deleteToDoWithId(data.id!);
              await store.getToDo().then((value) => showSnackBar("Task Deleted Successfully",context));

            }, icon: const Icon(Icons.delete_outline_outlined)),
      ),
    );
  }

  _createClearButton() {
    return InkWell(
      onTap: () async {
        await store.deleteAllTask();
        await store.getToDo();
      },
      child: const Text("Clear"),
    );
  }
}

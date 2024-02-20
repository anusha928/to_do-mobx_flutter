// import 'package:flutter/material.dart';
// import 'package:to_do/feature/entity/todo_model.dart';
// import 'package:to_do/feature/store/to_do_store.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
//
// class TaskAddScreen extends StatefulWidget {
//   const TaskAddScreen({super.key});
//
//   @override
//   State<TaskAddScreen> createState() => _TaskAddScreenState();
// }
//
// class _TaskAddScreenState extends State<TaskAddScreen> {
//   ToDoStore store = ToDoStore();
//
//   @override
//   void didChangeDependencies() async {
//     store = Provider.of<ToDoStore>(context, listen: false);
//     await store.getToDo();
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Observer(
//             builder: (context) {
//               return store.isLoading ? const SizedBox.shrink() : _createBody();
//             },
//           ),
//           Observer(builder: (context) {
//             return Visibility(
//                 visible: store.isLoading,
//                 child:const Center(child:  CircularProgressIndicator()));
//           })
//         ],
//       )),
//     );
//   }
//
//   _createBody() {
//     return Center(
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () async {
//
//               await store.createTask(todoModel);
//               await store.getToDo();
//             },
//             child: const Text("Add task"),
//           ),
//           store.taskList.isNotEmpty
//               ? Expanded(
//                   child: ListView.builder(
//                       itemCount: store.taskList.length,
//                       itemBuilder: (context, index) {
//                         return Text(store.taskList[index].title!);
//                       }))
//               : const Text("No Task"),_createClearButton()
//         ],
//       ),
//     );
//   }
//   _createClearButton(){
//     return InkWell(
//       onTap: ()async{
//         await store.deleteAllTask();
//         await store.getToDo();
//       },
//       child: const Text("Clear"),
//     );
//   }
// }

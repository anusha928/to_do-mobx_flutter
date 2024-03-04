import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'entity/task_model.dart';

abstract class TaskRepository {
  Future<void> deleteToDoWithId({required String id});

  Future<void> deleteAllTasks();

  Future<Either<String, TaskModel>> createTask(TaskModel taskModel);

  Future<Either<String, TaskModel>> updateTask(TaskModel taskModel);

  Future<Either<String, List<TaskModel>>> getTask();
}

class FirebaseStoreTaskRepository implements TaskRepository {
  FirebaseStoreTaskRepository._(); // Private constructor

  static final FirebaseStoreTaskRepository _instance =
      FirebaseStoreTaskRepository._();

  factory FirebaseStoreTaskRepository() => _instance;

  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('task');

  @override
  Future<Either<String, TaskModel>> createTask(TaskModel taskModel) async {
    try {
      final DocumentReference docRef = await _taskCollection.add({
        "id": taskModel.id,
        "title": taskModel.title,
        "description": taskModel.description,
      });
      final createdTask = TaskModel(
        id: docRef.id,
        title: taskModel.title,
        description: taskModel.description,
      );
      return right(createdTask);
    } catch (e) {
      return left(e.toString());
    }
  }
  @override
  Future<Either<String, List<TaskModel>>> getTask() async {
    try {
      final QuerySnapshot querySnapshot = await _taskCollection.get();
      final List<TaskModel> taskList = querySnapshot.docs.map((doc) {
        return TaskModel(
          id: doc.id,
          title: doc['title'] as String,
          description: doc['description'] as String,
        );
      }).toList();
      return right(taskList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TaskModel>> updateTask(TaskModel taskModel) async {
    try {
      final DocumentReference docRef = _taskCollection.doc(taskModel.id);
      print(docRef.id);
      docRef.update({
        'title': taskModel.title,
        'description': taskModel.description,
      });
      return right(taskModel);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<void> deleteAllTasks() {
    return _taskCollection.get().then((querySnapshot) {
      return Future.wait(
          querySnapshot.docs.map((doc) => doc.reference.delete()));
    });
  }

  @override
  Future<void> deleteToDoWithId({required String id}) {
    return _taskCollection
        .where('id', isEqualTo: id)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.reference.delete();
      } else {
        throw Exception('Task with ID $id not found');
      }
    });
  }

  
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/feature/response.dart';
import 'entity/todo_model.dart';

abstract class TodoRepository {
  Future<void> deleteToDoWithId({required String id});

  Future<void> deleteAllTasks();

  Future<void> createTodo(TodoModel todoModel);

  Future<TodoResponse> updateTodo(TodoModel todoModel);

  Future<List<TodoModel>> getTodo();
}

class FirebaseStoreTodoRepository implements TodoRepository {
  FirebaseStoreTodoRepository._(); // Private constructor

  static final FirebaseStoreTodoRepository _instance =
  FirebaseStoreTodoRepository._();

  factory FirebaseStoreTodoRepository() => _instance;

  final CollectionReference _taskCollection =
  FirebaseFirestore.instance.collection('task');

  @override
  Future<void> createTodo(TodoModel todoModel) {
    return _taskCollection.add({
      "id": todoModel.id,
      "title": todoModel.title,
      "description": todoModel.description
    }).then((_) => null);
  }

  @override
  Future<void> deleteAllTasks() {
    return _taskCollection.get().then((querySnapshot) {
      return Future.wait(querySnapshot.docs.map((doc) => doc.reference.delete()));
    });
  }

  @override
  Future<void> deleteToDoWithId({required String id}) {
    return _taskCollection.where('id', isEqualTo: id).get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.reference.delete();
      } else {
        throw Exception('Task with ID $id not found');
      }
    });
  }

  @override
  Future<List<TodoModel>> getTodo() {
    return _taskCollection.get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TodoModel(
          id: doc['id'] as String,
          title: doc['title'] as String,
          description: doc['description'] as String,
        );
      }).toList();
    });
  }

  @override
  Future<TodoResponse> updateTodo(TodoModel todoModel) {
    throw UnimplementedError();
  }
}


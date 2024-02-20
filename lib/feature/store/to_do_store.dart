import 'package:mobx/mobx.dart';
import 'package:to_do/feature/entity/todo_model.dart';
import 'package:to_do/feature/to_do_repository.dart';

part 'to_do_store.g.dart';

class ToDoStore = _ToDoStore with _$ToDoStore;

abstract class _ToDoStore with Store {
  final TodoRepository toDoRepository = FirebaseStoreTodoRepository();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<TodoModel> taskList = ObservableList<TodoModel>();

  @action
  Future<void> createTask(TodoModel todoModel) async {
    isLoading = true;
    await ObservableFuture(toDoRepository.createTodo(todoModel))
        .then((_) {})
        .catchError((e) {
      print('Error creating task: $e');
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> getToDo() async {
    isLoading = true;
    await ObservableFuture(toDoRepository.getTodo()).then((value) {
      taskList.clear();
      taskList.addAll(value);
    }).catchError((e) {
      print('Error fetching tasks: $e');
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> deleteToDoWithId(String id) async {
    isLoading = true;
    await ObservableFuture(toDoRepository.deleteToDoWithId(id: id))
        .then((_) {})
        .catchError((e) {
      print('Error deleting task: $e');
    }).whenComplete(() => isLoading = false);
  }

  @action
  Future<void> deleteAllTask() async {
    isLoading = true;
    await ObservableFuture(toDoRepository.deleteAllTasks())
        .then((_) {})
        .catchError((e) {
      print('Error deleting all tasks: $e');
    }).whenComplete(() {
      taskList.clear();
      isLoading = false;
    });
  }
}

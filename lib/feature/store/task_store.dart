import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:to_do/feature/entity/task_model.dart';
import 'package:to_do/feature/task_repository.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final TaskRepository toDoRepository = FirebaseStoreTaskRepository();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<TaskModel> taskList = ObservableList<TaskModel>();

  @action
  Future<Either<String, TaskModel>> createTask(TaskModel taskModel) async {
    isLoading = true;
    final result = await ObservableFuture(toDoRepository.createTask(taskModel));
    isLoading = false;
    return result.fold((l) => left(l.toString()), (r) {
      taskList.add(r);
      return right(r);
    });
  }

  @action
  Future<Either<String, TaskModel>> updateTask(TaskModel taskModel) async {
    isLoading = true;
    final updateResult = await ObservableFuture(
        toDoRepository.updateTask(taskModel));
    isLoading = false;
    return updateResult.fold((l) => left(l.toString()), (r) {
      return right(r);
    });
  }

  @action
  Future<void> getTask() async {
    isLoading = true;
    final items = await ObservableFuture(toDoRepository.getTask());
    isLoading = false;
    items.fold((l) => left(l.toString()), (r) {
      taskList.clear();
      taskList.addAll(r);
      return right(r);
    });
    taskList.clear();
  }

  @action
  Future<void> deleteTaskWithId(String id) async {
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

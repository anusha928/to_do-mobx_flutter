// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_TaskStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$taskListAtom =
      Atom(name: '_TaskStore.taskList', context: context);

  @override
  ObservableList<TaskModel> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(ObservableList<TaskModel> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_TaskStore.createTask', context: context);

  @override
  Future<Either<String, TaskModel>> createTask(TaskModel taskModel) {
    return _$createTaskAsyncAction.run(() => super.createTask(taskModel));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_TaskStore.updateTask', context: context);

  @override
  Future<Either<String, TaskModel>> updateTask(TaskModel taskModel) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(taskModel));
  }

  late final _$getTaskAsyncAction =
      AsyncAction('_TaskStore.getTask', context: context);

  @override
  Future<void> getTask() {
    return _$getTaskAsyncAction.run(() => super.getTask());
  }

  late final _$deleteTaskWithIdAsyncAction =
      AsyncAction('_TaskStore.deleteTaskWithId', context: context);

  @override
  Future<void> deleteTaskWithId(String id) {
    return _$deleteTaskWithIdAsyncAction.run(() => super.deleteTaskWithId(id));
  }

  late final _$deleteAllTaskAsyncAction =
      AsyncAction('_TaskStore.deleteAllTask', context: context);

  @override
  Future<void> deleteAllTask() {
    return _$deleteAllTaskAsyncAction.run(() => super.deleteAllTask());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
taskList: ${taskList}
    ''';
  }
}

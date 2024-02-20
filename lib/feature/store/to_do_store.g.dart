// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ToDoStore on _ToDoStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ToDoStore.isLoading', context: context);

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
      Atom(name: '_ToDoStore.taskList', context: context);

  @override
  ObservableList<TodoModel> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(ObservableList<TodoModel> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_ToDoStore.createTask', context: context);

  @override
  Future<void> createTask(TodoModel todoModel) {
    return _$createTaskAsyncAction.run(() => super.createTask(todoModel));
  }

  late final _$getToDoAsyncAction =
      AsyncAction('_ToDoStore.getToDo', context: context);

  @override
  Future<void> getToDo() {
    return _$getToDoAsyncAction.run(() => super.getToDo());
  }

  late final _$deleteToDoWithIdAsyncAction =
      AsyncAction('_ToDoStore.deleteToDoWithId', context: context);

  @override
  Future<void> deleteToDoWithId(String id) {
    return _$deleteToDoWithIdAsyncAction.run(() => super.deleteToDoWithId(id));
  }

  late final _$deleteAllTaskAsyncAction =
      AsyncAction('_ToDoStore.deleteAllTask', context: context);

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

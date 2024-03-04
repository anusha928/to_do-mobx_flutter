import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_do/feature/store/task_store.dart';
import 'package:to_do/shared/show_snackbar.dart';

class Providers {
  static List<SingleChildWidget> listOfProviders = [
    Provider(create: (context) => TaskStore()),
  ];
}
//flutter packages pub run build_runner watch --delete-conflicting-outputs
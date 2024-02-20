import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_do/feature/store/to_do_store.dart';
import 'package:to_do/shared/show_snackbar.dart';

class Providers {
  static List<SingleChildWidget> listOfProviders = [
    Provider(create: (context) => ToDoStore()),
  ];
}

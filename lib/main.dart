import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/shared/provider_constants.dart';
import 'package:to_do/shared/responsive_layout.dart';

import 'feature/screen/desktop_scaffold/desktop_task_view.dart';
import 'feature/screen/mobile_scaffold/mobile_task_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.listOfProviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            return const ResponsiveLayout(
              mobileScaffold: MobileTaskView(),
              desktopScaffold: DesktopTaskView(),
            );
          }
        ),
      ),
    );
  }
}

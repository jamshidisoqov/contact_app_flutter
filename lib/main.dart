import 'package:contact_app_flutter/di/hive_module.dart';
import 'package:contact_app_flutter/pages/add/add_contact_page.dart';
import 'package:contact_app_flutter/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
   Hive.init(appDocumentDirectory.path);
  await setUpDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => const MainPage(),
        AddContactPage.route: (context) => const AddContactPage()
      },
    );
  }
}

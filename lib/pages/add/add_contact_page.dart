import 'package:contact_app_flutter/di/hive_module.dart';
import 'package:contact_app_flutter/pages/main/main_bloc.dart';
import 'package:contact_app_flutter/pages/main/main_events.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  static const String route = "/add_contact";

  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  late MainBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt.get<MainBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: "+998 ** *** ** **",
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(
                  Size(double.infinity, 56),
                ),
              ),
              onPressed: () {
                bloc.onEventDispatcher(
                  AddEvent(
                    name: nameController.text,
                    phone: phoneController.text,
                    isMale: true,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

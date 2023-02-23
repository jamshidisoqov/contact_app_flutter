import 'package:contact_app_flutter/di/hive_module.dart';
import 'package:contact_app_flutter/pages/add/add_contact_page.dart';
import 'package:contact_app_flutter/pages/main/main_bloc.dart';
import 'package:contact_app_flutter/pages/main/main_events.dart';
import 'package:contact_app_flutter/pages/main/main_ui_state.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String route = "/contacts";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt.get<MainBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Contacts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var snapshotData = snapshot.data!;
            switch (snapshotData.state) {
              case UiState.init:
                return const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.hourglass_empty_rounded,
                    ),
                  ),
                );
              case UiState.success:
                print("-------------------------------");
                print(snapshotData.list.length);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshotData.list.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data != null) {
                              var data = snapshotData.list[index];
                              return SizedBox(
                                width: double.infinity,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image.asset(data.isMale!
                                              ? "assets/images/man.png"
                                              : "assets/images/woman.png"),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              data.name ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              data.phone ?? "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            bloc.onEventDispatcher(
                                              DeleteEvent(data),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            width: 40,
                                            height: 40,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox(child: Container());
                          }),
                    ),
                  ],
                );
              case UiState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case UiState.error:
                return Center(
                  child: Text(snapshotData.errorMessage),
                );
            }
          }
          return const Center(
            child: Text(
              "Error",
            ),
          );
        },
        stream: bloc.stream,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddContactPage.route);
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

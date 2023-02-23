import 'dart:async';

import 'package:contact_app_flutter/core/data/hive/hive_helper.dart';
import 'package:contact_app_flutter/core/data/models/contact_data.dart';
import 'package:contact_app_flutter/pages/main/main_events.dart';
import 'package:contact_app_flutter/pages/main/main_ui_state.dart';

class MainBloc {
  final HiveHelper _hiveHelper;
  final _stateController = StreamController<MainUiState>();

  List<ContactData> contacts = [];

  MainBloc(this._hiveHelper) {
    _getAllContact();
  }

  Future<void> _getAllContact() async {
    var contacts = await _hiveHelper.getAllContact();
    _stateController.sink.add(
        MainUiState(state: UiState.success, list: contacts));
  }

  void onEventDispatcher(MainEvent event) {
    if (event is AddEvent) {
      print("------------------");
      var time = DateTime
          .now()
          .millisecondsSinceEpoch;
      var contact = ContactData(time, event.name, event.phone, event.isMale);
      print("----------1--------");
      contacts.add(contact);
      print("----------2--------");
      _hiveHelper.addContact(contact);
      print("----------3--------");
      _stateController.sink.add(
          MainUiState(state: UiState.success, list: contacts));
      print("----------4--------");
    } else if (event is DeleteEvent) {
      _hiveHelper.deleteContact(event.contactData);
      contacts.removeWhere((element) => element.id == event.contactData.id);
      _stateController.sink.add(
          MainUiState(state: UiState.success, list: contacts));
    }
  }

  Stream<MainUiState> get stream => _stateController.stream;
}

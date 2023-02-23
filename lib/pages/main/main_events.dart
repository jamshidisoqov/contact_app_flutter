import 'package:contact_app_flutter/core/data/models/contact_data.dart';

abstract class MainEvent {}

class AddEvent extends MainEvent {
  String name;
  String phone;
  bool isMale;

  AddEvent({required this.name, required this.phone, required this.isMale});
}

class DeleteEvent extends MainEvent {
  ContactData contactData;

  DeleteEvent(this.contactData);
}

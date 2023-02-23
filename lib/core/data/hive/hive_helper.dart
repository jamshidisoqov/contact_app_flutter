import 'package:contact_app_flutter/core/data/models/contact_data.dart';
import 'package:hive/hive.dart';

class HiveHelper {

  static const String boxName = "contacts";

  Box box;

  HiveHelper(this.box);

  Future<void> addContact(ContactData contactData) async {
    return await box.put(contactData.id, contactData.toJson());
  }

  Future<void> updateContact(ContactData contactData) async =>
      addContact(contactData);

  Future<void> deleteContact(ContactData contactData) async {
    return await box.delete(contactData.id);
  }

  Future<List<ContactData>> getAllContact() async {
    return (box.values).map((e) => ContactData.fromJson(e)).toList();
  }
}

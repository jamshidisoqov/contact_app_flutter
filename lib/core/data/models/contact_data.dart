import 'package:hive/hive.dart';

class ContactData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  bool? isMale;

  ContactData(this.id, this.name, this.phone, this.isMale);

  ContactData.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    phone = map["phone"];
    isMale = map["is-male"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["phone"] = phone;
    map["is-male"] = isMale;
    return map;
  }
}

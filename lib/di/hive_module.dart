import 'package:contact_app_flutter/core/data/hive/hive_helper.dart';
import 'package:contact_app_flutter/pages/main/main_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpDatabase() async {
  Box box;
  if(await Hive.boxExists(HiveHelper.boxName)) {
    box = await Hive.openBox(HiveHelper.boxName);
  }else{
    box = Hive.box(HiveHelper.boxName);
  }
  getIt.registerLazySingleton(() => HiveHelper(box));
  getIt.registerLazySingleton(() => MainBloc(getIt.get()));
}

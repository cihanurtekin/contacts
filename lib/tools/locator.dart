import 'package:contacts/repository/contact_database_repository.dart';
import 'package:contacts/service/sqflite_contact_database_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ContactDatabaseRepository());
  locator.registerLazySingleton(() => SqfliteContactDatabaseService());
}

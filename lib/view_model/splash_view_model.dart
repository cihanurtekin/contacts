import 'package:contacts/model/contact.dart';
import 'package:contacts/repository/contact_database_repository.dart';
import 'package:contacts/tools/locator.dart';
import 'package:contacts/tools/parser.dart';
import 'package:contacts/tools/routes.dart';
import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  final ContactDatabaseRepository _contactDatabaseRepository =
      locator<ContactDatabaseRepository>();

  Future<void> navigate(BuildContext context) async {
    await _parseInitialContacts(context);
  }

  Future<void> _parseInitialContacts(BuildContext context) async {
    try {
      NavigatorState navigator = Navigator.of(context);
      List<Contact> initialContacts = await Parser.parseInitialContacts();
      for (Contact c in initialContacts) {
        Contact? existingContact =
            await _contactDatabaseRepository.getContactById(c.contactId);
        if (existingContact == null) {
          await _contactDatabaseRepository.addContact(c);
        }
      }
      navigator.pushReplacementNamed(Routes.mainPageKey);
    } catch (e) {
      debugPrint("SplashViewModel / _parseInitialContacts : ${e.toString()}");
    }
  }
}

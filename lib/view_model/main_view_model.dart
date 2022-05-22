import 'package:contacts/model/contact.dart';
import 'package:contacts/repository/contact_database_repository.dart';
import 'package:contacts/tools/locator.dart';
import 'package:contacts/tools/routes.dart';
import 'package:flutter/material.dart';

enum MainViewState { idle, loading }

class MainViewModel with ChangeNotifier {
  final ContactDatabaseRepository _contactDatabaseRepository =
      locator<ContactDatabaseRepository>();

  MainViewState _state = MainViewState.loading;

  MainViewState get state => _state;

  set state(MainViewState value) {
    _state = value;
    notifyListeners();
  }

  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  MainViewModel() {
    _getAllContacts();
  }

  void _getAllContacts() async {
    _contacts = await _contactDatabaseRepository.getAllContacts();
    state = MainViewState.idle;
  }

  void onAddContactPressed(BuildContext context) {
    Routes.openContactDetailPage(
      context,
      then: (Contact? resultContact) {
        if (resultContact != null) {
          _contacts.add(resultContact);
          notifyListeners();
        }
      },
    );
  }

  void onListItemTap(BuildContext context, Contact contact) {
    Routes.openContactDetailPage(
      context,
      contact: contact,
      then: (Contact? resultContact) {
        if (resultContact != null) {
          if (resultContact.contactId == Contact.deletedContactIdKey) {
            _contacts.remove(contact);
            notifyListeners();
          } else {
            contact.update(resultContact);
          }
        }
      },
    );
  }
}

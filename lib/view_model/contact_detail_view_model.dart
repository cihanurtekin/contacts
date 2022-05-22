import 'package:contacts/model/contact.dart';
import 'package:contacts/repository/contact_database_repository.dart';
import 'package:contacts/tools/locator.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ContactDetailViewState { idle, loading }

class ContactDetailViewModel with ChangeNotifier {
  final ContactDatabaseRepository _contactDatabaseRepository =
      locator<ContactDatabaseRepository>();

  ContactDetailViewState _state = ContactDetailViewState.idle;

  ContactDetailViewState get state => _state;

  set state(ContactDetailViewState value) {
    _state = value;
    notifyListeners();
  }

  final Contact? _contact;

  Contact? get contact => _contact;

  ContactDetailViewModel([this._contact]);

  void onSavePressed(
    BuildContext context,
    String firstName,
    String lastName,
    String phoneNumber,
    String streetAddress1,
    String streetAddress2,
    String city,
    String contactState,
    String zipCode,
  ) async {
    NavigatorState navigator = Navigator.of(context);
    if (_state != ContactDetailViewState.loading) {
      state = ContactDetailViewState.loading;

      Contact newContact = Contact(
        const Uuid().v4(),
        firstName,
        lastName,
        phoneNumber,
        streetAddress1,
        streetAddress2,
        city,
        contactState,
        zipCode,
      );

      if (contact != null) {
        newContact.contactId = contact!.contactId;
        await _contactDatabaseRepository.updateContact(newContact);
      } else {
        await _contactDatabaseRepository.addContact(newContact);
      }

      state = ContactDetailViewState.idle;
      navigator.pop(newContact);
    }
  }

  void onDeletePressed(BuildContext context) async {
    NavigatorState navigator = Navigator.of(context);

    if (_state != ContactDetailViewState.loading && contact != null) {
      state = ContactDetailViewState.loading;

      await _contactDatabaseRepository.deleteContact(contact!.contactId);

      state = ContactDetailViewState.idle;
      navigator.pop(Contact.deleted());
    }
  }
}

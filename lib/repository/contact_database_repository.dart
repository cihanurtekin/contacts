import 'package:contacts/base/contact_database_base.dart';
import 'package:contacts/model/contact.dart';
import 'package:contacts/service/base/contact_database_service.dart';
import 'package:contacts/service/sqflite_contact_database_service.dart';
import 'package:contacts/tools/locator.dart';

class ContactDatabaseRepository implements ContactDatabaseBase {
  final ContactDatabaseService _service =
      locator<SqfliteContactDatabaseService>();

  @override
  Future<int> addContact(Contact contact) async {
    return await _service.addContact(contact);
  }

  @override
  Future<int> updateContact(Contact contact) async {
    return await _service.updateContact(contact);
  }

  @override
  Future<Contact?> getContactById(String contactId) async {
    return await _service.getContactById(contactId);
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    return await _service.getAllContacts();
  }

  @override
  Future<int> deleteContact(String contactId) async {
    return await _service.deleteContact(contactId);
  }
}

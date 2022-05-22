import 'package:contacts/model/contact.dart';

abstract class ContactDatabaseBase {
  Future<int> addContact(Contact contact);

  Future<int> updateContact(Contact contact);

  Future<Contact?> getContactById(String contactId);

  Future<List<Contact>> getAllContacts();

  Future<int> deleteContact(String contactId);
}

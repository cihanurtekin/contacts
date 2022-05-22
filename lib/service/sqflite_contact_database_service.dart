import 'package:contacts/model/contact.dart';
import 'package:contacts/service/base/contact_database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteContactDatabaseService implements ContactDatabaseService {
  Database? _database;

  final String _contactsTableName = "contacts";
  final String _idContacts = "id";

  Future<Database?> _getDatabase() async {
    if (_database == null) {
      String filePath = await getDatabasesPath();
      String databasePath = join(filePath, "contacts.db");
      _database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: _createTable,
      );
    }
    return _database;
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_contactsTableName (
      $_idContacts INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
      ${Contact.contactIdKey} TEXT NOT NULL,
      ${Contact.firstNameKey} TEXT,
      ${Contact.lastNameKey} TEXT,
      ${Contact.phoneNumberKey} TEXT,
      ${Contact.streetAddress1Key} TEXT,
      ${Contact.streetAddress2Key} TEXT,
      ${Contact.cityKey} TEXT,
      ${Contact.stateKey} TEXT,
      ${Contact.zipCodeKey} TEXT);
    ''');
  }

  @override
  Future<int> addContact(Contact contact) async {
    Database? db = await _getDatabase();
    if (db != null) {
      Map<String, dynamic> contactMap = contact.toMap();
      return await db.insert(_contactsTableName, contactMap);
    } else {
      return -1;
    }
  }

  @override
  Future<int> updateContact(Contact contact) async {
    Database? db = await _getDatabase();
    if (db != null) {
      Map<String, dynamic> contactMap = contact.toMap();

      return await db.update(
        _contactsTableName,
        contactMap,
        where: "${Contact.contactIdKey} = ?",
        whereArgs: [contact.contactId],
      );
    } else {
      return 0;
    }
  }

  @override
  Future<Contact?> getContactById(String contactId) async {
    Database? db = await _getDatabase();
    if (db != null) {
      List<Map<String, dynamic>> contactsMap = await db.query(
        _contactsTableName,
        where: "${Contact.contactIdKey} = ?",
        whereArgs: [contactId],
        limit: 1,
      );

      if (contactsMap.isNotEmpty) {
        Map<String, dynamic> contactMap = Map.of(contactsMap[0]);
        return Contact.fromMap(contactMap[Contact.contactIdKey], contactMap);
      }
    }
    return null;
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    Database? db = await _getDatabase();
    List<Contact> contacts = [];

    if (db != null) {
      List<Map<String, dynamic>> contactsMap = await db.query(
        _contactsTableName,
      );

      for (Map<String, dynamic> m in contactsMap) {
        Map<String, dynamic> contactMap = Map.of(m);
        contacts.add(Contact.fromMap(
          contactMap[Contact.contactIdKey],
          contactMap,
        ));
      }
    }
    return List.from(contacts);
  }

  @override
  Future<int> deleteContact(String contactId) async {
    Database? db = await _getDatabase();
    if (db != null) {
      return await db.delete(
        _contactsTableName,
        where: "${Contact.contactIdKey} = ?",
        whereArgs: [contactId],
      );
    } else {
      return 0;
    }
  }
}

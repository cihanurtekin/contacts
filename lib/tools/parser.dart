import 'dart:convert';

import 'package:contacts/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Parser {
  static Future<Map<String, dynamic>?> _parseJson(String jsonAssetPath) async {
    try {
      String jsonString = await rootBundle.loadString(jsonAssetPath);
      Map<String, dynamic>? decodedMap = json.decode(jsonString);
      return decodedMap;
    } catch (e) {
      debugPrint("Parser / parseJson : ${e.toString()}");
      return null;
    }
  }

  static Future<List<Contact>> parseInitialContacts() async {
    List<Contact> contacts = [];

    Map<String, dynamic>? contactsMap = await _parseJson(
      'assets/json/contacts.json',
    );

    contactsMap?.forEach((key, value) {
      Contact contact = Contact.fromMap(key, value);
      contacts.add(contact);
    });

    return List.from(contacts);
  }
}

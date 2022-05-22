import 'package:flutter/material.dart';

class Contact with ChangeNotifier {
  static const String contactIdKey = 'contactId';
  static const String firstNameKey = 'firstName';
  static const String lastNameKey = 'lastName';
  static const String phoneNumberKey = 'phoneNumber';
  static const String streetAddress1Key = 'streetAddress1';
  static const String streetAddress2Key = 'streetAddress2';
  static const String cityKey = 'city';
  static const String stateKey = 'state';
  static const String zipCodeKey = 'zipCode';

  static const String deletedContactIdKey = 'deleted';

  String contactId;
  String firstName;
  String lastName;
  String phoneNumber;
  String streetAddress1;
  String streetAddress2;
  String city;
  String state;
  String zipCode;

  Contact(
    this.contactId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.streetAddress1,
    this.streetAddress2,
    this.city,
    this.state,
    this.zipCode,
  );

  Contact.fromMap(this.contactId, Map<String, dynamic> map)
      : firstName = map[firstNameKey] ?? '',
        lastName = map[lastNameKey] ?? '',
        phoneNumber = map[phoneNumberKey] ?? '',
        streetAddress1 = map[streetAddress1Key] ?? '',
        streetAddress2 = map[streetAddress2Key] ?? '',
        city = map[cityKey] ?? '',
        state = map[stateKey] ?? '',
        zipCode = map[zipCodeKey] ?? '';

  Contact.deleted()
      : contactId = deletedContactIdKey,
        firstName = '',
        lastName = '',
        phoneNumber = '',
        streetAddress1 = '',
        streetAddress2 = '',
        city = '',
        state = '',
        zipCode = '';

  Map<String, dynamic> toMap() {
    return {
      contactIdKey: contactId,
      firstNameKey: firstName,
      lastNameKey: lastName,
      phoneNumberKey: phoneNumber,
      streetAddress1Key: streetAddress1,
      streetAddress2Key: streetAddress2,
      cityKey: city,
      stateKey: state,
      zipCodeKey: zipCode,
    };
  }

  void update(Contact updatedContact) {
    firstName = updatedContact.firstName;
    lastName = updatedContact.lastName;
    phoneNumber = updatedContact.phoneNumber;
    streetAddress1 = updatedContact.streetAddress1;
    streetAddress2 = updatedContact.streetAddress2;
    city = updatedContact.city;
    state = updatedContact.state;
    zipCode = updatedContact.zipCode;
    notifyListeners();
  }
}

import 'package:contacts/model/contact.dart';
import 'package:contacts/view_model/contact_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ContactDetailType {
  firstName,
  lastName,
  phoneNumber,
  streetAddress1,
  streetAddress2,
  city,
  state,
  zipCode,
}

class ContactDetailPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _streetAddress1Controller =
      TextEditingController();
  final TextEditingController _streetAddress2Controller =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  ContactDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactDetailViewModel viewModel = Provider.of<ContactDetailViewModel>(
      context,
      listen: false,
    );
    Contact? initialContact = viewModel.contact;
    _initControllerTexts(initialContact);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          initialContact != null
              ? '${initialContact.firstName} ${initialContact.lastName}'
              : "Add Contact",
        ),
      ),
      body: _buildBody(),
    );
  }

  void _initControllerTexts(Contact? contact) {
    if (contact != null) {
      _firstNameController.text = contact.firstName;
      _lastNameController.text = contact.lastName;
      _phoneNumberController.text = contact.phoneNumber;
      _streetAddress1Controller.text = contact.streetAddress1;
      _streetAddress2Controller.text = contact.streetAddress2;
      _cityController.text = contact.city;
      _stateController.text = contact.state;
      _zipCodeController.text = contact.zipCode;
    }
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView(
        children: [
          _buildListItem(_ContactDetailType.firstName),
          _buildListItem(_ContactDetailType.lastName),
          _buildListItem(_ContactDetailType.phoneNumber),
          _buildListItem(_ContactDetailType.streetAddress1),
          _buildListItem(_ContactDetailType.streetAddress2),
          _buildListItem(_ContactDetailType.city),
          _buildListItem(_ContactDetailType.state),
          _buildListItem(_ContactDetailType.zipCode),
          const SizedBox(height: 32),
          _buildSaveButton(),
          const SizedBox(height: 16),
          _buildDeleteButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildListItem(_ContactDetailType contactDetailType) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _buildContactDetailItem(contactDetailType),
      ],
    );
  }

  Widget _buildContactDetailItem(_ContactDetailType contactDetailType) {
    return TextField(
      keyboardType: _getInputType(contactDetailType),
      autofocus: false,
      controller: _getController(contactDetailType),
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(_getIcon(contactDetailType)),
        labelText: _getLabelText(contactDetailType),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Consumer<ContactDetailViewModel>(
      builder: (context, viewModel, child) =>
          viewModel.state == ContactDetailViewState.loading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  child: Text(viewModel.contact != null ? "Update" : "Save"),
                  onPressed: () {
                    viewModel.onSavePressed(
                      context,
                      _firstNameController.text.trim(),
                      _lastNameController.text.trim(),
                      _phoneNumberController.text.trim(),
                      _streetAddress1Controller.text.trim(),
                      _streetAddress2Controller.text.trim(),
                      _cityController.text.trim(),
                      _stateController.text.trim(),
                      _zipCodeController.text.trim(),
                    );
                  },
                ),
    );
  }

  Widget _buildDeleteButton() {
    return Consumer<ContactDetailViewModel>(
      builder: (context, viewModel, child) => viewModel.contact != null
          ? ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                viewModel.onDeletePressed(context);
              },
            )
          : const SizedBox(),
    );
  }

  TextInputType _getInputType(_ContactDetailType contactDetailType) {
    switch (contactDetailType) {
      case _ContactDetailType.firstName:
        return TextInputType.name;
      case _ContactDetailType.lastName:
        return TextInputType.name;
      case _ContactDetailType.phoneNumber:
        return TextInputType.phone;
      case _ContactDetailType.streetAddress1:
        return TextInputType.streetAddress;
      case _ContactDetailType.streetAddress2:
        return TextInputType.streetAddress;
      case _ContactDetailType.city:
        return TextInputType.text;
      case _ContactDetailType.state:
        return TextInputType.text;
      case _ContactDetailType.zipCode:
        return TextInputType.number;
    }
  }

  TextEditingController _getController(_ContactDetailType contactDetailType) {
    switch (contactDetailType) {
      case _ContactDetailType.firstName:
        return _firstNameController;
      case _ContactDetailType.lastName:
        return _lastNameController;
      case _ContactDetailType.phoneNumber:
        return _phoneNumberController;
      case _ContactDetailType.streetAddress1:
        return _streetAddress1Controller;
      case _ContactDetailType.streetAddress2:
        return _streetAddress2Controller;
      case _ContactDetailType.city:
        return _cityController;
      case _ContactDetailType.state:
        return _stateController;
      case _ContactDetailType.zipCode:
        return _zipCodeController;
    }
  }

  IconData _getIcon(_ContactDetailType contactDetailType) {
    switch (contactDetailType) {
      case _ContactDetailType.firstName:
        return Icons.person;
      case _ContactDetailType.lastName:
        return Icons.person;
      case _ContactDetailType.phoneNumber:
        return Icons.phone;
      case _ContactDetailType.streetAddress1:
        return Icons.location_on;
      case _ContactDetailType.streetAddress2:
        return Icons.location_on;
      case _ContactDetailType.city:
        return Icons.location_city;
      case _ContactDetailType.state:
        return Icons.location_city;
      case _ContactDetailType.zipCode:
        return Icons.location_city;
    }
  }

  String _getLabelText(_ContactDetailType contactDetailType) {
    switch (contactDetailType) {
      case _ContactDetailType.firstName:
        return "First Name";
      case _ContactDetailType.lastName:
        return "Last Name";
      case _ContactDetailType.phoneNumber:
        return "Phone Number";
      case _ContactDetailType.streetAddress1:
        return "Street Address 1";
      case _ContactDetailType.streetAddress2:
        return "Street Address 2";
      case _ContactDetailType.city:
        return "City";
      case _ContactDetailType.state:
        return "State";
      case _ContactDetailType.zipCode:
        return "Zip Code";
    }
  }
}

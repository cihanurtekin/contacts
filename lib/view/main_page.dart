import 'package:contacts/model/contact.dart';
import 'package:contacts/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: _buildBody(),
      floatingActionButton: _buildAddContactFab(context),
    );
  }

  Widget _buildAddContactFab(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(
      context,
      listen: false,
    );
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        viewModel.onAddContactPressed(context);
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Consumer<MainViewModel>(
        builder: (context, viewModel, child) =>
            viewModel.state == MainViewState.loading
                ? const Center(child: CircularProgressIndicator())
                : _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ChangeNotifierProvider.value(
            value: viewModel.contacts[index],
            child: _buildListTile(context),
          );
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(
      context,
      listen: false,
    );
    return Consumer<Contact>(
      builder: (context, contact, child) => ListTile(
        title: Text('${contact.firstName} ${contact.lastName}'),
        leading: CircleAvatar(child: Text(contact.firstName[0]),),
        onTap: () {
          viewModel.onListItemTap(context, contact);
        },
      ),
    );
  }
}

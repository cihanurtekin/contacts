import 'package:contacts/model/contact.dart';
import 'package:contacts/view/contact_detail_page.dart';
import 'package:contacts/view/main_page.dart';
import 'package:contacts/view_model/contact_detail_view_model.dart';
import 'package:contacts/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String mainPageKey = '/main_page';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      mainPageKey: (BuildContext context) => ChangeNotifierProvider(
            create: (context) => MainViewModel(),
            child: const MainPage(),
          ),
    };
  }

  static openContactDetailPage(
    BuildContext context, {
    Contact? contact,
    void Function(Contact? contact)? then,
  }) {
    Navigator.push<Contact?>(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => ContactDetailViewModel(contact),
          child: ContactDetailPage(),
        ),
      ),
    ).then((Contact? resultContact) {
      then?.call(resultContact);
    });
  }
}

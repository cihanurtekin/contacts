import 'package:contacts/tools/locator.dart';
import 'package:contacts/tools/routes.dart';
import 'package:contacts/view/splash_page.dart';
import 'package:contacts/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => SplashViewModel(),
        child: const SplashPage(),
      ),
      routes: Routes.getRoutes(),
    );
  }
}

import 'package:contacts/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  final Duration _splashDuration = const Duration(milliseconds: 1000);
  final bool waitForDuration = false;

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigate(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blue,
      child: const Center(
        child: Text(
          "Contacts",
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (waitForDuration) {
        Future.delayed(_splashDuration).then((_) {
          _redirect(context);
        });
      } else {
        _redirect(context);
      }
    });
  }

  void _redirect(BuildContext context) {
    SplashViewModel viewModel = Provider.of<SplashViewModel>(
      context,
      listen: false,
    );
    viewModel.navigate(context);
  }
}

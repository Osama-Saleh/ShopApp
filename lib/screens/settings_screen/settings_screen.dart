import 'package:flutter/material.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/login_screen/shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          SharedPreference.removeData(key: "token").then((value) {
            if (value!) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopLoginScreen(),
                  ));
            }
          });
        },
        child: Text("LOGOUT"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:the_wall1/Authentication/Email/Email_signIn/signin_page.dart';

import 'Email/Email_signIn/components/my_button.dart';
import 'Phone/phone_auth.dart';

class AuthOption extends StatelessWidget {
  const AuthOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock,
            size: 100,
          ),
          SizedBox(height: 35),
          MyButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              text: "Email Authentication"),
          SizedBox(height: 20),
          MyButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              text: "Phone Authentication")
        ],
      ),
    );
  }
}

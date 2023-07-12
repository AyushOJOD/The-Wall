import 'package:flutter/material.dart';

import '../Email/Email_signIn/components/my_button.dart';
import '../Email/Email_signIn/components/my_textfield.dart';

class OTPverification extends StatefulWidget {
  const OTPverification({super.key});

  @override
  State<OTPverification> createState() => _OTPverificationState();
}

class _OTPverificationState extends State<OTPverification> {
  TextEditingController OTPcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Icon(
          Icons.key,
          size: 100,
        ),
        MyTextField(
            controller: OTPcontroller,
            hintText: "One Time Password",
            obscureText: false),
        SizedBox(height: 25),
        MyButton(onTap: () {}, text: "Verify OTP"),
      ]),
    );
  }
}

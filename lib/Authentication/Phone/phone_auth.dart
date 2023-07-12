import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Email/Email_signIn/components/my_textfield.dart';
import '../Email/Email_signUp/components/my_button.dart';
import 'otp_verification.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  void getOTP() async {
    String phoneNumber = "+91" + phoneController.text.trim();

    FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 30),
        codeAutoRetrievalTimeout: (verificationId) {},
        phoneNumber: phoneNumber,
        codeSent: (verificationId, resendToken) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OTPverification()));
        },
        verificationCompleted: (PhoneAuthCredential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield

                const SizedBox(height: 10),

                // forgot password?

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () {
                    getOTP();
                  },
                  text: 'Get OTP',
                ),

                const SizedBox(height: 50),

                // or continue with

                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}

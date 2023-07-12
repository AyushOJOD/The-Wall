import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_wall1/components/my_detail_box.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  File? profilePic;

  Future<void> editField(String field) async {
    String newVal = "";

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Edit ' + field),
              content: TextField(
                autocorrect: true,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newVal = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(newVal);
                    },
                    child: Text("Save")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))
              ],
            ));

    if (newVal.trim().length > 0) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .update({field: newVal});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(children: [
                const SizedBox(height: 50),
                // TODO: change this icon with profile picture option
                GestureDetector(
                  onTap: () async {
                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (selectedImage != null) {
                      File convertedFile = File(selectedImage!.path);
                      setState(() {
                        profilePic = convertedFile;
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("No Image Selected!"),
                              ));
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        (profilePic != null) ? FileImage(profilePic!) : null,
                    backgroundColor: Colors.grey,
                    radius: 50,
                  ),
                ),

                SizedBox(height: 10),

                // User Email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "About Me",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),

                MyTextBox(
                    text: userData['username'],
                    sectionName: "UserName",
                    onPressed: () {
                      editField("username");
                    }),
                MyTextBox(
                    text: userData["bio"],
                    sectionName: "Bio",
                    onPressed: () {
                      editField("bio");
                    })
              ]);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

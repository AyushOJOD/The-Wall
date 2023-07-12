import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall1/Authentication/Email/Email_signIn/components/my_textfield.dart';
import 'package:the_wall1/Pages/profile_page.dart';
import 'package:the_wall1/components/drawer.dart';
import 'package:the_wall1/components/wall_posts.dart';

import '../Authentication/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;

  void logOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthOption()));
  }

  void goToPrfilePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyProfile()));
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'message': textController.text,
        'TimeStamp': Timestamp.now(),
        'likes': []
      });
    }

    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "The Wall",
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: goToPrfilePage,
        onLogOut: logOut,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(
          child: Column(children: [
            // The wall
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPosts(
                          message: post['message'],
                          user: post['UserEmail'],
                          likes: List<String>.from(post['likes'] ?? []),
                          postId: post.id,
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: " + snapshot.error.toString()),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )),

            //post message
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyTextField(
                    hintText: "Write something on the wall..",
                    obscureText: false,
                    controller: textController,
                  )),
                  IconButton(
                      onPressed: () {
                        postMessage();
                      },
                      icon: Icon(Icons.arrow_circle_up_rounded))
                ],
              ),
            ),
            // Username
            Text("Logged in as " + currentUser.email!)
          ]),
        ),
      ),
    );
  }
}

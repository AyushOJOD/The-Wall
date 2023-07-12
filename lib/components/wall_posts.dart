import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall1/components/like_button.dart';

class WallPosts extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPosts(
      {super.key,
      required this.message,
      required this.user,
      required this.postId,
      required this.likes});

  @override
  State<WallPosts> createState() => _WallPostsState();
}

class _WallPostsState extends State<WallPosts> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLiked = widget.likes.contains(currentUser.email);
  }

  void ToggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 25, right: 25, top: 23),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey[500]),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.person),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.message),
              SizedBox(height: 10),
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          ),
          Column(
            children: [
              LikeButton(
                  isLiked: isLiked,
                  onTap: () {
                    ToggleLike();
                  }),
              SizedBox(height: 5),
              Text(
                widget.likes.length.toString(),
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    );
  }
}

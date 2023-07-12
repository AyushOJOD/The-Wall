import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall1/components/comment_button.dart';
import 'package:the_wall1/components/comments.dart';
import 'package:the_wall1/components/like_button.dart';

import '../helper/helper_methods.dart';
import 'delete_button.dart';

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
  final commentController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    isLiked = widget.likes.contains(currentUser.email);
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comment")
        .add({
      "commentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void CommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(hintText: "Write a comment... "),
        ),
        actions: [
          TextButton(
              onPressed: () {
                addComment(commentController.text);
                Navigator.pop(context);
                commentController.clear();
              },
              child: Text("Save")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"))
        ],
      ),
    );
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

  void deletePosts() {
    // Show a dialog box
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Post"),
        content: Text("Are you sure want to delete this post? "),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel")),
          TextButton(
              onPressed: () async {
                // delete the comments
                final commentDocs = await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comment")
                    .get();

                for (var doc in commentDocs.docs) {
                  await FirebaseFirestore.instance
                      .collection("User Posts")
                      .doc(widget.postId)
                      .collection("Commment")
                      .doc(doc.id)
                      .delete();
                }

                // delete the post

                FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .delete()
                    .then((value) => print("post Deleted"))
                    .catchError((error) => print("failed to delete post"));

                Navigator.pop(context);
              },
              child: Text("Delete")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 25, right: 25, top: 23),
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              ),
              Column(
                children: [CommmentButton(ontap: CommentDialog), Text("0")],
              ),
              Column(
                children: [
                  if (widget.user == currentUser.email)
                    DeleteButton(
                      ontap: () {
                        deletePosts();
                      },
                    ),
                  SizedBox(height: 15)
                ],
              )
            ],
          ),
          SizedBox(height: 5),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comment")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    //get comment from firebase
                    final commentData = doc.data() as Map<String, dynamic>;

                    //show the comment
                    return Comments(
                      text: commentData['commentText'],
                      user: commentData['CommentedBy'],
                      time: formatDate(commentData['CommentTime']),
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}

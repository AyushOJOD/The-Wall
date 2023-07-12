import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comments(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          // Comment
          Text(text),
          const SizedBox(height: 5),
          // User and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(user), Text(" * "), Text(time)],
          )
        ],
      ),
    );
  }
}

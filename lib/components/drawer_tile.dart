import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? ontap;
  const DrawerTile(
      {super.key, required this.icon, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: ontap,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

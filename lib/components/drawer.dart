import 'package:flutter/material.dart';
import 'package:the_wall1/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogOut;
  const MyDrawer({super.key, this.onProfileTap, this.onLogOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // photo
          DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          )),

          //home
          DrawerTile(
            icon: Icons.home,
            text: "H O M E",
            ontap: () {
              Navigator.pop(context);
            },
          ),

          //My Profile
          DrawerTile(
              icon: Icons.person, text: "P R O F I L E", ontap: onProfileTap),

          //Log Out
          DrawerTile(
              icon: Icons.exit_to_app, text: "L O G   O U T", ontap: onLogOut)
        ],
      ),
    );
  }
}

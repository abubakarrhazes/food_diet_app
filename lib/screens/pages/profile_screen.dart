// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_diet_app/providers/persistance_data/user_adapter.dart';
import 'package:food_diet_app/theme/theme.dart';
import 'package:food_diet_app/widgets/build_list_tiles.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(''),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                    '${userAdapter.user?.firstName} ${userAdapter.user?.lastName}'),
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('My Account'),
                ),
                BuildListTiles(
                  title: 'Update Account Info',
                  leadingIcon: Icons.person_outlined,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Notifications',
                  leadingIcon: Icons.notifications_active,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Change Password',
                  leadingIcon: Icons.lock,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Settings',
                  leadingIcon: Icons.settings,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Help Desk',
                  leadingIcon: Icons.support_agent,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Contact Developers',
                  leadingIcon: Icons.call_outlined,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Rate our App',
                  leadingIcon: Icons.star_border_rounded,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Policy of the application',
                  leadingIcon: Icons.book_outlined,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Delete Account',
                  leadingIcon: Icons.delete_forever_outlined,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 5,
                ),
                BuildListTiles(
                  title: 'Log Out',
                  leadingIcon: Icons.logout_rounded,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

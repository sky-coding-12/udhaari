import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.black38,
                  radius: 45.0,
                ),
                SizedBox(width: 15.0),
              ],
            ),
            const SizedBox(height: 40.0),
            Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.home_outlined,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Home"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.card_travel,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("My Cart"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.history_edu,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Order History"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.event_note_rounded,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Enter Promo Code"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.wallet_membership,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Wallet"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.star_border,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Favorites"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.policy_outlined,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("FAQs"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.call_outlined,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Support"),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(
                      Icons.settings_outlined,
                      size: 27.0,
                    ),
                    SizedBox(width: 12.0),
                    Text("Settings"),
                  ],
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        size: 27.0,
                      ),
                      SizedBox(width: 12.0),
                      Text("Logout"),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text("Terms of Service | Privacy Policy")
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class ParticularUser extends StatefulWidget {
  final int phone;
  const ParticularUser({Key? key, required this.phone}) : super(key: key);

  @override
  State<ParticularUser> createState() => _ParticularUserState();
}

class _ParticularUserState extends State<ParticularUser> {
  late Future<UserSpringBootModel> user;
  late int phone;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    user = fetchUser(phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("${snapshot.data!.image}"),
                      ),
                      Text("${snapshot.data!.userName}"),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

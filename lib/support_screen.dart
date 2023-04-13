import 'package:flutter/material.dart';

import 'Constant/const_variable.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 25.5,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/support.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "call +91 1234567890",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "take_it.support@gmail.com",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/app_logo.png'),
                    ),
                  ),
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    "©2023 take_it 🗿 | all rights reserved",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

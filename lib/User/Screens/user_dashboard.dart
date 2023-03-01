import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:take_it/User/Screens/particular_vendor.dart';
import 'package:take_it/who_are_you.dart';

import '../../Components/CustomDrawer.dart';
import '../../Constant/const_variable.dart';
import '../../Models/demo.dart';
import '../../provider/auth_provider.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _advancedDrawerController = AdvancedDrawerController();

  Future<List<Demo>> fetchData() async {
    const String baseUrl = "http://192.168.29.135:8080";
    String url = "$baseUrl/user/get";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<Demo> users = [];
    if (response.statusCode == 200) {
      for (var user in responseData) {
        Demo demo = Demo(
          age: user["age"],
          gender: user["gender"],
          name: user["name"],
          id: user["id"],
        );
        users.add(demo);
      }

      return users;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return AdvancedDrawer(
      backdropColor: Colors.white70,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const CustomDrawer(),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _advancedDrawerController.showDrawer(),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(ap.userModel.profilePic),
                          radius: 22.0,
                        ),
                      ),
                      IconButton(
                        tooltip: "Notification",
                        onPressed: () => {
                          ap.userSignOut().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WhoAreYou()))),
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30.0),
                  Center(
                    child: CircularPercentIndicator(
                      radius: 90,
                      lineWidth: 20.0,
                      percent: 0.5,
                      animation: true,
                      animationDuration: 2000,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text("50%"),
                      progressColor: mainColor,
                      backgroundColor: const Color.fromRGBO(63, 72, 204, 0.4),
                    ),
                    // child: CircleAvatar(
                    //   backgroundColor: Colors.purple,
                    //   backgroundImage: NetworkImage(ap.userModel.profilePic),
                    //   radius: 50,
                    // ),
                  ),
                  SizedBox(height: 17.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Credit : XXX"),
                        Text("Debit : XXX"),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Divider(thickness: 2.0),
                  SizedBox(height: 5.0),
                  FutureBuilder(
                    future: fetchData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("${snapshot.error}");
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              elevation: 2.0,
                              child: InkWell(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ParticularVendor(
                                      index: index,
                                      name: snapshot.data[index].name,
                                    ),
                                  )),
                                },
                                splashColor:
                                    const Color.fromRGBO(63, 72, 204, 0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 60.0,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 35.0,
                                          backgroundColor: index % 2 == 0
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${snapshot.data[index].name}",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: mainColor),
                                            ),
                                            Text("total Credit"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => ListTile(
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].gender),
                            contentPadding: const EdgeInsets.only(bottom: 20.0),
                          ),
                        );
                      }
                      return Center(
                        child: CircularPercentIndicator(
                          radius: 5.0,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

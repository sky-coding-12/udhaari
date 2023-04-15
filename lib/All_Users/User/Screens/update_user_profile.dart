import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../services/api_calling.dart';
import '../../../utils/utils.dart';
import 'user_dashboard.dart';

class UpdateUserProfile extends StatefulWidget {
  final String phone;
  const UpdateUserProfile({Key? key, required this.phone}) : super(key: key);

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  File? image;

  late Future<UserSpringBootModel> user;
  late String phone;
  late String imageUrl;
  late String password;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool validUsername = true;
  bool validPIN = true;
  bool validEmail = true;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      user = fetchUser(phone);
    });
    user.then(
      (value) => {
        _usernameController.text = value.userName!,
        _pinController.text = value.securityPIN!,
        _emailController.text = value.email!,
        imageUrl = value.image!,
        password = value.password!,
      },
    );
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: mainColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Update Profile",
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: ChangeNotifierProvider<VisibilityModel>(
            create: (context) => VisibilityModel(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FutureBuilder(
                  future: user,
                  builder: (builder, snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => selectImage(),
                              child: image == null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(imageUrl),
                                      radius: 100,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 100,
                                    ),
                            ),
                            const SizedBox(height: 10),
                            Consumer<VisibilityModel>(
                              builder: (context, myModel, child) {
                                return TextField(
                                  onChanged: (val) => {
                                    myModel.changeUsernameValidation(val),
                                    if (myModel.isUsernameValid)
                                      {
                                        validUsername = true,
                                      }
                                    else
                                      {
                                        validUsername = false,
                                      }
                                  },
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 12.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: myModel.isUsernameValid
                                            ? mainColor
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Username",
                                    prefixIcon: Icon(
                                      CupertinoIcons.person,
                                      color: mainColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 15.0),
                            Consumer<VisibilityModel>(
                              builder: (context, myModel, child) {
                                return TextField(
                                  obscureText: !myModel.isPinVisible,
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) => {
                                    myModel.changePINValidation(val),
                                    if (myModel.isPINValid)
                                      {
                                        validPIN = true,
                                      }
                                    else
                                      {
                                        validPIN = false,
                                      }
                                  },
                                  controller: _pinController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 12.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: myModel.isPINValid
                                            ? mainColor
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: myModel.isPinVisible
                                          ? const Icon(
                                              CupertinoIcons.eye,
                                            )
                                          : const Icon(
                                              CupertinoIcons.eye_slash,
                                            ),
                                      onPressed: () =>
                                          myModel.changePinVisibility(),
                                      color: mainColor,
                                    ),
                                    hintText: "Security PIN (4 digit)",
                                    prefixIcon: Icon(
                                      CupertinoIcons.number,
                                      color: mainColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 15.0),
                            Consumer<VisibilityModel>(
                              builder: (context, myModel, child) {
                                return TextField(
                                  onChanged: (val) => {
                                    myModel.changeEmailValidation(val),
                                    if (myModel.isEmailValid)
                                      {
                                        validEmail = true,
                                      }
                                    else
                                      {
                                        validEmail = false,
                                      }
                                  },
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 12.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: myModel.isEmailValid
                                            ? mainColor
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Email Address",
                                    prefixIcon: Icon(
                                      CupertinoIcons.mail,
                                      color: mainColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(63, 72, 204, 1))),
                                  child: const Text(
                                    "UPDATE PROFILE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (validPIN &&
                                        validEmail &&
                                        validUsername) {
                                      if (image == null) {
                                        updateUserProfile(
                                          phone,
                                          snapshot.data!.password,
                                          _usernameController.text.trim(),
                                          snapshot.data!.totalDebit,
                                          snapshot.data!.totalCredit,
                                          snapshot.data!.creditScore,
                                          snapshot.data!.userId,
                                          _pinController.text.trim(),
                                          _emailController.text.trim(),
                                          snapshot.data!.image,
                                        )
                                            .then((value) => {
                                                  _firebaseFireStore
                                                      .collection("users")
                                                      .doc(
                                                          "+91${value.phoneNumber}")
                                                      .update({
                                                    "name": value.userName,
                                                    "email": value.email,
                                                    "securityPIN":
                                                        value.securityPIN,
                                                  })
                                                })
                                            .then((value) => {
                                                  AwesomeDialog(
                                                    context: context,
                                                    headerAnimationLoop: true,
                                                    animType: AnimType.scale,
                                                    btnCancelColor: mainColor,
                                                    dialogType:
                                                        DialogType.success,
                                                    btnOkOnPress: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const UserDashboard(),
                                                        ),
                                                      );
                                                    },
                                                    btnOkColor: mainColor,
                                                    title: 'Success',
                                                    desc:
                                                        'Profile Updated Successfully 😊',
                                                  ).show(),
                                                });
                                      } else {
                                        storeUserFileToStorage(
                                                "profilePic/users/${snapshot.data!.userName}",
                                                image)
                                            .then((value) => {
                                                  updateUserProfile(
                                                    phone,
                                                    snapshot.data!.password,
                                                    _usernameController.text
                                                        .trim(),
                                                    snapshot.data!.totalDebit,
                                                    snapshot.data!.totalCredit,
                                                    snapshot.data!.creditScore,
                                                    snapshot.data!.userId,
                                                    _pinController.text.trim(),
                                                    _emailController.text
                                                        .trim(),
                                                    value,
                                                  )
                                                      .then((value) => {
                                                            _firebaseFireStore
                                                                .collection(
                                                                    "users")
                                                                .doc(
                                                                    "+91${value.phoneNumber}")
                                                                .update({
                                                              "name": value
                                                                  .userName,
                                                              "email":
                                                                  value.email,
                                                              "securityPIN": value
                                                                  .securityPIN,
                                                              "profilePic":
                                                                  value.image,
                                                            })
                                                          })
                                                      .then((value) => {
                                                            AwesomeDialog(
                                                              context: context,
                                                              headerAnimationLoop:
                                                                  true,
                                                              animType: AnimType
                                                                  .scale,
                                                              btnCancelColor:
                                                                  mainColor,
                                                              dialogType:
                                                                  DialogType
                                                                      .success,
                                                              btnOkOnPress: () {
                                                                Navigator
                                                                    .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const UserDashboard(),
                                                                  ),
                                                                );
                                                              },
                                                              btnOkColor:
                                                                  mainColor,
                                                              title: 'Success',
                                                              desc:
                                                                  'Profile Updated Successfully 😊',
                                                            ).show(),
                                                          }),
                                                });
                                      }
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: true,
                                        animType: AnimType.scale,
                                        btnCancelColor: mainColor,
                                        dialogType: DialogType.error,
                                        btnCancelOnPress: () {},
                                        title: 'Invalid Details',
                                        desc: 'Please, enter valid details',
                                      ).show();
                                    }
                                  }),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 2 - 100,
                          ),
                          CircularProgressIndicator(
                            color: mainColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }

  Future<UserSpringBootModel> updateUserProfile(
      String phone,
      String? password,
      String userName,
      int? totalDebit,
      int? totalCredit,
      int? creditScore,
      int? userId,
      String securityPIN,
      String email,
      String? image) async {
    final response = await http.put(
      Uri.https(baseUrl, "/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': userName,
        'phoneNumber': phone,
        'email': email,
        'password': password,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'creditScore': creditScore,
        'securityPIN': securityPIN,
        'image': image,
        'userId': userId
      }),
    );

    if (response.statusCode == 200) {
      return UserSpringBootModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user password.');
    }
  }

  Future<String> storeUserFileToStorage(String ref, File? file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

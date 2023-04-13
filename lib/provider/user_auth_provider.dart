import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../All_Users/User/Credential/otp_verification.dart';
import '../Constant/const_variable.dart';
import '../Models/user_model.dart';
import '../services/api_calling.dart';
import '../utils/utils.dart';

class UserAuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  bool? _isNotEmptyStr = false;
  bool get isNotEmptyStr => _isNotEmptyStr!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  UserAuthProvider() {
    checkUserSign();
  }

  void checkUserSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    _isNotEmptyStr = s.getBool("is_notEmptyString") ?? false;
    notifyListeners();
  }

  Future setUserSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setBool("is_notEmptyString", true);
    _isSignedIn = true;
    _isNotEmptyStr = true;
    notifyListeners();
  }

  // signin
  void signInWithPhoneUser(
      BuildContext context, String phoneNumber, String password) async {
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("users").doc(phoneNumber).get();
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            AwesomeDialog(
              context: context,
              headerAnimationLoop: true,
              animType: AnimType.scale,
              btnCancelColor: mainColor,
              dialogType: DialogType.error,
              btnCancelOnPress: () {},
              title: 'Incorrect Password',
              desc: 'Please enter correct password',
            ).show();
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) async {
            if (snapshot.exists) {
              _uid = snapshot.get("phoneNumber");
              String pass = snapshot.get("password");
              if (pass == password) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserOtpScreen(verificationId: verificationId),
                  ),
                );
              } else {
                AwesomeDialog(
                  context: context,
                  headerAnimationLoop: true,
                  animType: AnimType.scale,
                  btnCancelColor: mainColor,
                  dialogType: DialogType.error,
                  btnCancelOnPress: () {},
                  title: 'Incorrect Password',
                  desc: 'Please enter correct password',
                ).show();
              }
            } else {
              AwesomeDialog(
                context: context,
                headerAnimationLoop: true,
                animType: AnimType.scale,
                btnCancelColor: mainColor,
                dialogType: DialogType.error,
                btnCancelOnPress: () {},
                title: "Account doesn't exists",
                desc: 'Please first create account',
              ).show();
            }
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyUserOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: true,
        animType: AnimType.scale,
        btnCancelColor: mainColor,
        dialogType: DialogType.error,
        btnCancelOnPress: () {},
        title: 'Invalid OTP',
        desc: 'Please enter valid OTP',
      ).show();
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERATIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
    required String name,
    required String phone,
    required String email,
    required String password,
    required String pin,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeUserFileToStorage(
              "profilePic/users/${userModel.name}", profilePic)
          .then((value) {
        createUser(name, phone, email, password, pin, value);
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.uid = userModel.phoneNumber;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFireStore
          .collection("users")
          .doc(_userModel?.phoneNumber)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeUserFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getUserDataFromFireStore() async {
    await _firebaseFireStore
        .collection("users")
        .doc(_uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        password: snapshot['password'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
        securityPIN: snapshot['securityPIN'],
      );
    });
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getUserDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    if (data.isNotEmpty) {
      _isNotEmptyStr = true;
      _userModel = UserModel.fromMap(jsonDecode(data));
    } else {
      _isNotEmptyStr = false;
    }
    print(_isNotEmptyStr);
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}

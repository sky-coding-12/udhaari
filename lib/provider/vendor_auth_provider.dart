import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_it/Models/vendor_model.dart';

import '../All_Users/Vendor/Credential/otp_verification.dart';
import '../Constant/const_variable.dart';
import '../services/api_calling.dart';
import '../utils/utils.dart';

class VendorAuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  bool? _isNotEmptyStr = false;
  bool get isNotEmptyStr => _isNotEmptyStr!;
  VendorModel? _vendorModel;
  VendorModel get vendorModel => _vendorModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  VendorAuthProvider() {
    checkVendorSign();
  }

  void checkVendorSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    _isNotEmptyStr = s.getBool("is_notEmptyString") ?? false;
    notifyListeners();
  }

  Future setVendorSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setBool("is_notEmptyString", true);
    _isSignedIn = true;
    _isNotEmptyStr = true;
    notifyListeners();
  }

  // signin
  void signInWithPhoneVendor(
      BuildContext context, String phoneNumber, String password) async {
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("vendors").doc(phoneNumber).get();
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
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
                        VendorOtpScreen(verificationId: verificationId),
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
  void verifyVendorOtp({
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
  Future<bool> checkExistingVendor() async {
    DocumentSnapshot snapshot =
        await _firebaseFireStore.collection("vendors").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void saveVendorDataToFirebase({
    required BuildContext context,
    required VendorModel vendorModel,
    required File profilePic,
    required Function onSuccess,
    required String vendorName,
    required String shopName,
    required String phone,
    required String address,
    required String password,
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeVendorFileToStorage(
              "profilePic/vendors/${vendorModel.name}", profilePic)
          .then((value) {
        createVendor(
            vendorName, shopName, phone, email, password, address, value);
        vendorModel.profilePic = value;
        vendorModel.createdAt =
            DateTime.now().millisecondsSinceEpoch.toString();
        vendorModel.uid = vendorModel.phoneNumber;
      });
      _vendorModel = vendorModel;

      // uploading to database
      await _firebaseFireStore
          .collection("vendors")
          .doc(_vendorModel?.phoneNumber)
          .set(vendorModel.toMap())
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

  Future<String> storeVendorFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getVendorDataFromFireStore() async {
    await _firebaseFireStore
        .collection("vendors")
        .doc(_uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _vendorModel = VendorModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        password: snapshot['password'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
        shopName: snapshot['shopName'],
      );
    });
  }

  Future saveVendorDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("vendor_model", jsonEncode(vendorModel.toMap()));
  }

  Future getVendorDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("vendor_model") ?? '';
    if (data.isNotEmpty) {
      _isNotEmptyStr = true;
      _vendorModel = VendorModel.fromMap(jsonDecode(data));
    } else {
      _isNotEmptyStr = false;
    }

    notifyListeners();
  }

  Future vendorSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../All_Users/Bank/Credential/otp_verification.dart';
import '../Models/bank_model.dart';
import '../services/api_calling.dart';
import '../utils/utils.dart';

class BankAuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  bool? _isNotEmptyStr = false;
  bool get isNotEmptyStr => _isNotEmptyStr!;
  BankModel? _bankModel;
  BankModel get bankModel => _bankModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  BankAuthProvider() {
    checkBankSign();
  }

  void checkBankSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    _isNotEmptyStr = s.getBool("is_notEmptyString") ?? false;
    notifyListeners();
  }

  Future setBankSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    s.setBool("is_notEmptyString", true);
    _isSignedIn = true;
    _isNotEmptyStr = true;
    notifyListeners();
  }

  // signin
  void signInWithPhoneBank(BuildContext context, String phoneNumber) async {
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
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BankOtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyBankOtp({
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
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERATIONS
  Future<bool> checkExistingBank() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("banks").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void saveBankDataToFirebase({
    required BuildContext context,
    required BankModel bankModel,
    required File profilePic,
    required Function onSuccess,
    required String bankName,
    required String bankAddress,
    required String bankBranch,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeBankFileToStorage("profilePic/banks/$_uid", profilePic)
          .then((value) {
        createBank(
            bankName,
            _firebaseAuth.currentUser!.phoneNumber!.substring(2),
            bankAddress,
            value,
            bankBranch);
        bankModel.profilePic = value;
        bankModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        bankModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        bankModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _bankModel = bankModel;

      // uploading to database
      await _firebaseFirestore
          .collection("banks")
          .doc(_uid)
          .set(bankModel.toMap())
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

  Future<String> storeBankFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getBankDataFromFireStore() async {
    await _firebaseFirestore
        .collection("banks")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _bankModel = BankModel(
        name: snapshot['name'],
        branchName: snapshot['branchName'],
        createdAt: snapshot['createdAt'],
        address: snapshot['address'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = bankModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveBankDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("bank_model", jsonEncode(bankModel.toMap()));
  }

  Future getBankDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("bank_model") ?? '';
    if (data.isNotEmpty) {
      _isNotEmptyStr = true;
      _bankModel = BankModel.fromMap(jsonDecode(data));
      _uid = _bankModel!.uid;
    } else {
      _isNotEmptyStr = false;
    }
    notifyListeners();
  }

  Future bankSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}

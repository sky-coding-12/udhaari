import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/transaction_model.dart';
import '../../../Models/user_spring_boot_model.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../services/api_calling.dart';
import 'user_dashboard.dart';

class PaymentScreen extends StatefulWidget {
  final String vendorPhone;
  final String userPhone;
  final String dueDate;
  final int amount;
  final int transactionId;
  const PaymentScreen({
    Key? key,
    required this.vendorPhone,
    required this.userPhone,
    required this.dueDate,
    required this.amount,
    required this.transactionId,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String vendorPhone;
  late String userPhone;
  late int transactionId;
  late int remainingDays;
  late int upDays;

  late DateTime payDate;
  final currDate = DateTime.now();

  late Future<VendorSpringBootModel> vendor;
  late Future<UserSpringBootModel> user;
  late Future<TransactionModel> transaction;
  late Future<List<int>> amounts;

  final _razorpay = Razorpay();

  late String password;
  late String username;
  late String email;
  late int totalDebit;
  late int totalCredit;
  late int creditScore;
  late int userId;
  late String pin;
  late String image;

  String? securityPIN;
  late int amount;

  late int vendorId;
  late String status;
  late String paymentStatus;
  late String creditDebitStatus;
  late String dueDate;
  late String transactionDate;

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    amount = widget.amount;
    transactionId = widget.transactionId;
    final splitted = widget.dueDate.split('/');
    int day = int.parse(splitted[1]);
    int month = int.parse(splitted[0]);
    int year = int.parse(splitted[2]);
    final payDate = DateTime(year, month, day);
    setState(() {
      vendor = fetchParticularVendor(vendorPhone);
      user = fetchUser(userPhone);
      amounts =
          fetchParticularVendorCreditDebit(userPhone, vendorPhone.toString());
      transaction = fetchOneTransaction(transactionId.toString());
    });
    transaction.then((value) => {
          status = value.status!,
          vendorId = value.vendorId!,
          paymentStatus = value.paymentStatus!,
          dueDate = value.dueDate!,
          transactionDate = value.transactionDate!,
          creditDebitStatus = value.creditDebitStatus!,
        });
    remainingDays = payDate.difference(currDate).inDays;
    upDays = currDate.difference(payDate).inDays;
    user.then((value) => {
          password = value.password!,
          username = value.userName!,
          totalDebit = value.totalDebit!,
          totalCredit = value.totalCredit!,
          creditScore = value.creditScore!,
          userId = value.userId!,
          pin = value.securityPIN!,
          image = value.image!,
          email = value.email!,
        });
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    if (await payment(
      DateFormat.yMd().format(DateTime.now()),
      "Done",
      DateFormat.yMd().format(DateTime.now()),
      userPhone,
      vendorPhone,
      amount.toString(),
      "debit",
    )) {
      if (await updateUserCredit(userPhone, username, totalDebit, totalCredit,
          creditScore, userId, securityPIN!, email, image, amount.toString())) {
        await updateUserTransaction(transactionId, userId, vendorId, status,
                creditDebitStatus, amount, dueDate, transactionDate)
            .whenComplete(() => AwesomeDialog(
                  context: context,
                  headerAnimationLoop: true,
                  animType: AnimType.scale,
                  btnCancelColor: mainColor,
                  dialogType: DialogType.success,
                  btnOkOnPress: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserDashboard(),
                      ),
                    );
                  },
                  btnOkColor: mainColor,
                  title: 'Success',
                  desc: 'Transaction successfully 😁',
                ).show());
      }
    } else {
      AwesomeDialog(
        context: context,
        headerAnimationLoop: true,
        animType: AnimType.scale,
        btnCancelColor: mainColor,
        dialogType: DialogType.error,
        btnCancelOnPress: () {},
        title: 'Something went to wrong',
        desc: 'Please, make one more transaction',
      ).show();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      animType: AnimType.scale,
      btnCancelColor: mainColor,
      dialogType: DialogType.error,
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserDashboard(),
          ),
        );
      },
      btnOkColor: mainColor,
      title: 'Failed',
      desc: 'Transaction Unsuccessfully 🫥',
    ).show();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
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
            "Payment",
            style: TextStyle(
              color: mainColor,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: amounts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/payment.png"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Payable Amount : ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.first - snapshot.data!.last}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            const Divider(
                              height: 2.0,
                              color: Colors.black38,
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Enter the Security PIN for make Transaction 💵",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Pinput(
                              length: 4,
                              showCursor: true,
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: mainColor,
                                  ),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onCompleted: (value) {
                                setState(() {
                                  securityPIN = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(63, 72, 204, 1))),
                                child: const Text(
                                  "PAY MONEY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onPressed: () async {
                                  var options = {
                                    'key': 'rzp_test_jM65Pd3Z7hBdBx',
                                    'amount': amount * 100,
                                    'name': 'Take it',
                                    'description': 'Money Transaction',
                                    'timeout': 300,
                                    'prefill': {
                                      'contact': userPhone,
                                      'email': 'test@razorpay.com'
                                    }
                                  };
                                  if (securityPIN != null) {
                                    if (securityPIN == pin) {
                                      try {
                                        _razorpay.open(options);
                                      } catch (e) {
                                        print(e.toString());
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
                                        desc:
                                            'Please, enter valid security PIN',
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
                                      title: 'Invalid Security Code',
                                      desc: 'Enter 4-Digit code',
                                    ).show();
                                  }
                                },
                              ),
                            ),
                          ],
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
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> payment(
      String dueDate,
      String status,
      String transactionDate,
      String userPhone,
      String vendorPhone,
      String amount,
      String credit_debit_status) async {
    String url = "https://$baseUrl/transaction/saveTransaction";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userPhone,
        "vendorId": vendorPhone,
        "status": status,
        "paymentStatus": "Complete",
        "dueDate": dueDate,
        "transactionDate": transactionDate,
        "amount": amount,
        "creditDebitStatus": credit_debit_status
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to make transaction.');
    }
  }

  Future<bool> updateUserCredit(
      String userPhone,
      String username,
      int totalDebit,
      int totalCredit,
      int creditScore,
      int userId,
      String pin,
      String email,
      String image,
      String amount) async {
    int money = int.parse(amount);
    final response = await http.put(
      Uri.https(baseUrl, "/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': username,
        'phoneNumber': userPhone,
        'email': email,
        'password': password,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit + money,
        'creditScore': remainingDays > 0
            ? creditScore >= 95
                ? creditScore == 100
                    ? creditScore
                    : creditScore + 1
                : creditScore + (remainingDays % 5)
            : creditScore - (upDays % 25),
        'securityPIN': pin,
        'image': image,
        'userId': userId
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user password.');
    }
  }

  Future<void> updateUserTransaction(
    int transactionId,
    int userId,
    int vendorId,
    String status,
    String creditDebitStatus,
    int amount,
    String dueDate,
    String transactionDate,
  ) async {
    final response = await http.put(
      Uri.https(baseUrl, "/transaction/updateTransaction"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userPhone,
        "transactionId": transactionId,
        "vendorId": vendorPhone,
        "status": status,
        "paymentStatus": "Complete",
        "dueDate": dueDate,
        "transactionDate": transactionDate,
        "amount": amount,
        "creditDebitStatus": creditDebitStatus
      }),
    );
  }
}

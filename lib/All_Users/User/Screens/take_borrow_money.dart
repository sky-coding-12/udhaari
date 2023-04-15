import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:take_it/Constant/const_variable.dart';
import 'package:take_it/Models/user_spring_boot_model.dart';
import 'package:take_it/Modules/visibility_model.dart';
import 'package:take_it/services/api_calling.dart';

import '../../../Models/vendor_spring_boot_model.dart';
import 'user_dashboard.dart';

class TakeMoney extends StatefulWidget {
  final String vendorPhone;
  final String userPhone;
  const TakeMoney(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<TakeMoney> createState() => _TakeMoneyState();
}

class _TakeMoneyState extends State<TakeMoney> {
  late String vendorPhone;
  late String userPhone;
  late Future<VendorSpringBootModel> vendor;
  late Future<UserSpringBootModel> user;

  late TextEditingController _moneyController;
  late TextEditingController _dateController;

  bool validMoney = false;
  bool validDate = false;

  late String password;
  late String username;
  late String email;
  late int totalDebit;
  late int totalCredit;
  late int creditScore;
  late int userId;
  late String pin;
  late String image;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    _moneyController = TextEditingController();
    _dateController = TextEditingController();
    setState(() {
      vendor = fetchParticularVendor(vendorPhone);
      user = fetchUser(userPhone);
    });
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

  @override
  void dispose() {
    super.dispose();
    _moneyController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserDashboard()));
            },
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Take Borrow Money",
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
            child: Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: vendor,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/take_money.png"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "Shop Name : ${snapshot.data!.shopName!.toUpperCase()}",
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              "Vendor Name : ${snapshot.data!.vendorName}",
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Divider(
                              height: 2.0,
                              color: Colors.black38,
                            ),
                            const SizedBox(height: 10.0),
                            Consumer<VisibilityModel>(
                              builder: (context, myModel, child) {
                                return TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) => {
                                    myModel.changeMoneyValidation(val),
                                    if (myModel.isMoneyValid)
                                      {
                                        validMoney = true,
                                      }
                                    else
                                      {
                                        validMoney = false,
                                      }
                                  },
                                  controller: _moneyController,
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
                                        color: myModel.isMoneyValid
                                            ? mainColor
                                            : Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Amount",
                                    prefixIcon: Icon(
                                      CupertinoIcons.money_dollar,
                                      color: mainColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 22.0,
                                  vertical: 12.0,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.calendar_today,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat.yMd().format(pickedDate);

                                      setState(() {
                                        _dateController.text = formattedDate;
                                        validDate = true;
                                      });
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        headerAnimationLoop: true,
                                        animType: AnimType.scale,
                                        btnCancelColor: mainColor,
                                        dialogType: DialogType.warning,
                                        btnCancelOnPress: () {},
                                        title: 'Invalid Date',
                                        desc: 'Please, select date',
                                      ).show();
                                    }
                                  },
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
                                    color: mainColor,
                                    width: 1.5,
                                  ),
                                ),
                                hintText: "Select Payment Date",
                                prefixIcon: Icon(
                                  CupertinoIcons.calendar_badge_plus,
                                  color: mainColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(63, 72, 204, 1))),
                                child: const Text(
                                  "TAKE BORROW",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onPressed: () async {
                                  if (validDate && validMoney) {
                                    if (await takeBorrow(
                                      _dateController.text.trim(),
                                      "Pending",
                                      DateFormat.yMd().format(DateTime.now()),
                                      userPhone,
                                      vendorPhone,
                                      _moneyController.text.trim(),
                                      "credit",
                                    )) {
                                      if (await updateUserCredit(
                                          userPhone,
                                          username,
                                          totalDebit,
                                          totalCredit,
                                          creditScore,
                                          userId,
                                          pin,
                                          email,
                                          image,
                                          _moneyController.text.trim())) {
                                        if (await updateVendorDebit(
                                          vendorPhone,
                                          snapshot.data!.password,
                                          snapshot.data!.vendorName,
                                          snapshot.data!.totalDebit,
                                          snapshot.data!.address,
                                          snapshot.data!.totalLoanAmount,
                                          snapshot.data!.vendorId,
                                          snapshot.data!.shopName,
                                          snapshot.data!.email,
                                          snapshot.data!.image,
                                          _moneyController.text.trim(),
                                        )) {
                                          AwesomeDialog(
                                            context: context,
                                            headerAnimationLoop: true,
                                            animType: AnimType.scale,
                                            btnCancelColor: mainColor,
                                            dialogType: DialogType.success,
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
                                            desc: 'Transaction Successfully 😊',
                                          ).show();
                                        }
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
                                        desc:
                                            'Please, make one more transaction',
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
                                      title: 'Invalid Details',
                                      desc: 'Please, enter valid details',
                                    ).show();
                                  }
                                },
                              ),
                            )
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
                )),
          ),
        ),
      ),
    );
  }

  Future<bool> takeBorrow(
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
        "paymentStatus": "Pending",
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
        'totalCredit': totalCredit + money,
        'totalDebit': totalDebit,
        'creditScore': creditScore,
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

  Future<bool> updateVendorDebit(
      String vendorPhone,
      String? password,
      String? vendorName,
      int? totalDebit,
      String? address,
      int? totalLoanAmount,
      int? vendorId,
      String? shopName,
      String? email,
      String? image,
      String? amount) async {
    int money = int.parse(amount!);
    final response = await http.put(
      Uri.https(baseUrl, "/vendor/updateVendor"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'vendorName': vendorName,
        'phoneNumber': vendorPhone,
        'email': email,
        'password': password,
        'totalLoanAmount': totalLoanAmount,
        'totalDebit': totalDebit! + money,
        'shopName': shopName,
        'address': address,
        'image': image,
        'vendorId': vendorId
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update vendor password.');
    }
  }
}

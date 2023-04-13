import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:take_it/Models/bank_spring_boot_model.dart';
import 'package:take_it/Models/vendor_spring_boot_model.dart';

import '../Constant/const_variable.dart';
import '../Models/time_request_model.dart';
import '../Models/transaction_model.dart';
import '../Models/user_spring_boot_model.dart';

Future<List<UserSpringBootModel>> fetchAllUsers() async {
  String url = "https://$baseUrl/user/getAllUser";
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body);
  List<UserSpringBootModel> users = [];
  if (response.statusCode == 200) {
    for (var user in responseData) {
      UserSpringBootModel u1 = UserSpringBootModel(
        creditScore: user["creditScore"],
        password: user["password"],
        email: user["email"],
        phoneNumber: user["phoneNumber"],
        securityPIN: user["securityPIN"],
        userName: user["userName"],
        totalCredit: user["totalCredit"],
        totalDebit: user["totalDebit"],
        userId: user["userId"],
        image: user["image"],
      );
      users.add(u1);
    }

    return users;
  } else {
    throw Exception('Failed to load AllUsers data');
  }
}

Future<List<VendorSpringBootModel>> fetchAllVendors() async {
  String url = "https://$baseUrl/vendor/getAllVendor";
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body);
  List<VendorSpringBootModel> vendors = [];
  if (response.statusCode == 200) {
    for (var vendor in responseData) {
      VendorSpringBootModel u1 = VendorSpringBootModel(
        totalDebit: vendor['totalDebit'],
        phoneNumber: vendor['phoneNumber'],
        password: vendor['password'],
        email: vendor['email'],
        address: vendor['address'],
        shopName: vendor['shopName'],
        totalLoanAmount: vendor['totalLoanAmount'],
        vendorId: vendor['vendorId'],
        vendorName: vendor['vendorName'],
        image: vendor['image'],
      );
      vendors.add(u1);
    }

    return vendors;
  } else {
    throw Exception('Failed to load AllVendors data');
  }
}

Future<List<VendorSpringBootModel>> fetchAllVendorsOnCredit(
    String phoneNumber) async {
  final response = await http.get(Uri.https(
      baseUrl, "/user/getVendorOnUserCredit", {"phoneNumber": phoneNumber}));
  var responseData = json.decode(response.body);
  List<VendorSpringBootModel> vendors = [];
  if (response.statusCode == 200) {
    for (var vendor in responseData) {
      VendorSpringBootModel u1 = VendorSpringBootModel(
        totalDebit: vendor['totalDebit'],
        phoneNumber: vendor['phoneNumber'],
        password: vendor['password'],
        email: vendor['email'],
        address: vendor['address'],
        shopName: vendor['shopName'],
        totalLoanAmount: vendor['totalLoanAmount'],
        vendorId: vendor['vendorId'],
        vendorName: vendor['vendorName'],
        image: vendor['image'],
      );
      vendors.add(u1);
    }

    return vendors;
  } else {
    throw Exception('Failed to load AllVendorsOnCredit data');
  }
}

Future<List<BankSpringBootModel>> fetchAllBanks() async {
  String url = "https://$baseUrl/bank/getBank";
  final response = await http.get(Uri.parse(url));
  var responseData = json.decode(response.body);
  List<BankSpringBootModel> banks = [];
  if (response.statusCode == 200) {
    for (var bank in responseData) {
      BankSpringBootModel u1 = BankSpringBootModel(
        bankAddress: bank['bankAddress'],
        phoneNumber: bank['phoneNumber'],
        bankBranch: bank['bankBranch'],
        bankId: bank['bankId'],
        bankName: bank['bankName'],
        image: bank['image'],
      );
      banks.add(u1);
    }

    return banks;
  } else {
    throw Exception('Failed to load AllBanks data');
  }
}

Future<List<TransactionModel>> fetchAllTransaction(String phoneNumber) async {
  final response = await http.get(Uri.https(
      baseUrl, "/user/getAllTransactions", {"phoneNumber": phoneNumber}));
  var responseData = json.decode(response.body);
  List<TransactionModel> transactions = [];
  if (response.statusCode == 200) {
    for (var transaction in responseData) {
      TransactionModel u1 = TransactionModel(
        amount: transaction['amount'],
        transactionDate: transaction['transactionDate'],
        dueDate: transaction['dueDate'],
        status: transaction['status'],
        vendorId: transaction['vendorId'],
        creditDebitStatus: transaction['creditDebitStatus'],
        transactionId: transaction['transactionId'],
        userId: transaction['userId'],
      );
      transactions.add(u1);
    }

    return transactions;
  } else {
    throw Exception('Failed to load AllTransaction data');
  }
}

Future<TransactionModel> fetchOneTransaction(String id) async {
  final response = await http
      .get(Uri.https(baseUrl, "/transaction/getTransaction", {"id": id}));
  var transaction = json.decode(response.body);
  List<TransactionModel> transactions = [];
  if (response.statusCode == 200) {
    TransactionModel u1 = TransactionModel(
      amount: transaction[0]['amount'],
      transactionDate: transaction[0]['transactionDate'],
      dueDate: transaction[0]['dueDate'],
      status: transaction[0]['status'],
      vendorId: transaction[0]['vendorId'],
      creditDebitStatus: transaction[0]['creditDebitStatus'],
      transactionId: transaction[0]['transactionId'],
      userId: transaction[0]['userId'],
    );

    return u1;
  } else {
    throw Exception('Failed to load AllTransaction data');
  }
}

Future<List<TransactionModel>> fetchParticularVendorTransaction(
    String userPhone, String vendorPhone) async {
  final response = await http.get(Uri.https(
      baseUrl,
      "/user/getParticularVendorTransactions",
      {"userPhone": userPhone, "vendorPhone": vendorPhone}));
  var responseData = json.decode(response.body);
  List<TransactionModel> transactions = [];
  if (response.statusCode == 200) {
    for (var transaction in responseData) {
      TransactionModel u1 = TransactionModel(
        amount: transaction['amount'],
        transactionDate: transaction['transactionDate'],
        dueDate: transaction['dueDate'],
        status: transaction['status'],
        vendorId: transaction['vendorId'],
        creditDebitStatus: transaction['creditDebitStatus'],
        transactionId: transaction['transactionId'],
        userId: transaction['userId'],
      );
      transactions.add(u1);
    }

    return transactions;
  } else {
    throw Exception('Failed to load VendorTransaction data');
  }
}

Future<List<int>> fetchParticularVendorCreditDebit(
    String userPhone, String vendorPhone) async {
  final response = await http.get(Uri.https(
      baseUrl,
      "/transaction/getUserCreditDebitDemo",
      {"userPhone": userPhone, "vendorPhone": vendorPhone}));
  var responseData = json.decode(response.body);
  List<int> ans = [];
  if (response.statusCode == 200) {
    for (var amount in responseData) {
      ans.add(amount);
    }
    return ans;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<UserSpringBootModel> createUser(String username, String phoneNumber,
    String email, String password, String pin, String image) async {
  String url = "https://$baseUrl/user/saveUser";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'userName': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'totalCredit': 0,
      'totalDebit': 0,
      'creditScore': 100,
      'securityPIN': pin,
      'image': image,
    }),
  );

  if (response.statusCode == 200) {
    return UserSpringBootModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register new user.');
  }
}

Future<VendorSpringBootModel> createVendor(
    String vendorName,
    String shopName,
    String phoneNumber,
    String email,
    String password,
    String address,
    String image) async {
  String url = "https://$baseUrl/vendor/saveVendor";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'vendorName': vendorName,
      'shopName': shopName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'password': password,
      'image': image,
      'totalDebit': 0,
      'totalLoanAmount': 0,
    }),
  );

  if (response.statusCode == 200) {
    return VendorSpringBootModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register new vendor.');
  }
}

Future<BankSpringBootModel> createBank(String bankName, String phoneNumber,
    String bankAddress, String image, String bankBranch) async {
  String url = "https://$baseUrl/bank/saveBank";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'image': image,
      'bankName': bankName,
      'phoneNumber': phoneNumber,
      'bankBranch': bankBranch,
      'bankAddress': bankAddress,
    }),
  );

  if (response.statusCode == 200) {
    return BankSpringBootModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register new bank.');
  }
}

Future<UserSpringBootModel> fetchOneUsers(String phoneNumber) async {
  String url = "https://$baseUrl/user/getUserByPhone";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'phoneNumber': phoneNumber,
    }),
  );
  var user = json.decode(response.body);
  if (response.statusCode == 200) {
    UserSpringBootModel u1 = UserSpringBootModel(
      creditScore: user[0]["creditScore"],
      password: user[0]["password"],
      email: user[0]["email"],
      phoneNumber: user[0]["phoneNumber"],
      securityPIN: user[0]["securityPIN"],
      userName: user[0]["userName"],
      totalCredit: user[0]["totalCredit"],
      totalDebit: user[0]["totalDebit"],
      userId: user[0]["userId"],
      image: user[0]["image"],
    );
    return u1;
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<UserSpringBootModel> fetchUser(String phoneNumber) async {
  final response = await http
      .get(Uri.https(baseUrl, "/user/getUser", {"phoneNumber": phoneNumber}));
  var user = json.decode(response.body);
  if (response.statusCode == 200) {
    UserSpringBootModel u1 = UserSpringBootModel(
      creditScore: user[0]["creditScore"],
      password: user[0]["password"],
      email: user[0]["email"],
      phoneNumber: user[0]["phoneNumber"],
      securityPIN: user[0]["securityPIN"],
      userName: user[0]["userName"],
      totalCredit: user[0]["totalCredit"],
      totalDebit: user[0]["totalDebit"],
      userId: user[0]["userId"],
      image: user[0]["image"],
    );
    return u1;
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<VendorSpringBootModel> fetchParticularVendor(String phoneNumber) async {
  final response = await http.get(Uri.https(
      baseUrl, "/vendor/getVendorByPhone", {"phoneNumber": phoneNumber}));
  var vendor = json.decode(response.body);
  if (response.statusCode == 200) {
    VendorSpringBootModel u1 = VendorSpringBootModel(
      phoneNumber: vendor[0]["phoneNumber"],
      totalDebit: vendor[0]["totalDebit"],
      vendorName: vendor[0]["vendorName"],
      vendorId: vendor[0]["vendorId"],
      totalLoanAmount: vendor[0]["totalLoanAmount"],
      shopName: vendor[0]["shopName"],
      address: vendor[0]["address"],
      email: vendor[0]["email"],
      password: vendor[0]["password"],
      image: vendor[0]["image"],
    );
    return u1;
  } else {
    throw Exception('Failed to load vendor data');
  }
}

Future<BankSpringBootModel> fetchParticularBank(String phoneNumber) async {
  final response = await http.get(
      Uri.https(baseUrl, "/bank/getBankByPhone", {"phoneNumber": phoneNumber}));
  var bank = json.decode(response.body);
  if (response.statusCode == 200) {
    BankSpringBootModel u1 = BankSpringBootModel(
      bankId: bank[0]["bankId"],
      image: bank[0]["image"],
      phoneNumber: bank[0]["phoneNumber"],
      bankName: bank[0]["bankName"],
      bankBranch: bank[0]["bankBranch"],
      bankAddress: bank[0]["bankAddress"],
    );
    return u1;
  } else {
    throw Exception('Failed to load bank data');
  }
}

Future<List<TimeRequestModel>> getTimeRequest(
    String vendor, String user) async {
  final response = await http.get(Uri.https(
      baseUrl,
      "/timeRequest/getAllTimeRequestByUser",
      {"vendorPhone": vendor, "userPhone": user}));
  var responseData = json.decode(response.body);
  List<TimeRequestModel> transactions = [];
  if (response.statusCode == 200) {
    for (var transaction in responseData) {
      TimeRequestModel u1 = TimeRequestModel(
        message: transaction['message'],
        newDate: transaction['newDate'],
        status: transaction['status'],
        vendorId: transaction['vendorId'],
        timeRequestId: transaction['timeRequestId'],
        transactionId: transaction['transactionId'],
        userId: transaction['userId'],
      );
      transactions.add(u1);
    }

    return transactions;
  } else {
    throw Exception('Failed to load AllTransaction data');
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/bank_auth_provider.dart';
import 'provider/user_auth_provider.dart';
import 'provider/vendor_auth_provider.dart';
import 'who_are_you.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthProvider>(
            create: (_) => UserAuthProvider()),
        ChangeNotifierProvider<VendorAuthProvider>(
            create: (_) => VendorAuthProvider()),
        ChangeNotifierProvider<BankAuthProvider>(
            create: (_) => BankAuthProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WhoAreYou(),
        title: "Take it",
      ),
    );
  }
}

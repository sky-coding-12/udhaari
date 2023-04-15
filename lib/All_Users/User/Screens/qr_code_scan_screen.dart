import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../Constant/const_variable.dart';
import 'take_borrow_money.dart';

class QR_Scan_Screen extends StatefulWidget {
  final String userPhone;
  const QR_Scan_Screen({Key? key, required this.userPhone}) : super(key: key);

  @override
  State<QR_Scan_Screen> createState() => _QR_Scan_ScreenState();
}

class _QR_Scan_ScreenState extends State<QR_Scan_Screen> {
  String _scanBarcode = 'Unknown';
  late String userPhone;

  @override
  void initState() {
    super.initState();
    userPhone = widget.userPhone;
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode != "-1") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TakeMoney(
                  vendorPhone: _scanBarcode,
                  userPhone: userPhone,
                )));
      }
    });
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
            title,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/qr_code.png"),
                      ),
                    ),
                  ),
                  const Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () => scanQR(),
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(63, 72, 204, 1))),
                      child: const Text(
                        "START QR SCAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Center(
                    child: Text(
                      "©2023 take_it 🗿 | all rights reserved",
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 3.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

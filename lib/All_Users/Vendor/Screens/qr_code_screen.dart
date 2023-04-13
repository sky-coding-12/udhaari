import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:take_it/Models/vendor_spring_boot_model.dart';
import 'package:take_it/services/api_calling.dart';

import '../../../Constant/const_variable.dart';

class QR_Code_Screen extends StatefulWidget {
  final String phone;
  const QR_Code_Screen({Key? key, required this.phone}) : super(key: key);

  @override
  State<QR_Code_Screen> createState() => _QR_Code_ScreenState();
}

class _QR_Code_ScreenState extends State<QR_Code_Screen> {
  late String phone;

  late Future<VendorSpringBootModel> vendor;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      vendor = fetchParticularVendor(phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "QR Code",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.5,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const Spacer(),
          FutureBuilder(
            future: vendor,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: QrImage(
                    foregroundColor: mainColor,
                    data: "${snapshot.data!.phoneNumber}",
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator(
                color: mainColor,
              );
            },
          ),
          const Spacer(),
          const Center(
            child: Text(
              "©2023 take_it 🗿 | all rights reserved",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class ParticularVendor extends StatefulWidget {
  final int phone;
  const ParticularVendor({Key? key, required this.phone}) : super(key: key);

  @override
  State<ParticularVendor> createState() => _ParticularVendorState();
}

class _ParticularVendorState extends State<ParticularVendor> {
  late Future<VendorSpringBootModel> vendor;
  late int phone;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    vendor = fetchParticularVendor(phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: FutureBuilder(
                future: vendor,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${snapshot.data!.image}",
                          ),
                          radius: 50.0,
                        )
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

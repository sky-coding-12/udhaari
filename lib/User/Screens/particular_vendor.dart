import 'package:flutter/material.dart';

class ParticularVendor extends StatefulWidget {
  final int index;
  final String name;
  const ParticularVendor({required this.index, Key? key, required this.name})
      : super(key: key);

  @override
  State<ParticularVendor> createState() => _ParticularVendorState();
}

class _ParticularVendorState extends State<ParticularVendor> {
  late int idx;
  @override
  void initState() {
    super.initState();
    idx = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$idx"),
      ),
    );
  }
}

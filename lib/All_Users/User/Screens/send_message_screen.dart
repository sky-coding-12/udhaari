import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/message_model.dart';

class SendMessageScreen extends StatefulWidget {
  final String vendorPhone;
  final String userPhone;
  final String dueDate;
  final int transactionId;
  const SendMessageScreen(
      {Key? key,
      required this.vendorPhone,
      required this.userPhone,
      required this.transactionId,
      required this.dueDate})
      : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  late String vendorPhone;
  late String userPhone;
  late int transactionId;

  late TextEditingController _dateController;

  bool validDate = false;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    transactionId = widget.transactionId;
    userPhone = widget.userPhone;
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Send Message",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/send_message.png"),
                    ),
                  ),
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
                      icon: const Icon(
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
                    hintText: "Select New Date",
                    prefixIcon: Icon(
                      CupertinoIcons.calendar_badge_plus,
                      color: mainColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(63, 72, 204, 1))),
                    child: const Text(
                      "SEND MESSAGE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () async {
                      if (validDate) {
                        String message =
                            "I am not able to pay your money on time so please give permission for you to pay beyond '${_dateController.text.trim()}'";
                        List<String> vendorNumber = [vendorPhone.toString()];
                        await sendSMS(
                                message: message, recipients: vendorNumber)
                            .catchError((onError) {
                          print("akash");
                        }).whenComplete(
                          () => sendMessage(
                            vendorPhone.toString(),
                            userPhone,
                            "Pending",
                            _dateController.text.trim(),
                            message,
                          ).then((value) => {
                                AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: true,
                                  animType: AnimType.scale,
                                  btnCancelColor: mainColor,
                                  dialogType: DialogType.success,
                                  btnOkOnPress: () {
                                    Navigator.pop(context);
                                  },
                                  btnOkColor: mainColor,
                                  title: 'Success',
                                  desc: 'Message Send Successfully 😊',
                                ).show(),
                              }),
                        );
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Message> sendMessage(String vendorId, String userId, String status,
      String date, String msg) async {
    String url = "https://$baseUrl/timeRequest/saveTimeRequest";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'transactionId': transactionId,
        'vendorId': vendorId,
        'status': status,
        'message': msg,
        'newDate': date,
        'dueDate': widget.dueDate,
      }),
    );

    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message.');
    }
  }
}

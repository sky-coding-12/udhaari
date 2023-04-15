import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../services/api_calling.dart';
import '../../../utils/utils.dart';
import 'vendor_dashboard_user.dart';

class UpdateVendorProfile extends StatefulWidget {
  final String phone;
  const UpdateVendorProfile({Key? key, required this.phone}) : super(key: key);

  @override
  State<UpdateVendorProfile> createState() => _UpdateVendorProfileState();
}

class _UpdateVendorProfileState extends State<UpdateVendorProfile> {
  File? image;

  late Future<VendorSpringBootModel> vendor;
  late String phone;
  late String imageUrl;
  late String password;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool validVendorName = true;
  bool validShopName = true;
  bool validEmail = true;
  bool validAddress = true;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      vendor = fetchParticularVendor(phone);
    });
    vendor.then((value) => {
          _vendorNameController.text = value.vendorName!,
          _shopNameController.text = value.shopName!,
          _emailController.text = value.email!,
          _addressController.text = value.address!,
          imageUrl = value.image!,
        });
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
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
            "Update Profile",
            style: TextStyle(
              color: mainColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ChangeNotifierProvider<VisibilityModel>(
          create: (context) => VisibilityModel(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                future: vendor,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => selectImage(),
                            child: image == null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(imageUrl),
                                    radius: 100,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                    radius: 100,
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validVendorName = true,
                                    }
                                  else
                                    {
                                      validVendorName = false,
                                    }
                                },
                                controller: _vendorNameController,
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
                                      color: myModel.isUsernameValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Vendor Name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeShopNameValidation(val),
                                  if (myModel.isShopNameValid)
                                    {
                                      validShopName = true,
                                    }
                                  else
                                    {
                                      validShopName = false,
                                    }
                                },
                                controller: _shopNameController,
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
                                      color: myModel.isShopNameValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Shop Name",
                                  prefixIcon: Icon(
                                    Icons.store,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeEmailValidation(val),
                                  if (myModel.isEmailValid)
                                    {
                                      validEmail = true,
                                    }
                                  else
                                    {
                                      validEmail = false,
                                    }
                                },
                                controller: _emailController,
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
                                      color: myModel.isEmailValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Email Address",
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeAddressValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validAddress = true,
                                    }
                                  else
                                    {
                                      validAddress = false,
                                    }
                                },
                                controller: _addressController,
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
                                      color: myModel.isAddressValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Shop Address",
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromRGBO(63, 72, 204, 1))),
                              child: const Text(
                                "UPDATE PROFILE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onPressed: () async {
                                if (validVendorName &&
                                    validAddress &&
                                    validShopName &&
                                    validEmail) {
                                  if (image == null) {
                                    updateVendorProfile(
                                      phone,
                                      snapshot.data!.password,
                                      _vendorNameController.text.trim(),
                                      snapshot.data!.totalDebit,
                                      _addressController.text.trim(),
                                      snapshot.data!.totalLoanAmount,
                                      snapshot.data!.vendorId,
                                      _shopNameController.text.trim(),
                                      _emailController.text.trim(),
                                      snapshot.data!.image,
                                    )
                                        .then((value) => {
                                              _firebaseFireStore
                                                  .collection("vendors")
                                                  .doc(
                                                      "+91${value.phoneNumber}")
                                                  .update({
                                                "name": value.vendorName,
                                                "email": value.email,
                                                "shopName": value.shopName,
                                              })
                                            })
                                        .then((value) => {
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
                                                          const VendorDashBoard(),
                                                    ),
                                                  );
                                                },
                                                btnOkColor: mainColor,
                                                title: 'Success',
                                                desc:
                                                    'Profile Updated Successfully 😊',
                                              ).show(),
                                            });
                                  } else {
                                    storeUserFileToStorage(
                                            "profilePic/vendors/${snapshot.data!.vendorName}",
                                            image)
                                        .then((value) => {
                                              updateVendorProfile(
                                                phone,
                                                snapshot.data!.password,
                                                _vendorNameController.text
                                                    .trim(),
                                                snapshot.data!.totalDebit,
                                                _addressController.text.trim(),
                                                snapshot.data!.totalLoanAmount,
                                                snapshot.data!.vendorId,
                                                _shopNameController.text.trim(),
                                                _emailController.text.trim(),
                                                value,
                                              )
                                                  .then((value) => {
                                                        _firebaseFireStore
                                                            .collection(
                                                                "vendors")
                                                            .doc(
                                                                "+91${value.phoneNumber}")
                                                            .update({
                                                          "name":
                                                              value.vendorName,
                                                          "email": value.email,
                                                          "shopName":
                                                              value.shopName,
                                                          "profilePic":
                                                              value.image,
                                                        })
                                                      })
                                                  .then((value) => {
                                                        AwesomeDialog(
                                                          context: context,
                                                          headerAnimationLoop:
                                                              true,
                                                          animType:
                                                              AnimType.scale,
                                                          btnCancelColor:
                                                              mainColor,
                                                          dialogType: DialogType
                                                              .success,
                                                          btnOkOnPress: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const VendorDashBoard(),
                                                              ),
                                                            );
                                                          },
                                                          btnOkColor: mainColor,
                                                          title: 'Success',
                                                          desc:
                                                              'Profile Updated Successfully 😊',
                                                        ).show(),
                                                      }),
                                            });
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
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2 - 100,
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<VendorSpringBootModel> updateVendorProfile(
      String phone,
      String? password,
      String vendorName,
      int? totalDebit,
      String address,
      int? totalLoanAmount,
      int? vendorId,
      String shopName,
      String email,
      String? image) async {
    final response = await http.put(
      Uri.https(baseUrl, "/vendor/updateVendor"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'vendorName': vendorName,
        'phoneNumber': phone,
        'email': email,
        'password': password,
        'totalLoanAmount': totalLoanAmount,
        'totalDebit': totalDebit,
        'shopName': shopName,
        'address': address,
        'image': image,
        'vendorId': vendorId
      }),
    );

    if (response.statusCode == 200) {
      return VendorSpringBootModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update vendor password.');
    }
  }

  Future<String> storeUserFileToStorage(String ref, File? file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

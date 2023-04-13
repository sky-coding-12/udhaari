import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/bank_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../provider/bank_auth_provider.dart';
import '../../../utils/utils.dart';
import '../Screens/bank_dashboard.dart';

class BankInformationScreen extends StatefulWidget {
  const BankInformationScreen({super.key});

  @override
  State<BankInformationScreen> createState() => _BankInformationScreenState();
}

class _BankInformationScreenState extends State<BankInformationScreen> {
  File? image;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final branchNoController = TextEditingController();

  bool validName = false;
  bool validAddress = false;
  bool validBranch = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    branchNoController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<BankAuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              )
            : ChangeNotifierProvider<VisibilityModel>(
                create: (context) => VisibilityModel(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const Text(
                            "Enter Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () => selectImage(),
                            child: image == null
                                ? CircleAvatar(
                                    backgroundColor: mainColor,
                                    radius: 70,
                                    child: const Icon(
                                      Icons.image,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                    radius: 70,
                                  ),
                          ),
                          const SizedBox(height: 20),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validName = true,
                                    }
                                  else
                                    {
                                      validName = false,
                                    }
                                },
                                controller: nameController,
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
                                  hintText: "Bank Name",
                                  prefixIcon: Icon(
                                    Icons.account_balance,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validAddress = true,
                                    }
                                  else
                                    {
                                      validAddress = false,
                                    }
                                },
                                controller: addressController,
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
                                  hintText: "Bank Address",
                                  prefixIcon: Icon(
                                    Icons.place,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validBranch = true,
                                    }
                                  else
                                    {
                                      validBranch = false,
                                    }
                                },
                                controller: branchNoController,
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
                                  hintText: "Bank Branch",
                                  prefixIcon: Icon(
                                    Icons.my_location,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(63, 72, 204, 1))),
                                child: const Text(
                                  "CONTINUE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onPressed: () {
                                  if (validName &&
                                      validAddress &&
                                      validBranch) {
                                    storeData();
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
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<BankAuthProvider>(context, listen: false);
    BankModel bankModel = BankModel(
      name: nameController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
      address: addressController.text.trim(),
      branchName: branchNoController.text.trim(),
    );
    if (image != null) {
      ap.saveBankDataToFirebase(
        context: context,
        bankModel: bankModel,
        profilePic: image!,
        bankName: nameController.text.trim(),
        bankAddress: addressController.text.trim(),
        bankBranch: branchNoController.text.trim(),
        onSuccess: () {
          ap.saveBankDataToSP().then(
                (value) => ap.setBankSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BankDashBoard(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}

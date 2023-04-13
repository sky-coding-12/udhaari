import 'package:flutter/material.dart';
import 'package:take_it/services/helper.dart';

class VisibilityModel with ChangeNotifier {
  bool isPassVisible = false;
  bool isPinVisible = false;
  bool isEmailValid = false;
  bool isPassValid = false;
  bool isUsernameValid = false;
  bool isPhoneValid = false;
  bool isConfirmValid = false;
  bool isOTPValid = false;
  bool isPINValid = false;
  bool isConfirmPINValid = false;
  bool isShopNameValid = false;
  bool isAddressValid = false;
  bool isMoneyValid = false;

  void changePassVisibility() {
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

  void changePinVisibility() {
    isPinVisible = !isPinVisible;
    notifyListeners();
  }

  void changeEmailValidation(val) {
    if (validateEmail(val)) {
      isEmailValid = true;
    } else {
      isEmailValid = false;
    }
    notifyListeners();
  }

  void changePassValidation(val) {
    if (validatePassword(val)) {
      isPassValid = true;
    } else {
      isPassValid = false;
    }
    notifyListeners();
  }

  void changeUsernameValidation(val) {
    if (validateName(val)) {
      isUsernameValid = true;
    } else {
      isUsernameValid = false;
    }
    notifyListeners();
  }

  void changeAddressValidation(val) {
    if (validateName(val)) {
      isAddressValid = true;
    } else {
      isAddressValid = false;
    }
    notifyListeners();
  }

  void changeShopNameValidation(val) {
    if (validateShopName(val)) {
      isShopNameValid = true;
    } else {
      isShopNameValid = false;
    }
    notifyListeners();
  }

  void changePhoneValidation(val) {
    if (validateMobile(val)) {
      isPhoneValid = true;
    } else {
      isPhoneValid = false;
    }
    notifyListeners();
  }

  void changeConfirmPassValidation(String password, val) {
    if (validateConfirmPassword(password, val)) {
      isConfirmValid = true;
    } else {
      isConfirmValid = false;
    }
    notifyListeners();
  }

  void changeOTPValidation(val) {
    if (validateOTP(val)) {
      isOTPValid = true;
    } else {
      isOTPValid = false;
    }
    notifyListeners();
  }

  void changePINValidation(val) {
    if (validateOTP(val)) {
      isPINValid = true;
    } else {
      isPINValid = false;
    }
    notifyListeners();
  }

  void changeConfirmPINValidation(String pin, val) {
    if (validateConfirmPassword(pin, val)) {
      isConfirmPINValid = true;
    } else {
      isConfirmPINValid = false;
    }
    notifyListeners();
  }

  void changeMoneyValidation(val) {
    if (validateMoney(val)) {
      isMoneyValid = true;
    } else {
      isMoneyValid = false;
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

Color mainColor = const Color.fromRGBO(63, 72, 204, 1);
Color backColor = Colors.grey.shade200;
String title = "Take it";

String baseUrl = "callous-canvas-production.up.railway.app";

class FAQ_Model {
  final String question;
  final String answer;

  FAQ_Model({
    required this.question,
    required this.answer,
  });
}

List<FAQ_Model> faqs = [
  FAQ_Model(
    question:
        "How often do the apps that gather my financial account information access my bank accounts? ",
    answer:
        "If they have your bank username and password,then they can access your data whenever they want. Some apps access your account multiple times a day, even if you aren’t using the app anymore.",
  ),
  FAQ_Model(
      question: "How long does a demo account last?",
      answer:
          "Demo accounts last for 90 days after sign up. Afterward, you will not be able to log in using the demo account credentials."),
  FAQ_Model(
      question: "Can I renew my demo account?",
      answer:
          "Demo accounts last for 90 days after sign up. Afterward, you will not be able to log in using the demo account credentials. Demo renewals are not available at this time. If you have further questions, please contact us."),
  FAQ_Model(
      question: "Can I open multiple demos?",
      answer:
          "You can only open one demo account of each type (i.e. FOREX.com platforms or MetaTrader) per email address."),
  FAQ_Model(
      question:
          "I forgot my demo username or password. How do I retrieve them?",
      answer:
          "If you forgot your username, please contact us for assistance. If you forgot your password, please visit our password reset page to reset your password."),
  FAQ_Model(
      question:
          "What security features are in place to protect my account information?",
      answer:
          "We use sophisticated encryption technology to ensure the highest level of account security."),
  FAQ_Model(
      question: "What are the new features for the new app?",
      answer:
          "With this new and improved version, we have made several enhancements, both minor and significant, including the ability to place a quick trade with just a single swipe. Learn more about the features of our new mobile app and how to implement them in your trading."),
  FAQ_Model(
      question: "Is this available for iPad/tablet?",
      answer:
          "Currently, only a phone version of the FOREX.com mobile app is available. However, it can be installed on your tablet as well."),
];

List<FAQ_Model> privacy = [
  FAQ_Model(
      question: "Privacy Policy of Take it",
      answer: "Take it operates the takeit.com website,\n\n"
          "which provides the SERVICE.This page is used to inform website visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service, the takeit.com website.\n\n"
          "If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\n"
          "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at takeit.com, unless otherwise defined in this Privacy Policy."),
  FAQ_Model(
      question: "Information Collection and Use",
      answer:
          "For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, phone number, and postal address. The information that we collect will be used to contact or identify you."),
  FAQ_Model(
      question: "Log Data",
      answer:
          "We want to inform you that whenever you visit our Service, we collect information that your browser sends to us that is called Log Data. This Log Data may include information such as your computer's Internet Protocol (“IP”) address, browser version, pages of our Service that you visit, the time and date of your visit, the time spent on those pages, and other statistics."),
  FAQ_Model(
      question: "Security",
      answer:
          "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."),
  FAQ_Model(
      question: "Changes to This Privacy Policy",
      answer:
          "We may update our Privacy Policy from time to time. Thus, we advise you to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page."),
  FAQ_Model(
      question: "Contact Us",
      answer:
          "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us."),
];

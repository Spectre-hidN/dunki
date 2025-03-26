import 'package:animate_gradient/animate_gradient.dart';
import 'package:dunki/components/loginscreenitems.dart';
import 'package:dunki/screens/mainscreen.dart';
import 'package:dunki/utils.dart';
import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  late Widget loginScreenItems;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late final AnimationController _animationController;

  void openHomeScreen(String uid) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => MainPage(userID: uid)));
  }

  void registerAndOpenHomePage() {
    debugPrint("Register Activity initiated");

    if (phoneNumberController.text.length != 10 ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      debugPrint("Incomplete Creds!");
      return;
    }

    String passwordHash = calcSHA256(passwordController.text);

    Map<String, String> registerData = {
      "uid": calcCRC32("${phoneNumberController.text}$passwordHash"),
      "phoneNumber": phoneNumberController.text,
      "name": nameController.text,
      "password_hash": passwordHash
    };

    debugPrint(
        "----- Register User Payload -----\nuid: ${registerData["uid"]}\nphoneNumber: ${registerData["phoneNumber"]}\nname: ${registerData["name"]}\npass_hash: ${registerData["password_hash"]}\n");

    //TODO: Send the payload to the database and open homepage with the newly generated UID (Unique Indentification Number).
    // UID Generation template: crc32(phoneNumber+password_hash)

    openHomeScreen(registerData["uid"].toString());
  }

  void loginAndOpenHomePage() {
    debugPrint("Login Activity initiated!");

    if (phoneNumberController.text.length != 10 ||
        passwordController.text.isEmpty) {
      debugPrint("Incomplete Creds!");
      return;
    }

    String uid = calcCRC32(
        "${phoneNumberController.text}${calcSHA256(passwordController.text)}");

    debugPrint("Possible UID: $uid");

    //TODO: Check if the generated uid is present in the database and open the main page.

    openHomeScreen(uid);
  }

  void switchLayout(String layoutName) {
    debugPrint("Switched to layout $layoutName");
    setState(() {
      loginScreenItems = getLoginScreenItems(
          screenName: layoutName,
          phoneNumberController: phoneNumberController,
          addressController: addressController,
          passwordController: passwordController,
          nameController: nameController,
          switchLayoutCallback: switchLayout,
          onLoginClicked: loginAndOpenHomePage,
          onRegisterClicked: registerAndOpenHomePage);
    });
  }

  void checkConnectionWrapper() async {
    bool connStatus = await preProcess();
    if (!connStatus) {
      setState(() {
        loginScreenItems = const Placeholder(color: Colors.transparent);
      });
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    loginScreenItems = getLoginScreenItems(
        screenName: "login",
        phoneNumberController: phoneNumberController,
        addressController: addressController,
        passwordController: passwordController,
        nameController: nameController,
        switchLayoutCallback: switchLayout,
        onLoginClicked: loginAndOpenHomePage,
        onRegisterClicked: registerAndOpenHomePage);

    checkConnectionWrapper();

    super.initState();
  }

  @override
  void dispose() {
    try {
      _animationController.dispose();
    } catch (e) {
      debugPrint(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: AnimateGradient(
            reverse: true,
            controller: _animationController,
            primaryBegin: Alignment.bottomRight,
            primaryEnd: Alignment.center,
            secondaryBegin: Alignment.center,
            secondaryEnd: Alignment.topLeft,
            duration: const Duration(seconds: 10),
            primaryColors: const [
              Color(0xFFfae588),
              Color(0xFFFAF3E1),
            ],
            secondaryColors: [
              const Color(0xFFF5E7C6),
              Theme.of(context).colorScheme.primary
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: loginScreenItems,
            )),
      ),
    );
  }
}

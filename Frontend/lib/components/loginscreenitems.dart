import 'package:dunki/components/glowedupbutton.dart';
import 'package:dunki/components/roundedtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave_divider/wave_divider.dart';

Widget getLoginScreenItems(
    {required String screenName,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
    required TextEditingController addressController,
    required Function(String) switchLayoutCallback,
    onLoginClicked,
    onRegisterClicked}) {
  debugPrint("Painting Layout for $screenName");
  if (screenName == "login") {
    return Center(
      child: Container(
        height: 450,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withAlpha(65),
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("Dunki",
                    style: TextStyle(
                        color: const Color(0xFFFF6D1F),
                        fontSize: 40.0,
                        fontFamily: "Fredoka",
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: const Offset(-1.5, -1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // bottomRight
                              offset: const Offset(1.5, -1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // topRight
                              offset: const Offset(1.5, 1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // topLeft
                              offset: const Offset(-1.5, 1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                        ],
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: WaveDivider(
                        color: Colors.white, thickness: 0.4, waveHeight: 7),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 10.0),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color.fromARGB(255, 235, 234, 234),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: phoneNumberController,
                  obscureText: false,
                  hintText: "Mobile Number",
                  icon: const Icon(Icons.phone_rounded,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[6-9][0-9]{0,9}')),
                  ],
                ),
              ),
              const SizedBox(height: 11.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: passwordController,
                  obscureText: true,
                  hintText: "Password",
                  icon: const Icon(Icons.password_rounded,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                ),
              ),
              const SizedBox(height: 35.0),
              GlowedUpButton(
                buttonText: const Text("Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Fredoka",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                height: 50.0,
                width: 80.0,
                onClickedCallback: onLoginClicked,
                bgColor: const Color(0xFFFF6D1F),
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: WaveDivider(
                        color: Colors.white, thickness: 0.4, waveHeight: 7),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(
                height: 11.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => switchLayoutCallback("register"),
                    child: const Text("Let's create one.",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6D1F))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  } else if (screenName == "register") {
    return Center(
      child: Container(
        height: 555,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withAlpha(65),
            border: Border.all(color: Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("Dunki",
                    style: TextStyle(
                        color: const Color(0xFFFF6D1F),
                        fontSize: 40.0,
                        fontFamily: "Fredoka",
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: const Offset(-1.5, -1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // bottomRight
                              offset: const Offset(1.5, -1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // topRight
                              offset: const Offset(1.5, 1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                          Shadow(
                              // topLeft
                              offset: const Offset(-1.5, 1.5),
                              color: Colors.white.withValues(alpha: 0.3)),
                        ],
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: WaveDivider(
                        color: Colors.white, thickness: 0.4, waveHeight: 7),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 10.0),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 235, 234, 234),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: phoneNumberController,
                  obscureText: false,
                  hintText: "Mobile Number",
                  icon: const Icon(Icons.phone_rounded,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[6-9][0-9]{0,9}')),
                  ],
                ),
              ),
              const SizedBox(height: 11.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: nameController,
                  obscureText: false,
                  hintText: "Name",
                  icon: const Icon(Icons.account_circle_rounded,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                ),
              ),
              const SizedBox(height: 11.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: addressController,
                  obscureText: false,
                  hintText: "Address",
                  icon: const Icon(CupertinoIcons.home,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                ),
              ),
              const SizedBox(height: 11.0),
              SizedBox(
                height: 45.0,
                child: RoundedTextField(
                  fillColor: const Color(0xFFFAF3E1),
                  controller: passwordController,
                  obscureText: true,
                  hintText: "Password",
                  icon: const Icon(Icons.password_rounded,
                      size: 35.0, color: Color(0xFFFF6D1F)),
                ),
              ),
              const SizedBox(height: 35.0),
              GlowedUpButton(
                buttonText: const Text("Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Fredoka",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                height: 50.0,
                width: 80.0,
                onClickedCallback: onRegisterClicked,
                bgColor: const Color(0xFFFF6D1F),
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: WaveDivider(
                        color: Colors.white, thickness: 0.4, waveHeight: 7),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(
                height: 11.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => switchLayoutCallback("login"),
                    child: const Text("Login now.",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6D1F))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  } else {
    return const Expanded(child: Placeholder(color: Colors.orange));
  }
}

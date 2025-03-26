import 'package:dunki/components/glowedupbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PrintBillScreen extends StatelessWidget {
  const PrintBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.invoicesimple.com/wp-content/webp-express/webp-images/uploads/2024/04/letterhead-template-en.jpg.webp"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20.0),
            const GlowedUpButton(
              bgColor: Color(0xFFFF6D1F),
              buttonText: Text("Print Bill",
                  style: TextStyle(
                      fontFamily: "Satoshi",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0)),
              height: 45.0,
              width: 100.0,
            )
          ],
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          title: Center(
            child: GradientText(
              "Dunki",
              gradientDirection: GradientDirection.ttb,
              gradientType: GradientType.linear,
              style: const TextStyle(
                  fontSize: 56,
                  fontFamily: "Fredoka",
                  fontWeight: FontWeight.w800),
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary,
                const Color(0xFFEB1212)
              ],
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              CupertinoIcons.back,
              size: 45.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: const [SizedBox(width: 50)],
        ));
  }
}

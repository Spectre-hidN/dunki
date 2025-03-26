import 'package:dunki/screens/billpage.dart';
import 'package:dunki/screens/loginregisterscreen.dart';
import 'package:dunki/screens/mainscreen.dart';
import 'package:dunki/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dunki',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SafeArea(child: LoginRegisterScreen()),
    );
  }
}

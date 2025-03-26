import 'package:dunki/pages/homepage.dart';
import 'package:dunki/pages/profilepage.dart';
import 'package:dunki/pages/statspage.dart';
import 'package:dunki/pages/storepage.dart';
import 'package:dunki/randomizer.dart';
import 'package:dunki/screens/billpage.dart';
import 'package:dunki/theme/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainPage extends StatefulWidget {
  final String userID;
  const MainPage({super.key, this.userID = "12345678"});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  Widget getMainBody(int selectedIndex) {
    //TODO: Remove test data and pass the fetched one.

    int tOrderDataLength = 3 + Random().nextInt(7 - 3 + 1);
    int tPPDataLength = 3 + Random().nextInt(7 - 3 + 1);

    Map homePageData = {
      "today_order": {
        "names": indianNames.selectRandom(tOrderDataLength),
        "address": addressNames.selectRandom(tOrderDataLength)
      },
      "pending_payments": {
        "names": indianNames.selectRandom(tPPDataLength),
        "address": addressNames.selectRandom(tPPDataLength)
      }
    };

    Map categoryData = {
      "items": ["Potato", "Onion", "Brinjal", "Pumpkin", "Dhaniya"],
      "itemsCount": [2, 5, 25, 10, 1]
    };

    Random random = Random();

    Map statsPageData = {
      "net_balance": 10000 + random.nextInt(40000 - 10000 + 1),
      "earned_this_month": 45000,
      "loan_cleared_this_month": 15000,
      "loan_pending": 103000,
      "profit_earned": 20000 + random.nextInt(40000 - 10000 + 1),
      "sales_data": {
        "months": ["Jan", "Feb", "Mar", "Apr", "May"],
        "sales": [].generateRandomIntegers(20, 50, 5)
      },
      "category_data": {
        "category": ["Brinjal", "Potatoes", "Cauliflower", "Onion", "Tomato"],
        "values": [22, 28, 20, 18, 12]
      },
      "transaction_data": {
        "names": indianNames.selectRandom(5),
        "values": [1234, 567, 1890, 1500, 987]
      }
    };

    if (selectedIndex == 0) {
      // ------ HOME PAGE -----
      return HomePage(setState: setState, data: homePageData);
    } else if (selectedIndex == 1) {
      // ------- STORE PAGE -----
      return StorePage(setState: setState, categoryData: categoryData);
    } else if (selectedIndex == 2) {
      // ====== STATS PAGE -----
      return StatsPage(data: statsPageData);
    } else if (selectedIndex == 3) {
      // ------- Profile Page -----
      return const ProfilePage();
    } else {
      return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getMainBody(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 17.0),
          child: GNav(
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedIndex: selectedIndex,
              gap: 10.0,
              color: Theme.of(context).colorScheme.tertiary,
              activeColor: Theme.of(context).colorScheme.tertiary,
              padding: const EdgeInsets.all(8.0),
              tabBackgroundColor: Theme.of(context)
                  .scaffoldBackgroundColor
                  .withValues(alpha: 0.2),
              onTabChange: (value) {
                setState(() {
                  selectedIndex = value;
                });
                debugPrint(selectedIndex.toString());
              },
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: "H o m e",
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary),
                GButton(
                    icon: CupertinoIcons.cart_fill,
                    text: "S t o r e",
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary),
                GButton(
                    icon: CupertinoIcons.chart_bar_fill,
                    text: "S t a t s",
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary),
                GButton(
                    icon: Icons.account_circle_rounded,
                    text: "P r o f i l e",
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.tertiary)
              ]),
        ),
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
          child: Icon(
            CupertinoIcons.bell_fill,
            size: 30.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: GestureDetector(
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              child: Icon(
                CupertinoIcons.sun_max_fill,
                size: 30.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BillScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.tertiary,
            size: 35.0,
          ),
        ),
      ),
    );
  }
}

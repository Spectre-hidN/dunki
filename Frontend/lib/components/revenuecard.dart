import 'package:flutter/material.dart';

class RevenueCard extends StatelessWidget {
  final double height;
  final double? widht;
  final Map data;
  const RevenueCard(
      {super.key, required this.data, this.height = 240, this.widht});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          gradient: const LinearGradient(colors: [
            Color(0xFF03071e),
            Color(0xFF03071e),
            Color(0xFF6a040f),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Text(
                "Net Balance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Satoshi"),
              ),
            ),
            Text(
              "₹${data["net_balance"]}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Satoshi"),
            ),
            const Spacer(),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Earned this month",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Loan cleared this month",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "₹${data["earned_this_month"]}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "₹${data["loan_cleared_this_month"]}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Loan Pending",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    "Profit Earned",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Satoshi"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "₹${data["loan_pending"]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Satoshi"),
                ),
                const Spacer(),
                Text(
                  "₹${data["profit_earned"]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Satoshi"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

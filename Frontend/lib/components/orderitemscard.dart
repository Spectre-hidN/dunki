import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TOrderCard extends StatelessWidget {
  final Color cardBg;
  final Color shadowBg;
  final double height;
  final String nameText;
  final String addressText;
  final double width;
  final String id;
  final Function(String id)? onClickedCallback;
  const TOrderCard(
      {super.key,
      required this.id,
      required this.nameText,
      required this.addressText,
      this.height = 60.0,
      this.cardBg = const Color(0xFFFAF3E1),
      this.shadowBg = const Color(0xFFF5E7C6),
      this.width = double.infinity,
      this.onClickedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          boxShadow: [
            BoxShadow(color: shadowBg, blurRadius: 10.0),
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nameText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontFamily: "Satoshi",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                Text(
                  addressText,
                  softWrap: true,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => onClickedCallback!(id),
            child: Container(
              width: 55.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14.0),
                      bottomRight: Radius.circular(14.0))),
              child: Center(
                  child: Icon(CupertinoIcons.arrow_right,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 20.0)),
            ),
          )
        ],
      ),
    );
  }
}

class PPaymentCard extends StatelessWidget {
  final Color cardBg;
  final Color shadowBg;
  final double height;
  final String nameText;
  final String addressText;
  final double width;
  final String id;
  final Function(String id)? onRemindClicked;
  final Function(String id)? onMarkAsDoneCliicked;
  const PPaymentCard(
      {super.key,
      required this.id,
      required this.nameText,
      required this.addressText,
      this.height = 60.0,
      this.cardBg = const Color(0xFFFAF3E1),
      this.shadowBg = const Color(0xFFF5E7C6),
      this.width = double.infinity,
      this.onRemindClicked,
      this.onMarkAsDoneCliicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          boxShadow: [
            BoxShadow(color: shadowBg, blurRadius: 10.0),
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nameText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontFamily: "Satoshi",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                Text(
                  addressText,
                  softWrap: true,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => onMarkAsDoneCliicked!(id),
            child: Container(
              width: 70.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                  child: SizedBox(
                width: 50.0,
                child: Text("Mark as Paid",
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0)),
              )),
            ),
          ),
          GestureDetector(
            onTap: () => onRemindClicked!(id),
            child: Container(
              width: 55.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14.0),
                      bottomRight: Radius.circular(14.0))),
              child: Center(
                  child: Text("Remind",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold))),
            ),
          )
        ],
      ),
    );
  }
}

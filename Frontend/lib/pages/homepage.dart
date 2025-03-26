import 'package:dunki/components/orderitemscard.dart';
import 'package:dunki/screens/orderscreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final dynamic setState;
  final Map data;

  const HomePage({super.key, required this.setState, required this.data});

  void tOrderClickedCallback(String id, String name, String address, context) {
    debugPrint(id);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderScreen(id: id, name: name, address: address),
    ));
  }

  void pPaymentOnRemindClickedCallback(id) {
    debugPrint(id);
    //TODO: Remind sent function notification
  }

  void pPaymentOnMarkAsPaidCallback(id) {
    debugPrint(id);
    //TODO: Mark the payment as done and remove the card from the tree.
  }

  List<Widget> generateTOrderItems(ctx) {
    //TODO: Fetch data from the db and generate the cards

    List<Widget> tOrderItems = [];

    for (var i = 0; i < data["today_order"]["names"].length; i++) {
      tOrderItems.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TOrderCard(
            id: i.toString(),
            nameText: data["today_order"]["names"][i],
            addressText: data["today_order"]["address"][i],
            cardBg: Theme.of(ctx).scaffoldBackgroundColor,
            onClickedCallback: (id) => tOrderClickedCallback(
                id,
                data["today_order"]["names"][i],
                data["today_order"]["address"][i],
                ctx),
            shadowBg: Theme.of(ctx).colorScheme.tertiary,
          ),
        ),
      );
    }

    return tOrderItems;
  }

  List<Widget> generatePendingPaymentCards(ctx) {
    List<Widget> pPaymentsItems = [];

    for (var i = 0; i < data["pending_payments"]["names"].length; i++) {
      pPaymentsItems.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PPaymentCard(
            id: i.toString(),
            nameText: data["pending_payments"]["names"][i],
            addressText: data["pending_payments"]["address"][i],
            cardBg: Theme.of(ctx).scaffoldBackgroundColor,
            shadowBg: Theme.of(ctx).colorScheme.tertiary,
            onMarkAsDoneCliicked: (id) => pPaymentOnMarkAsPaidCallback(id),
            onRemindClicked: (id) => pPaymentOnRemindClickedCallback(id),
          ),
        ),
      );
    }

    return pPaymentsItems;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> todayOrderCards = generateTOrderItems(context);
    List<Widget> pendingPaymentCards = generatePendingPaymentCards(context);

    List<Widget> tree = [
      const SizedBox(height: 20.0),
      Row(
        children: [
          Text(
            "Orders For Today",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 7.0),
          Icon(
            Icons.restore,
            color: Theme.of(context).colorScheme.inverseSurface,
            size: 25.0,
          )
        ],
      ),
      const SizedBox(height: 15),
    ];

    tree.addAll(todayOrderCards);

    tree.addAll([
      const SizedBox(height: 20),
      Row(
        children: [
          Text(
            "Pending Payments",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 7.0),
          Icon(
            Icons.restore,
            color: Theme.of(context).colorScheme.inverseSurface,
            size: 25.0,
          )
        ],
      ),
      const SizedBox(height: 15.0)
    ]);

    tree.addAll(pendingPaymentCards);
    tree.add(const SizedBox(height: 90));

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: tree,
          ),
        ));
  }
}

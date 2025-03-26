import 'package:dunki/components/roundedtextfield.dart';
import 'package:dunki/randomizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:wave_divider/wave_divider.dart';

class OrderScreen extends StatelessWidget {
  final String id;
  final String name;
  final String address;
  final TextEditingController notesController = TextEditingController();
  OrderScreen(
      {super.key, required this.id, required this.name, required this.address});

  void onNotesContentChanged(String content) {
    //TODO: Update the notes in the database for the current id
    debugPrint(content);
  }

  Future<Widget> getOrderItems(String id, context) async {
    //TODO: Fetch the order details for the specified order id
    Map orderDetails = {
      "items": ["Potato", "Tomato", "Chilly", "Onion"],
      "quantity": [2, 1, 25, 2],
      "price": [25, 20, 1, 60],
      "pickup_time": generateRandomTime(),
      "notes": ""
    };

    if (orderDetails["notes"] != "") {
      notesController.text = orderDetails["notes"];
    }

    List<Widget> tree = [];

    int netAmount = 0;

    for (var i = 0; i < orderDetails["items"].length; i++) {
      netAmount +=
          (orderDetails["quantity"][i] * orderDetails["price"][i]) as int;
      tree.add(Row(
        children: [
          Text(
              "${(i + 1).toString()}.   ${orderDetails["quantity"][i]} x ${orderDetails["items"][i]}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Satoshi")),
          const Spacer(),
          Text("${orderDetails["quantity"][i] * orderDetails["price"][i]}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Satoshi"))
        ],
      ));
    }
    tree.addAll([
      WaveDivider(
        color: Theme.of(context).colorScheme.primary,
      ),
      Row(
        children: [
          Text(
            "Total Amount: ",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Satoshi"),
          ),
          const Spacer(),
          Text("₹${netAmount.toString()}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Satoshi"))
        ],
      ),
      const SizedBox(height: 25),
      Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Pickup time is ${orderDetails["pickup_time"]}.",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15.0,
                  fontFamily: "Satoshi",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          Text(
            "Add Pick-Up Notes",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 23.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Satoshi"),
          ),
          const SizedBox(width: 5),
          Icon(
            CupertinoIcons.pencil_ellipsis_rectangle,
            size: 30,
            color: Theme.of(context).colorScheme.inverseSurface,
          )
        ],
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: 10 * 24,
        child: RoundedTextField(
          controller: notesController,
          obscureText: false,
          maxLines: 10,
          keyboardType: TextInputType.multiline,
          borderColor: Theme.of(context).primaryColor,
          hintText: "Type now, and your notes will be automatically saved!",
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
          fillColor: Theme.of(context).colorScheme.tertiary,
          onChanged: onNotesContentChanged,
        ),
      )
    ]);
    return Column(
      children: tree,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Satoshi"),
                ),
                const SizedBox(height: 3),
                Text(
                  address,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Satoshi"),
                ),
                const SizedBox(height: 25),
                FutureBuilder(
                  future: getOrderItems(id, context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasError) {
                      return const Center(
                          child: Text("Error fetching Order items"));
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return snapshot.data as Widget;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary),
                      );
                    }
                  },
                )
              ],
            ),
          ),
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
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            size: 45.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: const [SizedBox(width: 50)],
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:dunki/components/glowedupbutton.dart';
import 'package:dunki/components/roundedtextfield.dart';
import 'package:dunki/screens/printbillscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  int selectedTabIndex = 0;
  List<String> items = [];
  List<int> itemsQuantity = [];
  List<int> itemsPrice = [];

  void addItems() {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController itemQuantityController = TextEditingController();
    TextEditingController itemPriceController = TextEditingController();

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () => overlayEntry?.remove(),
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 220,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        spacing: 8.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 40,
                            child: RoundedTextField(
                              controller: itemNameController,
                              obscureText: false,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              borderColor: Theme.of(context).primaryColor,
                              hintText: "Item Name",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                              fillColor: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: RoundedTextField(
                              controller: itemQuantityController,
                              obscureText: false,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]{0,}')),
                              ],
                              keyboardType: TextInputType.multiline,
                              borderColor: Theme.of(context).primaryColor,
                              hintText: "Item Quantity in units/kg",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                              fillColor: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: RoundedTextField(
                              controller: itemPriceController,
                              obscureText: false,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]{0,}')),
                              ],
                              keyboardType: TextInputType.multiline,
                              borderColor: Theme.of(context).primaryColor,
                              hintText: "Item Price",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface),
                              fillColor: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: GlowedUpButton(
                                blurRadius: 35,
                                bgColor: const Color(0xFFff5400),
                                glowColor: Colors.transparent,
                                buttonText: const Text("Add",
                                    style: TextStyle(
                                        fontFamily: "Satoshi",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                onClickedCallback: () {
                                  if (itemNameController.text.isEmpty ||
                                      itemQuantityController.text.isEmpty ||
                                      itemPriceController.text.isEmpty) {
                                    return;
                                  }
                                  items.add(itemNameController.text);
                                  itemsQuantity.add(
                                      int.parse(itemQuantityController.text));
                                  itemsPrice
                                      .add(int.parse(itemPriceController.text));
                                  overlayEntry?.remove();
                                  setState(() {});
                                },
                                height: 35.0,
                                width: 70.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    overlayState.insert(overlayEntry);
  }

  Future<List<Widget>> getBillPageItems() async {
    List<Widget> columnChildrens = [];

    if (selectedTabIndex == 0) {
      columnChildrens.insert(
          0,
          Text(
            "Continue adding items and quantity",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ));
      if (items.isNotEmpty) {
        columnChildrens.add(const SizedBox(height: 10));
        for (var i = 0; i < items.length; i++) {
          columnChildrens.add(
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 10.0, right: 15.0),
                child: Row(
                  children: [
                    Text(
                        "${(i + 1).toString()}.   ${itemsQuantity[i]} x ${items[i]}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Satoshi")),
                    const Spacer(),
                    Text("₹${itemsQuantity[i] * itemsPrice[i]}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Satoshi"))
                  ],
                )),
          );
        }
      }
      columnChildrens.add(SizedBox(
        height: items.isEmpty ? 80.0 : 50,
      ));
      columnChildrens.add(Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
            GlowedUpButton(
              bgColor: const Color(0xFFFF6D1F),
              buttonText: const Text("Add Items",
                  style: TextStyle(
                      fontFamily: "Satoshi",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0)),
              height: 45.0,
              width: 100.0,
              onClickedCallback: addItems,
            ),
            const SizedBox(width: 15),
            Visibility(
              visible: items.isNotEmpty,
              child: GlowedUpButton(
                bgColor: const Color(0xFFff5400),
                glowColor: const Color(0xFFff5400),
                onClickedCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const PrintBillScreen()));
                },
                buttonText: const Text("Continue",
                    style: TextStyle(
                        fontFamily: "Satoshi",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0)),
                height: 45.0,
                width: 100.0,
              ),
            ),
          ],
        ),
      ));
    } else {
      final camera = await availableCameras();
      final firstCamera = camera.first;
      CameraController _controller;
      Future<void> _initializeControllerFuture;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium, // Choose a resolution preset
      );

      // Initialize the controller asynchronously
      _initializeControllerFuture = _controller.initialize();

      columnChildrens
          .add(SizedBox(height: 500, child: CameraPreview(_controller)));

      columnChildrens.addAll([
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: GlowedUpButton(
            bgColor: Color(0xFFff5400),
            glowColor: Color(0xFFff5400),
            buttonText: Text("Continue",
                style: TextStyle(
                    fontFamily: "Satoshi",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)),
            height: 45.0,
            width: 100.0,
          ),
        ),
      ]);
    }
    return columnChildrens;
  }

  @override
  Widget build(BuildContext context) {
    Widget billItemColumn = FutureBuilder(
      future: getBillPageItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data as List<Widget>,
            );
          }
        }
        return CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        );
      },
    );

    return Scaffold(
      body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40,
                  width: 260,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedTabIndex = 0;
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                color: selectedTabIndex == 0
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(13.0)),
                            child: Center(
                              child: Text(
                                "Add Manually",
                                style: TextStyle(
                                    fontFamily: "Satoshi",
                                    color: selectedTabIndex == 0
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Theme.of(context)
                                            .colorScheme
                                            .inverseSurface,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            selectedTabIndex = 1;
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                color: selectedTabIndex == 1
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(13.0)),
                            child: Center(
                              child: Text(
                                "Scan",
                                style: TextStyle(
                                    color: selectedTabIndex == 1
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Theme.of(context)
                                            .colorScheme
                                            .inverseSurface,
                                    fontFamily: "Satoshi",
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: billItemColumn,
              )
            ],
          )),
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
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
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

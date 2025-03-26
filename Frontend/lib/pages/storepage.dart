import 'package:dunki/components/storepageitemscard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StorePage extends StatelessWidget {
  final setState;
  Map? categoryData;

  StorePage({super.key, required this.setState, this.categoryData});

  Map? recommendationData = {
    "data": [
      "Potatoes are selling 25% faster rate than other vegies. Stock it more!",
      "In a few days, onions will be sold at 55% higher prices due to lack of availability. Stock now!"
    ]
  };

  List<Widget> recommendedCard = [];

  void onValueChangedCallback(int id, int newValue) {
    //TODO: Update the category data on the database.

    categoryData!.update("itemsCount", (existingValue) {
      existingValue[id] = newValue;
      return existingValue;
    });
  }

  bool isRecommendedColumnEmpty() {
    for (var widget in recommendedCard) {
      if (widget is SizedBox) {
        if (widget.width != 0.0 || widget.height != 0.0) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }

  void onRecommendationDismissedCallback(int id, setState) {
    //TODO: Remove the recommendation data from the database and from the list.

    recommendedCard[id] = const SizedBox.shrink();
    recommendationData = {"data": []};

    for (var i = 0; i < recommendationData!["data"].length; i++) {
      if (i == id) {
        recommendationData!["data"][i] = "";
      }
    }

    //Remove the empty string
    recommendationData!["data"].removeWhere((item) => item == "");

    if (isRecommendedColumnEmpty()) {
      recommendedCard = [];
    }

    debugPrint(recommendedCard.length.toString());

    setState(() {});
  }

  Future<List<Widget>> getCategoryData() async {
    //TODO: Fetch category data at each build.

    List<String> itemNames = categoryData!["items"];
    List<int> itemCount = categoryData!["itemsCount"];

    List<Widget> categoryDataCards = [];

    for (int x = 0; x < itemNames.length; x++) {
      categoryDataCards.add(CategoryItemCard(
          id: x,
          itemCount: itemCount[x],
          itemName: itemNames[x],
          onValueChangedCallback: onValueChangedCallback));
    }

    return categoryDataCards;
  }

  Future<List<Widget>> getRecommendationData(context, setState) async {
    //TODO: Fetch recommendation data and update it.

    for (int i = 0; i < recommendationData!["data"].length; i++) {
      recommendedCard.add(RecommendedCard(
          id: i,
          recommendationData: recommendationData as Map,
          setState: setState,
          onRecommendationDismissedCallback:
              onRecommendationDismissedCallback));
    }

    return recommendedCard;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tree = [
      const SizedBox(height: 20.0),
      Row(
        children: [
          Text(
            "In Store",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 7.0),
          Icon(
            Icons.shopping_cart,
            color: Theme.of(context).colorScheme.inverseSurface,
            size: 25.0,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //TODO: Add new item to the list and set the state
            },
            child: Container(
              width: 100,
              height: 25,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        blurRadius: 8.0)
                  ]),
              child: Center(
                child: Text(
                  "Add Items",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(height: 15),
      FutureBuilder(
          future: getCategoryData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const Center(
                    child: Text("Error fetching category data"));
              } else if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 30.0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: 4.0,
                  children: snapshot.data as List<Widget>,
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary),
            );
          }),
      const SizedBox(height: 25),
      Row(children: [
        Text(
          "Recommendations",
          style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 7.0),
        Icon(
          CupertinoIcons.moon_stars_fill,
          color: Theme.of(context).colorScheme.inverseSurface,
          size: 30.0,
        )
      ]),
      const SizedBox(height: 15.0),
      StatefulBuilder(builder: (context, setState) {
        return FutureBuilder(
          future: getRecommendationData(context, setState),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) {
              return const Center(
                  child: Text("Error fetching recommendations"));
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                spacing: 13.0,
                children: snapshot.data as List<Widget>,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary),
              );
            }
          },
        );
      }),
      const SizedBox(height: 50),
    ];

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

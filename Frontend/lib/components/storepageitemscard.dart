import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItemCard extends StatefulWidget {
  final int id;
  final int itemCount;
  final String itemName;
  final Function(int id, int newValue) onValueChangedCallback;

  const CategoryItemCard(
      {super.key,
      required this.id,
      required this.itemCount,
      required this.itemName,
      required this.onValueChangedCallback});

  @override
  State<CategoryItemCard> createState() => _CategoryItemCardState();
}

class _CategoryItemCardState extends State<CategoryItemCard> {
  TextDecoration textDecoration = TextDecoration.none;
  bool isControllersVisible = true;
  IconData decerementIcon = Icons.arrow_left;
  int itemCount = 0;

  @override
  void initState() {
    itemCount = widget.itemCount;
    isControllersVisible = widget.itemCount > 0;
    textDecoration =
        widget.itemCount > 0 ? TextDecoration.none : TextDecoration.lineThrough;
    decerementIcon = widget.itemCount > 1 ? Icons.arrow_left : Icons.delete;
    super.initState();
  }

  void updateItem(int newValue) {
    setState(() {
      widget.onValueChangedCallback(widget.id, newValue);
      itemCount = newValue;
      if (itemCount == 1) {
        decerementIcon = Icons.delete;
      } else {
        decerementIcon = Icons.arrow_left;
      }
      if (itemCount <= 0) {
        isControllersVisible = false;
        textDecoration = TextDecoration.lineThrough;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(13.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.tertiary, blurRadius: 10.0)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(widget.itemName,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Satoshi",
                    color: Theme.of(context).colorScheme.inverseSurface,
                    decoration: textDecoration)),
            const Spacer(),
            Visibility(
              visible: isControllersVisible,
              child: GestureDetector(
                onTap: () {
                  updateItem((itemCount - 1));
                },
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                      child: Icon(decerementIcon,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 20.0)),
                ),
              ),
            ),
            Visibility(
              visible: isControllersVisible,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(itemCount.toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface)),
              ),
            ),
            Visibility(
              visible: isControllersVisible,
              child: GestureDetector(
                onTap: () {
                  updateItem((itemCount + 1));
                },
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                      child: Icon(Icons.arrow_right,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 20.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final int id;
  final Map recommendationData;
  final dynamic setState;
  final Function(int id, dynamic setState) onRecommendationDismissedCallback;
  const RecommendedCard(
      {super.key,
      required this.id,
      required this.recommendationData,
      required this.setState,
      required this.onRecommendationDismissedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.tertiary, blurRadius: 5.0)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                recommendationData["data"][id],
                softWrap: true,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontFamily: "Satoshi",
                    fontSize: 12.0),
              ),
            ),
            const SizedBox(width: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => onRecommendationDismissedCallback(id, setState),
                child: Container(
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(13)),
                  child: Center(
                    child: Icon(CupertinoIcons.clear_thick,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 30.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

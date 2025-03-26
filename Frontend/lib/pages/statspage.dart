import 'package:dunki/components/revenuecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsPage extends StatelessWidget {
  final Map data;
  const StatsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<SalesData> salesData = [];
    List<CategoryData> categoryData = [];
    List<Widget> transactionData = [];

    for (var i = 0; i < data["sales_data"]["months"].length; i++) {
      salesData.add(SalesData(data["sales_data"]["months"][i],
          double.parse(data["sales_data"]["sales"][i].toString())));
    }

    for (var i = 0; i < data["category_data"]["category"].length; i++) {
      categoryData.add(CategoryData(
          data["category_data"]["category"][i],
          data["category_data"]["values"][i],
          data["category_data"]["category"][i]));
    }

    for (var i = 0; i < data["transaction_data"]["names"].length; i++) {
      transactionData.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 10.0),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["transaction_data"]["names"][i],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontFamily: "Satoshi",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800)),
                  Text(
                    "₹${data["transaction_data"]["values"][i]}",
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget transactionColumn = Column(
      children: transactionData,
    );

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            RevenueCard(data: data),
            const SizedBox(height: 20.0),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Sales Progress",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10.0),
                Column(
                  children: [
                    Icon(
                      CupertinoIcons.chart_bar_alt_fill,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      size: 27.0,
                    ),
                    const SizedBox(height: 7)
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 300,
                child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(
                      title: AxisTitle(text: "Months"),
                    ),
                    primaryYAxis: const CategoryAxis(
                      title: AxisTitle(text: "Sales in thousands"),
                    ),
                    palette: [
                      Theme.of(context).colorScheme.primary
                    ],
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          // Bind data source
                          dataSource: salesData,
                          xValueMapper: (SalesData sales, _) => sales.month,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                    ])),
            const SizedBox(height: 10),
            SizedBox(
                height: 400,
                child: IgnorePointer(
                  child: SfCircularChart(
                      enableMultiSelection: false,
                      tooltipBehavior: TooltipBehavior(enable: false),
                      title: const ChartTitle(text: "Trend Analysis"),
                      legend: const Legend(isVisible: false),
                      onChartTouchInteractionDown:
                          (ChartTouchInteractionArgs args) {},
                      onChartTouchInteractionMove:
                          (ChartTouchInteractionArgs args) {},
                      onChartTouchInteractionUp:
                          (ChartTouchInteractionArgs args) {},
                      palette: const [
                        Color(0xFFe85d04),
                        Color(0xFFf48c06),
                        Color(0xFFdb7c26),
                        Color(0xFFe36414),
                        Color(0xFFf4a261),
                        Color(0xFFff7b00),
                        Color(0xFFd8572a),
                      ],
                      series: <PieSeries<CategoryData, String>>[
                        PieSeries<CategoryData, String>(
                            explode: false,
                            dataSource: categoryData,
                            xValueMapper: (CategoryData data, _) => data.xData,
                            yValueMapper: (CategoryData data, _) => data.yData,
                            dataLabelMapper: (CategoryData data, _) =>
                                data.text,
                            selectionBehavior: SelectionBehavior(enable: false),
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                      ]),
                )),
            const SizedBox(height: 10),
            transactionColumn,
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;
  SalesData(this.month, this.sales);
}

class CategoryData {
  final String xData;
  final num yData;
  String? text;
  CategoryData(this.xData, this.yData, this.text);
}

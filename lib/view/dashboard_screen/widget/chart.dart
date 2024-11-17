import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/item_model/item_model.dart';

class ChartData {
  final String unit;
  final double price;

  ChartData({required this.unit, required this.price});
}

class CategoryChart extends StatelessWidget {
  final String selectedCategory;
  final List<ItemModel> items;

  const CategoryChart({
    super.key,
    required this.selectedCategory,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // Filter items by category
    final filteredItems =
        items.where((item) => item.category == selectedCategory).toList();

    // Map filtered items to chart data
    final chartData = filteredItems
        .map(
          (item) => ChartData(
            unit: item.unit,
            price: double.parse(item.price),
          ),
        )
        .toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text('Please select a category to view'),
      );
    } else {
      return SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          axisLine: AxisLine(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
        ),
        primaryYAxis: const NumericAxis(
          axisLine: AxisLine(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          majorGridLines: MajorGridLines(color: Colors.transparent),
        ),
        plotAreaBorderColor: Colors.transparent,
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: (data, point, series, pointIndex, seriesIndex) {
            final ChartData chartData = series.dataSource![pointIndex];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Unit: ${chartData.unit}\nPrice: ${chartData.price}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
        series: [
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.unit,
            yValueMapper: (ChartData data, _) => data.price,
            color: Colors.blue,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }
  }
}

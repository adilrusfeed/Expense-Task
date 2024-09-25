import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/expense_provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int? _touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Summary'),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          final expenses = value.expenses;

          Map<String, double> categoryTotals = {};
          double totalExpenses = 0.0;
          for (var expense in expenses) {
            totalExpenses += expense.amount!;
            if (categoryTotals.containsKey(expense.category)) {
              categoryTotals[expense.category!] =
                  categoryTotals[expense.category!]! + expense.amount!;
            } else {
              categoryTotals[expense.category!] = expense.amount!.toDouble();
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PieChart(PieChartData(
                    sections: categoryTotals.entries.map((entry) {
                      final isTouched = _touchedIndex ==
                          categoryTotals.keys.toList().indexOf(entry.key);

                      return PieChartSectionData(
                          title: isTouched
                              ? '${entry.key}\n\$${entry.value.toStringAsFixed(2)}'
                              : '\$${entry.value.toStringAsFixed(2)}',
                          value: entry.value,

                          color: _getCategoryColor(entry.key),
                          titleStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isTouched ? 18 : 14),
                          radius: isTouched ? 80 : 60);
                    }).toList(),
                    centerSpaceRadius: 50,
                    sectionsSpace: 4,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    startDegreeOffset: 180,
                  )),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: categoryTotals.entries.map((entry) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          color: _getCategoryColor(entry.key),
                        ),
                        SizedBox(width: 8),
                        Text(entry.key),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.green;
      case 'Transport':
        return Colors.blue;
      case 'Entertainment':
        return Colors.orange;
      case 'Rent':
        return Colors.red;
      case 'Grociery':
        return Colors.yellow;
      case 'Food':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

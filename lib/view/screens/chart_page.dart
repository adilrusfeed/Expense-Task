import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/expense_provider.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Summary'),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          final expenses = value.expenses;

          // Group expenses by category
          Map<String, double> categoryTotals = {};
          for (var expense in expenses) {
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
                      return PieChartSectionData(
                        title: entry.key,
                        value: entry.value,
                        color: _getCategoryColor(entry.key),
                        titleStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList(),
                    centerSpaceRadius: 50,
                    sectionsSpace: 4,
                    pieTouchData:
                        PieTouchData(touchCallback: (event, response) {}),
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

  // Helper function to get category colors
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.green;
      case 'Transport':
        return Colors.blue;
      case 'Entertainment':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

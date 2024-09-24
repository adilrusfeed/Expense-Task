import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static Color getCategoryColor(String categoryName) {
    if (categoryName == 'Shopping') {
      return Colors.pink;
    } else if (categoryName == 'Auto fair') {
      return Colors.blue;
    } else if (categoryName == 'Food') {
      return Colors.green;
    } else if (categoryName == 'Grociery') {
      return Colors.purpleAccent;
    } else if (categoryName == 'Rent') {
      return Colors.lime;
    }
    return Colors.orange;
  }
  static String getTotalForCategory(
      String category, List<ExpenseModel> expenses) {
    double total = expenses
        .where((expense) => expense.category == category)
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    final formatter = NumberFormat("#,##,###.0", "en_US");
    return formatter.format(total);
  }

  static String calculateTotalAmount(List<ExpenseModel> expenses) {
    double totalAmount = 0.0;
    for (var expense in expenses) {
      totalAmount += expense.amount!;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

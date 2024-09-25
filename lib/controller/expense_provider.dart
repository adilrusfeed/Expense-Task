import 'dart:developer';

import 'package:expensetracker/model/expense_model.dart';
import 'package:expensetracker/service/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> expenses = [];
  final box = Hive.box<ExpenseModel>('expense_box');
  ExpenseProvider() {
    init();
  }
  Future<void> init() async {
    await Hive.openBox<ExpenseModel>('expense_box');
    loadData();
  }

  Future<void> loadData() async {
    try {
      final expenseBox = Hive.box<ExpenseModel>('expense_box');
      expenses = expenseBox.values.toList();
      notifyListeners();
    } catch (e) {
      Exception(e);
    }
  }

  addExpenses(ExpenseModel expense) async {
    try {
      final id = expense.id;
      final amount = expense.amount;
      final date = expense.date;
      final description = expense.description;
      final category = expense.category;
      if (id != null &&
          amount != null &&
          date != null &&
          description != null &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: id,
          amount: amount,
          date: date,
          category: category,
          description: description,
        );
        await DataBase.addExpenseBox(expense);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  void resetExpenses() {
    expenses.clear();
    notifyListeners();
  }

  updateExpense(ExpenseModel expens) async {
    try {
      final amount = expens.amount;
      final date = expens.date;
      final description = expens.description;
      final category = expens.category;
      if (expens.id != null &&
          amount != null &&
          date != null &&
          description != null &&
          category!.isNotEmpty) {
        ExpenseModel expense = ExpenseModel(
          id: expens.id,
          amount: amount,
          date: date,
          category: category,
          description: description,
        );
        await DataBase.updateExpense(expens.id!, expense);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error in adding expense$e');
    }
  }

  Future<void> selctDate(
      BuildContext context, TextEditingController date) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      date.text = formattedDate;
      log('Selected date: $formattedDate');
    }
    notifyListeners();
  }
}

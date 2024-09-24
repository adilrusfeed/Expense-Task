import 'package:expensetracker/model/expense_model.dart';
import 'package:hive/hive.dart';

class DataBase {
  static addExpenseBox(ExpenseModel expense) async {
    try {
      final Box<ExpenseModel> expenseDb = Hive.box<ExpenseModel>('expense_box');
      expenseDb.add(expense);
    } catch (e) {
      throw Exception('Error in storing$e');
    }
  }

  static deleteExpense(String id) async {
    try {
      final Box<ExpenseModel> expenseDb = Hive.box<ExpenseModel>('expense_box');
      int index =
          expenseDb.values.toList().indexWhere((expense) => expense.id == id);
      if (index != -1) {
        await expenseDb.deleteAt(index);
      }
    } catch (e) {
      throw Exception('Error in deleting: $e');
    }
  }

  static updateExpense(String id, ExpenseModel updatedExpense) async {
    try {
      final Box<ExpenseModel> expenseDb = Hive.box<ExpenseModel>('expense_box');
      int index =
          expenseDb.values.toList().indexWhere((expense) => expense.id == id);
      if (index != -1) {
        await expenseDb.putAt(index, updatedExpense);
      }
    } catch (e) {
      throw Exception('Error in updating expense: $e');
    }
  }
}

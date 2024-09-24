import 'package:expensetracker/controller/expense_provider.dart';
import 'package:expensetracker/service/expense_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.expenses.length,
        itemBuilder: (context, index) {
          final expense = value.expenses.reversed.toList()[index];
          return Dismissible(
            key: Key(expense.id.toString()),
            background: Container(
                color: Colors.red.withOpacity(0.5),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
            onDismissed: (direction) async {
              DataBase.deleteExpense(expense.id!);
              await value.loadData();
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Expense'),
                    content:
                        Text('Are you sure you want to delete this expense!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Delete"))
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text('${expense.description}'),
            ),
          );
        },
      ),
    );
  }
}

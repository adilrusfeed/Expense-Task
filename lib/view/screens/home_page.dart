import 'package:expensetracker/controller/expense_provider.dart';
import 'package:expensetracker/view/widgets/category_items.dart';
import 'package:expensetracker/view/widgets/category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_expense.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(color: Color.fromARGB(255, 6, 18, 49)),
          child: Consumer<ExpenseProvider>(
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: size.height * 0.62,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          SizedBox(
                            height: size.height * 0.18,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CategoryList(
                                  categoryNames: CategoryItems.categoryNames,
                                  categoryIcons: CategoryItems.categoryIcons,
                                  size: size),
                            ),
                          ),
                          // Expanded()
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AddDialogue(
                  categoryIcons: CategoryItems.categoryIcons,
                  categoryNames: CategoryItems.categoryNames);
            },
          );
        },
      ),
    );
  }
}

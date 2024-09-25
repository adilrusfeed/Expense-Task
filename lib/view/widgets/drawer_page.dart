// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:expensetracker/view/screens/chart_page.dart';
import 'package:expensetracker/view/widgets/drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/expense_provider.dart';

class DrawerHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(
              'assets/settings_lottie.json',
              width: 250,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChartPage(),
              ));
            },
            child: DrawerItem(
                text: "Summary", icon: Icons.insert_chart_outlined_outlined),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reset Expenses'),
                  content: Text('Are you sure you want to reset all expenses?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Provider.of<ExpenseProvider>(context, listen: false)
                            .resetExpenses();
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                  ],
                ),
              );
            },
            child: DrawerItem(
              text: "Reset",
              icon: Icons.restore_from_trash_outlined,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: DrawerItem(text: "Exit", icon: Icons.exit_to_app),
          ),
          Divider(),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Text(
              "version : 1.0.1",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

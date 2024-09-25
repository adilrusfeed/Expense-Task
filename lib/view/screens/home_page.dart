import 'package:expensetracker/controller/expense_provider.dart';
import 'package:expensetracker/view/screens/expense_list.dart';
import 'package:expensetracker/view/widgets/category_items.dart';
import 'package:expensetracker/view/widgets/category_list.dart';
import 'package:expensetracker/view/widgets/color_gradient.dart';
import 'package:expensetracker/view/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_expense.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E X P E N S E  T R A C K",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 6, 18, 49),
      ),
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
                          Expanded(
                            child: ExpenseList(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20, bottom: size.height * 0.57),
                      child: Container(
                        height: size.height * 0.26,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.45),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: ColorGradient.cardLineGradient(),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * 0.15,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(200),
                                ),
                                color: Colors.blue.withOpacity(0.05),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: size.height * 0.20,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(200),
                                    ),
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 2),
                                  child: Container(
                                    height: 2.5,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: ColorGradient.cardGradient(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'E X P E N S E   C A R D',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(
                                '₹ ${AppUtils.calculateTotalAmount(value.expenses)}',
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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

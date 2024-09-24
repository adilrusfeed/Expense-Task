
import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/expense_provider.dart';
import '../widgets/text_widget.dart';

class EditDialogue extends StatefulWidget {
  EditDialogue({
    Key? key,
    required this.categoryIcons,
    required this.categoryNames,
    required this.expense,
  }) : super(key: key);

  final ExpenseModel expense;
  final List<IconData> categoryIcons;
  final List<String> categoryNames;

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedCategory;
  final style = GoogleFonts.raleway();

  @override
  void initState() {
    super.initState();
    amountController.text = widget.expense.amount.toString();
    descriptionController.text = widget.expense.description ?? '';
    dateController.text = DateFormat('dd/MM/yyyy').format(widget.expense.date!);
    selectedCategory = widget.expense.category;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ExpenseProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Edit Expense',
              style: GoogleFonts.raleway(color: Color.fromARGB(255, 6, 43, 66)),
            ),
            actions: [
              TextWidget(
                style: GoogleFonts.montserrat(),
                controller: amountController,
                hintText: 'Amount',
                type: TextInputType.number,
              ),
              SizedBox(height: 15),
              TextWidget(
                style: style,
                controller: dateController,
                icon: Icons.date_range,
                onTap: () {
                  value.selctDate(context, dateController);
                },
                hintText: 'Date',
                type: TextInputType.phone,
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                style: GoogleFonts.raleway(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Category',
                  hintStyle: style,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: selectedCategory,
                onChanged: (newValue) {
                    selectedCategory = newValue;
                },
                items: List.generate(widget.categoryIcons.length, (index) {
                  return DropdownMenuItem<String>(
                    value: widget.categoryNames[index],
                    child: Row(
                      children: [
                        Icon(widget.categoryIcons[index]),
                        SizedBox(width: 10),
                        Text(
                          widget.categoryNames[index],
                          style: style,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 15),
              TextWidget(
                style: style,
                controller: descriptionController,
                hintText: 'Description',
                type: TextInputType.text,
                maxLines: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await value.updateExpense(
                        ExpenseModel(
                          id: widget.expense.id,
                          amount: int.parse(amountController.text),
                          date: DateFormat('dd/MM/yyyy')
                              .parse(dateController.text),
                          category: selectedCategory!,
                          description: descriptionController.text,
                        ),
                      );
                      amountController.clear();
                      descriptionController.clear();
                      dateController.clear();
                      Navigator.of(context).pop();
                      value.loadData();
                    },
                    child: Text(
                      'Save',
                      style: style,
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: style,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

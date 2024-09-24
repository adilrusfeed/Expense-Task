import 'package:expensetracker/view/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/expense_provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryNames,
    required this.categoryIcons,
    required this.size,
  });

  final List<String> categoryNames;
  final List<IconData> categoryIcons;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryNames.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: AppUtils.getCategoryColor(categoryNames[index])
                        .withOpacity(0.1)),
                left: BorderSide(
                    color: AppUtils.getCategoryColor(categoryNames[index])
                        .withOpacity(0.1)),
              ),
              color: AppUtils.getCategoryColor(categoryNames[index])
                  .withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        categoryIcons[index],
                        color: AppUtils.getCategoryColor(categoryNames[index]),
                        size: 25,
                      ),
                      SizedBox(width: 8),
                      Text(
                        categoryNames[index],
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:
                              AppUtils.getCategoryColor(categoryNames[index]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.002),
                  Consumer<ExpenseProvider>(
                    builder: (context, value, child) => Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '₹ ${AppUtils.getTotalForCategory(categoryNames[index], value.expenses)}',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          color:
                              AppUtils.getCategoryColor(categoryNames[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

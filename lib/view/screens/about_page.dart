import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on_outlined,
                    size: 40, color: Colors.teal),
                SizedBox(width: 10),
                Text(
                  'Expense Tracker App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.description_outlined,
                    size: 28, color: Colors.grey[700]),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This app allows you to track your daily expenses, categorize them, and view a summary of your spending in an intuitive and visual way.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              'How to Use:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 15),
            _buildInstructionItem(
              icon: Icons.add_circle_outline,
              text:
                  'Add your expenses by providing the amount, date, category, and description.',
            ),
            SizedBox(height: 10),
            _buildInstructionItem(
              icon: Icons.list_alt,
              text:
                  'View all expenses in a list and edit or delete them as needed.',
            ),
            SizedBox(height: 10),
            _buildInstructionItem(
              icon: Icons.pie_chart_outline,
              text:
                  'Use the summary screen to see a graphical representation of your spending habits.',
            ),
            SizedBox(height: 10),
            _buildInstructionItem(
              icon: Icons.refresh,
              text:
                  'Reset your data easily using the Reset option from the drawer.',
            ),
            Spacer(),
            Center(
              child: Column(
                children: [
                  Text(
                    'Version 1.0.1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5),
                  Icon(Icons.info_outline, color: Colors.teal[300], size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 26, color: Colors.teal),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

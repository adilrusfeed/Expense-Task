import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId:1)
class ExpenseModel {
   @HiveField(0)
  int? amount;
  @HiveField(1)
  String?description;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  String? category;
  @HiveField(4)
  String? id;
  ExpenseModel({
    this.id,
    this.amount,
    this.description,
    this.date,
    this.category
  });
}
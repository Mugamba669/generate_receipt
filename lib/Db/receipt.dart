import 'package:hive/hive.dart';
part 'receipt.g.dart';

@HiveType(typeId: 0)
class Receipt {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String pdtName;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String receiptDate;

  @HiveField(5)
  late int quantity;

  Receipt({
    required this.name,
    required this.amount,
    required this.pdtName,
    required this.description,
    required this.quantity,
    required this.receiptDate,
  });
}

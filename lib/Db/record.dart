import 'package:hive_flutter/hive_flutter.dart';
part 'record.g.dart';

/* *****************************name: "",
      amount: 0,
      date: DateTime.now(),
      type: "",
      paid: false, */
@HiveType(typeId: 1)
class Record {
  @HiveField(0)
  late String receiptId;

  @HiveField(1)
  List<Map<String, dynamic>> data;

  @HiveField(2)
  String owner;

  @HiveField(3)
  bool? paid;

  @HiveField(4)
  DateTime? date;

  @HiveField(5)
  List<double> amount;

  @HiveField(6)
  List<double> ttcost;

  @HiveField(7)
  double? totalCostPrice;

  @HiveField(8)
  double? totalPaid;

  Record(
      {required this.receiptId,
      required this.data,
      required this.owner,
      required this.amount,
      required this.ttcost,
      this.date,
      this.paid,
      this.totalCostPrice,
      this.totalPaid});
}

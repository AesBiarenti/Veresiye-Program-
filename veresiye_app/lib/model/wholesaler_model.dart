import 'package:hive/hive.dart';

part 'wholesaler_model.g.dart';

@HiveType(typeId: 3)
class WholeSaler {
  WholeSaler({
    required this.id,
    required this.name,
    required this.number,
    required this.totalPrice,
    required this.orderDetails,
    required this.creationDate,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String number;
  @HiveField(3)
  double totalPrice;
  @HiveField(4)
  List<WOrderDetail> orderDetails;
  @HiveField(5)
  DateTime creationDate;

  @override
  String toString() {
    return "$id $name Order Details: $orderDetails Created on: $creationDate";
  }
}

@HiveType(typeId: 4)
class WOrderDetail {
  WOrderDetail({
    required this.id,
    required this.description,
    required this.debt,
    required this.paid,
    required this.date,
  });

  @HiveField(6)
  String id;
  @HiveField(7)
  String description;
  @HiveField(8)
  double debt;
  @HiveField(9)
  double paid;
  @HiveField(10)
  DateTime date;

  @override
  String toString() {
    return "$description Debt: $debt Paid: $paid Date: $date";
  }
}

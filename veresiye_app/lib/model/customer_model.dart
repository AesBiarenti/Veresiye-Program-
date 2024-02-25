import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 1)
class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.address,
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
  String address;
  @HiveField(3)
  String number;
  @HiveField(4)
  double totalPrice;
  @HiveField(5)
  List<OrderDetail> orderDetails;
  @HiveField(6)
  DateTime creationDate;

  @override
  String toString() {
    return "$id $name Order Details: $orderDetails Created on: $creationDate";
  }
}

@HiveType(typeId: 2)
class OrderDetail {
  OrderDetail({
    required this.id,
    required this.description,
    required this.debt,
    required this.paid,
    required this.date,
  });

  @HiveField(7)
  String id;
  @HiveField(8)
  String description;
  @HiveField(9)
  double debt;
  @HiveField(10)
  double paid;
  @HiveField(11)
  DateTime date;

  @override
  String toString() {
    return "$description Debt: $debt Paid: $paid Date: $date";
  }
}
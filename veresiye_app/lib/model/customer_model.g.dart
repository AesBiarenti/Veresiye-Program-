// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 1;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      number: fields[3] as String,
      totalPrice: fields[4] as double,
      orderDetails: (fields[5] as List).cast<OrderDetail>(),
      creationDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.totalPrice)
      ..writeByte(5)
      ..write(obj.orderDetails)
      ..writeByte(6)
      ..write(obj.creationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderDetailAdapter extends TypeAdapter<OrderDetail> {
  @override
  final int typeId = 2;

  @override
  OrderDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDetail(
      id: fields[7] as String,
      description: fields[8] as String,
      debt: fields[9] as double,
      paid: fields[10] as double,
      date: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OrderDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.debt)
      ..writeByte(10)
      ..write(obj.paid)
      ..writeByte(11)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

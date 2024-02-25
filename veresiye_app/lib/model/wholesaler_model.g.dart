// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wholesaler_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WholeSalerAdapter extends TypeAdapter<WholeSaler> {
  @override
  final int typeId = 3;

  @override
  WholeSaler read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WholeSaler(
      id: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as String,
      totalPrice: fields[3] as double,
      orderDetails: (fields[4] as List).cast<WOrderDetail>(),
      creationDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WholeSaler obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.totalPrice)
      ..writeByte(4)
      ..write(obj.orderDetails)
      ..writeByte(5)
      ..write(obj.creationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WholeSalerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WOrderDetailAdapter extends TypeAdapter<WOrderDetail> {
  @override
  final int typeId = 4;

  @override
  WOrderDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WOrderDetail(
      id: fields[6] as String,
      description: fields[7] as String,
      debt: fields[8] as double,
      paid: fields[9] as double,
      date: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WOrderDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.debt)
      ..writeByte(9)
      ..write(obj.paid)
      ..writeByte(10)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WOrderDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

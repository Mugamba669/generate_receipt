// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 1;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      receiptId: fields[0] as String,
      data: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      owner: fields[2] as String,
      amount: (fields[5] as List).cast<double>(),
      ttcost: (fields[6] as List).cast<double>(),
      date: fields[4] as DateTime?,
      paid: fields[3] as bool?,
      totalCostPrice: fields[7] as double?,
      totalPaid: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.receiptId)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.paid)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.ttcost)
      ..writeByte(7)
      ..write(obj.totalCostPrice)
      ..writeByte(8)
      ..write(obj.totalPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

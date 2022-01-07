// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageAdapter extends TypeAdapter<Package> {
  @override
  final int typeId = 0;

  @override
  Package read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Package(
      packageId: fields[0] as dynamic,
      uid: fields[1] as dynamic,
      itemList: fields[2] as dynamic,
      location: fields[3] as dynamic,
      image: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Package obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.packageId)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.itemList)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

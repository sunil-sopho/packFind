// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImgAdapter extends TypeAdapter<Img> {
  @override
  final int typeId = 1;

  @override
  Img read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Img(
      img: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Img obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImgAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

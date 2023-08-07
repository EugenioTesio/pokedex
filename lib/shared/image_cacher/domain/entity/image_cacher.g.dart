// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_cacher.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageCacherAdapter extends TypeAdapter<ImageCacher> {
  @override
  final int typeId = 5;

  @override
  ImageCacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageCacher(
      imageBytes: fields[0] as Uint8List,
      key: fields[1] as String,
      lastModified: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ImageCacher obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageBytes)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageCacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

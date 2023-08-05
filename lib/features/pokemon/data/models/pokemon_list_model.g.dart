// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonListModelAdapter extends TypeAdapter<PokemonListModel> {
  @override
  final int typeId = 1;

  @override
  PokemonListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonListModel(
      count: fields[0] as int,
      next: fields[1] as String,
      previous: fields[2] as String,
      results: (fields[3] as List).cast<PokemonListItemModel>(),
      offset: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.next)
      ..writeByte(2)
      ..write(obj.previous)
      ..writeByte(3)
      ..write(obj.results)
      ..writeByte(4)
      ..write(obj.offset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonListSourceAdapter extends TypeAdapter<PokemonListSource> {
  @override
  final int typeId = 3;

  @override
  PokemonListSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonListSource(
      localDataSource: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonListSource obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.localDataSource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonListSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

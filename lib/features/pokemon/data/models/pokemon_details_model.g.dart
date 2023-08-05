// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonDetailsModelAdapter extends TypeAdapter<PokemonDetailsModel> {
  @override
  final int typeId = 2;

  @override
  PokemonDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonDetailsModel(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as int,
      weight: fields[3] as int,
      abilities: (fields[4] as List?)?.cast<PokemonAbilitiesModel>(),
      sprites: fields[5] as PokemonSpritesModel?,
      types: (fields[6] as List?)?.cast<PokemonTypesModel>(),
      baseExperience: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonDetailsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.abilities)
      ..writeByte(5)
      ..write(obj.sprites)
      ..writeByte(6)
      ..write(obj.types)
      ..writeByte(7)
      ..write(obj.baseExperience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

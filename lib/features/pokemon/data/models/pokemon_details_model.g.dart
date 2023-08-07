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
      id: fields[0] as int?,
      name: fields[1] as String,
      height: fields[2] as int?,
      weight: fields[3] as int?,
      abilities: (fields[4] as List?)?.cast<PokemonAbilitiesModel>(),
      sprites: fields[5] as PokemonSpritesModel?,
      types: (fields[6] as List?)?.cast<PokemonTypesModel>(),
      baseExperience: fields[7] as int?,
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

class PokemonAbilitiesModelAdapter extends TypeAdapter<PokemonAbilitiesModel> {
  @override
  final int typeId = 6;

  @override
  PokemonAbilitiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonAbilitiesModel(
      ability: fields[0] as PokemonAbilityModel?,
      isHidden: fields[1] as bool?,
      slot: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonAbilitiesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ability)
      ..writeByte(1)
      ..write(obj.isHidden)
      ..writeByte(2)
      ..write(obj.slot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAbilitiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonAbilityModelAdapter extends TypeAdapter<PokemonAbilityModel> {
  @override
  final int typeId = 10;

  @override
  PokemonAbilityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonAbilityModel(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonAbilityModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAbilityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonTypesModelAdapter extends TypeAdapter<PokemonTypesModel> {
  @override
  final int typeId = 8;

  @override
  PokemonTypesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonTypesModel(
      slot: fields[0] as int?,
      type: fields[1] as PokemonTypeModel,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonTypesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.slot)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonTypesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonTypeModelAdapter extends TypeAdapter<PokemonTypeModel> {
  @override
  final int typeId = 9;

  @override
  PokemonTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonTypeModel(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonSpritesModelAdapter extends TypeAdapter<PokemonSpritesModel> {
  @override
  final int typeId = 7;

  @override
  PokemonSpritesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonSpritesModel(
      backDefault: fields[0] as String?,
      backFemale: fields[1] as String?,
      backShiny: fields[2] as String?,
      backShinyFemale: fields[3] as String?,
      frontDefault: fields[4] as String?,
      frontFemale: fields[5] as String?,
      frontShiny: fields[6] as String?,
      frontShinyFemale: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonSpritesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.backDefault)
      ..writeByte(1)
      ..write(obj.backFemale)
      ..writeByte(2)
      ..write(obj.backShiny)
      ..writeByte(3)
      ..write(obj.backShinyFemale)
      ..writeByte(4)
      ..write(obj.frontDefault)
      ..writeByte(5)
      ..write(obj.frontFemale)
      ..writeByte(6)
      ..write(obj.frontShiny)
      ..writeByte(7)
      ..write(obj.frontShinyFemale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonSpritesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

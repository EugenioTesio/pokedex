import 'package:equatable/equatable.dart';

base class PokemonDetails extends Equatable {
  const PokemonDetails({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.weight,
    this.abilities,
    this.sprites,
    this.types,
  });
  final List<PokemonAbilities>? abilities;
  final int? baseExperience;
  final int? height;
  final int? id;
  final String name;
  final PokemonSprites? sprites;
  final List<PokemonTypes>? types;
  final int? weight;

  @override
  List<Object?> get props {
    return [
      baseExperience,
      height,
      id,
      name,
      weight,
      abilities,
      sprites,
      types,
    ];
  }
}

base class PokemonAbilities extends Equatable {
  const PokemonAbilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
  final PokemonAbility? ability;
  final bool? isHidden;
  final int? slot;

  @override
  List<Object?> get props {
    return [
      ability,
      isHidden,
      slot,
    ];
  }
}

base class PokemonAbility extends Equatable {
  const PokemonAbility({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;

  @override
  List<Object?> get props {
    return [
      name,
      url,
    ];
  }
}

base class PokemonTypes extends Equatable {
  const PokemonTypes({
    required this.slot,
    required this.type,
  });
  final int? slot;
  final PokemonType type;

  @override
  List<Object?> get props {
    return [
      slot,
      type,
    ];
  }
}

base class PokemonSprites extends Equatable {
  const PokemonSprites({
    required this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  List<String> asList() {
    final list = <String>[];
    if (backDefault != null) list.add(backDefault!);
    if (backFemale != null) list.add(backFemale!);
    if (backShiny != null) list.add(backShiny!);
    if (backShinyFemale != null) list.add(backShinyFemale!);
    if (frontDefault != null) list.add(frontDefault!);
    if (frontFemale != null) list.add(frontFemale!);
    if (frontShiny != null) list.add(frontShiny!);
    if (frontShinyFemale != null) list.add(frontShinyFemale!);
    return list;
  }

  @override
  List<Object?> get props {
    return [
      backDefault,
      backFemale,
      backShiny,
      backShinyFemale,
      frontDefault,
      frontFemale,
      frontShiny,
      frontShinyFemale,
    ];
  }
}

base class PokemonType extends Equatable {
  const PokemonType({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;

  @override
  List<Object?> get props {
    return [
      name,
      url,
    ];
  }
}

class PokemonDetails {
  PokemonDetails({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.weight,
    this.abilities,
    this.sprites,
    this.types,
  });
  final List<PokemonAbility>? abilities;
  final int baseExperience;
  final int height;
  final int id;
  final String name;
  final PokemonSprites? sprites;
  final List<PokemonTypes>? types;
  final int weight;
}

class PokemonAbilities {
  PokemonAbilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
  final PokemonAbility? ability;
  final bool isHidden;
  final int slot;
}

class PokemonAbility {
  PokemonAbility({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}

class PokemonTypes {
  PokemonTypes({
    required this.slot,
    required this.type,
  });
  final int slot;
  final PokemonType type;
}

class PokemonSprites {
  PokemonSprites({
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
}

class PokemonType {
  PokemonType({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}
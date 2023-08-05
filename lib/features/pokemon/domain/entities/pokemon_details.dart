base class PokemonDetails {
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
  final int baseExperience;
  final int height;
  final int id;
  final String name;
  final PokemonSprites? sprites;
  final List<PokemonTypes>? types;
  final int weight;
}

base class PokemonAbilities {
  const PokemonAbilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
  final PokemonAbility? ability;
  final bool isHidden;
  final int slot;
}

base class PokemonAbility {
  const PokemonAbility({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}

base class PokemonTypes {
  const PokemonTypes({
    required this.slot,
    required this.type,
  });
  final int slot;
  final PokemonType type;
}

base class PokemonSprites {
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
}

base class PokemonType {
  const PokemonType({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}

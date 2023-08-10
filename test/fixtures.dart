import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';

const pokemonAbilityFixture2 = PokemonAbility(
  name: 'chlorophyll',
  url: 'https://pokeapi.co/api/v2/ability/34/',
);

const spritesFixture = PokemonSpritesModel(
  backDefault: 'backDefault',
  backFemale: 'backFemale',
  backShiny: 'backShiny',
  backShinyFemale: 'backShinyFemale',
  frontDefault: 'frontDefault',
  frontFemale: 'frontFemale',
  frontShiny: 'frontShiny',
  frontShinyFemale: 'frontShinyFemale',
);

const pokemonDetailsModelFixture = PokemonDetailsModel(
  id: 1,
  name: 'name',
  height: 0,
  weight: 0,
  abilities: [],
  sprites: spritesFixture,
  types: [],
  baseExperience: 1,
);

const pokemonTypeFixture = PokemonType(
  name: 'grass',
  url: 'https://pokeapi.co/api/v2/type/12/',
);

final pokemonTreeItemsListModelFixture = PokemonListModel(
  count: 1,
  next: 'next',
  previous: 'previous',
  results: [
    const PokemonListItemModel(
      name: 'name1',
      url: 'url1',
    ),
    const PokemonListItemModel(
      name: 'name2',
      url: 'url2',
    ),
    const PokemonListItemModel(
      name: 'name3',
      url: 'url3',
    ),
  ],
);

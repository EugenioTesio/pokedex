import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokemon/data/datasources/local_data_source.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/repositories/pokemon_repository_impl.dart';

import '../../../../fixtures.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box<PokemonDetailsModel> {}

class MockPokemonRemoteDataSource extends Mock
    implements PokemonRemoteDataSource {}

class MockPokemonLocalDataSource extends Mock
    implements PokemonLocalDataSource {}

void main() {
  late PokemonRepositoryImpl pokemonRepositoryImpl;
  late MockPokemonRemoteDataSource mockPokemonRemoteDataSource;
  late MockPokemonLocalDataSource mockPokemonLocalDataSource;

  setUp(() {
    mockPokemonRemoteDataSource = MockPokemonRemoteDataSource();
    mockPokemonLocalDataSource = MockPokemonLocalDataSource();
    pokemonRepositoryImpl = PokemonRepositoryImpl(
      pokemonRemoteDataSource: mockPokemonRemoteDataSource,
      pokemonLocalDataSource: mockPokemonLocalDataSource,
    );
  });

  group('fetchPokemonDetails', () {
    test(
        'should return PokemonDetails when the call to remote data source '
        'is successful', () async {
      //arrange
      const pokemonName = 'bulbasaur';
      when(() => mockPokemonRemoteDataSource.fetchPokemonDetails(pokemonName))
          .thenAnswer((_) async => (pokemonDetailsModelFixture, null));
      when(
        () => mockPokemonLocalDataSource.putPokemonDetailsModel(
          pokemonName,
          pokemonDetailsModelFixture,
        ),
      ).thenAnswer((_) async => Future.value());

      //act
      final response =
          await pokemonRepositoryImpl.fetchPokemonDetails(pokemonName);

      //assert
      verify(
        () => mockPokemonLocalDataSource.putPokemonDetailsModel(
          pokemonName,
          pokemonDetailsModelFixture,
        ),
      );
      assert(
        response.$1 == pokemonDetailsModelFixture.toEntity(),
        'response should be pokemonDetailsFixture.toEntity()',
      );
      assert(
        response.$2 == null,
        'response error should be null',
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/http_client/domain/app_exception.dart';
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
    test('should return remote data source when is online', () async {
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

    test('should return local data source when is offline', () async {
      //arrange
      const pokemonName = 'bulbasaur';
      const exception = AppException(message: 'error');
      when(() => mockPokemonRemoteDataSource.fetchPokemonDetails(pokemonName))
          .thenAnswer((_) async => (null, exception));
      when(
        () => mockPokemonLocalDataSource.getPokemonDetailsModel(
          pokemonName,
        ),
      ).thenAnswer((_) async => pokemonDetailsModelFixture);

      //act
      final response =
          await pokemonRepositoryImpl.fetchPokemonDetails(pokemonName);

      //assert
      assert(
        response.$1 == pokemonDetailsModelFixture.toEntity(),
        'response should be pokemonDetailsFixture.toEntity()',
      );
      assert(
        response.$2 == exception,
        'response error should be AppException(message: error)',
      );
    });

    test(
        'should return exception when is offline and local data source is '
        'empty', () async {
      //arrange
      const pokemonName = 'bulbasaur';
      const exception = AppException(message: 'error');
      when(() => mockPokemonRemoteDataSource.fetchPokemonDetails(pokemonName))
          .thenAnswer((_) async => (null, exception));
      when(
        () => mockPokemonLocalDataSource.getPokemonDetailsModel(
          pokemonName,
        ),
      ).thenAnswer((_) async => Future.value());

      //act
      final response =
          await pokemonRepositoryImpl.fetchPokemonDetails(pokemonName);

      //assert
      assert(
        response.$1 == null,
        'response null as pokemonDetails',
      );
      assert(
        response.$2 == exception,
        'response error should be AppException(message: error)',
      );
    });
  });
}

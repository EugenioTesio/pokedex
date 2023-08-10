import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/data/datasources/local_data_source.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
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
        () => [
          mockPokemonLocalDataSource.putPokemonDetailsModel(
            pokemonName,
            pokemonDetailsModelFixture,
          ),
          mockPokemonRemoteDataSource.fetchPokemonDetails(pokemonName),
        ],
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

  group('fetchPokemons', () {
    test('should return remote data source when is online', () async {
      //arrange
      const limit = 20;
      const offset = 0;
      //* assume the data not coming from local data source
      when(
        () => mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
      ).thenAnswer((_) async => false);
      //* fetch the pokemons from the remote data source
      when(
        () => mockPokemonRemoteDataSource.fetchPokemons(
          limit: limit,
          offset: offset,
        ),
      ).thenAnswer((_) async => (pokemonTreeItemsListModelFixture, null));
      //* as the offset is 0, we clear the local data source
      when(
        () => mockPokemonLocalDataSource.clearPokemonListModel(),
      ).thenAnswer((_) async => Future.value());
      //* set the coming from database flag to false
      when(
        () => mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: false),
      ).thenAnswer((_) async => Future.value());
      //* add the pokemons to the local data source
      when(
        () => mockPokemonLocalDataSource
            .addPokemonListModel(pokemonTreeItemsListModelFixture),
      ).thenAnswer((_) async => Future.value());
      //* close the local data source
      when(
        () => mockPokemonLocalDataSource.closeAll(),
      ).thenAnswer((_) async => Future.value());

      //act
      final response = await pokemonRepositoryImpl.fetchPokemons(
        limit: limit,
      );

      //assert
      verify(
        () => [
          mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
          mockPokemonRemoteDataSource.fetchPokemons(
            limit: limit,
            offset: offset,
          ),
          mockPokemonLocalDataSource.clearPokemonListModel(),
          mockPokemonLocalDataSource
              .addPokemonListModel(pokemonTreeItemsListModelFixture),
          mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: false),
          mockPokemonLocalDataSource.closeAll(),
        ],
      );

      assert(
        response.$1 == pokemonTreeItemsListModelFixture.toEntity(),
        'response should be pokemonTreeItemsListModelFixture.toEntity()',
      );
      assert(
        response.$2 == null,
        'response error should be null',
      );
    });

    test(
        'should return local data source when is offline and the database is '
        'not empty', () async {
      //arrange
      const limit = 20;
      const offset = 0;
      const exception = AppException(message: 'error');
      //* assume the data not coming from local data source
      when(
        () => mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
      ).thenAnswer((_) async => false);
      //* return an error when attemping to fetch the pokemons from
      //* the remote data source
      when(
        () => mockPokemonRemoteDataSource.fetchPokemons(
          limit: limit,
          offset: offset,
        ),
      ).thenAnswer((_) async => (null, exception));

      //* fetch the pokemons from the local data source
      when(
        () => mockPokemonLocalDataSource.getAllPokemonListModel(),
      ).thenAnswer((_) async => [pokemonTreeItemsListModelFixture]);
      //* set the coming from database flag to false
      when(
        () => mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: true),
      ).thenAnswer((_) async => Future.value());
      //* close the local data source
      when(
        () => mockPokemonLocalDataSource.closeAll(),
      ).thenAnswer((_) async => Future.value());

      //act
      final response = await pokemonRepositoryImpl.fetchPokemons(
        limit: limit,
      );

      //assert
      verify(
        () => [
          mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
          mockPokemonRemoteDataSource.fetchPokemons(
            limit: limit,
            offset: offset,
          ),
          mockPokemonLocalDataSource.getAllPokemonListModel(),
          mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: true),
          mockPokemonLocalDataSource.closeAll(),
        ],
      );

      assert(
        response.$1 ==
            PokemonListModel(
              count: 1,
              results: pokemonTreeItemsListModelFixture.results,
            ).toEntity(),
        'response should be pokemonTreeItemsListModelFixture.toEntity()',
      );
      assert(
        response.$2 == exception,
        'response error should be null',
      );
    });

    test(
        'should return exception when is offline and local data source is '
        'empty', () async {
      //arrange
      const limit = 20;
      const offset = 0;
      const exception = AppException(message: 'error');
      //* assume the data not coming from local data source
      when(
        () => mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
      ).thenAnswer((_) async => false);
      //* return an error when attemping to fetch the pokemons from
      //* the remote data source
      when(
        () => mockPokemonRemoteDataSource.fetchPokemons(
          limit: limit,
          offset: offset,
        ),
      ).thenAnswer((_) async => (null, exception));

      //* as the offset is 0, we clear the local data source
      when(
        () => mockPokemonLocalDataSource.getAllPokemonListModel(),
      ).thenAnswer((_) async => []);
      //* set the coming from database flag to false
      when(
        () => mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: true),
      ).thenAnswer((_) async => Future.value());
      //* close the local data source
      when(
        () => mockPokemonLocalDataSource.closeAll(),
      ).thenAnswer((_) async => Future.value());

      //act
      final response = await pokemonRepositoryImpl.fetchPokemons(
        limit: limit,
      );

      //assert
      verify(
        () => [
          mockPokemonLocalDataSource.getComingFromDatabaseFlag(),
          mockPokemonRemoteDataSource.fetchPokemons(
            limit: limit,
            offset: offset,
          ),
          mockPokemonLocalDataSource.getAllPokemonListModel(),
          mockPokemonLocalDataSource.setComingFromDatabaseFlag(flag: true),
          mockPokemonLocalDataSource.closeAll(),
        ],
      );

      assert(
        response.$1 ==
            PokemonListModel(
              count: 0,
              results: [],
            ).toEntity(),
        'response should be an empty results pokemon list model',
      );
      assert(
        response.$2 == exception,
        'response error should be null',
      );
    });
  });
}

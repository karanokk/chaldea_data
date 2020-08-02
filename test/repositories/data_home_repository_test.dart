import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:chaldea_domain/entities/home.dart';

import 'package:chaldea_data/src/entities/home_entity.dart';
import 'package:chaldea_data/src/repositories/data_home_repository.dart';
import 'package:chaldea_data/src/repositories/datasources/home_local_data_source.dart';
import 'package:chaldea_data/src/repositories/datasources/home_mooncell_data_source.dart';

void main() {
  group('DataHomeRepository', () {
    MockHomeLocalDataSource mockLocalDataSource;
    MockHomeMooncellDataSource mockMooncellDataSource;
    MockHomeEntity mockHomeEntity;
    MockHome mockCNHome;
    MockHome mockJPHome;

    DataHomeRepository dataHomeRepo;

    setUp(() {
      mockLocalDataSource = MockHomeLocalDataSource();
      mockMooncellDataSource = MockHomeMooncellDataSource();
      mockHomeEntity = MockHomeEntity();
      mockCNHome = MockHome();
      mockJPHome = MockHome();
      dataHomeRepo =
          DataHomeRepository(mockLocalDataSource, mockMooncellDataSource);

      when(mockHomeEntity.toCNDomain()).thenReturn(mockCNHome);
      when(mockHomeEntity.toJPDomain()).thenReturn(mockJPHome);
    });

    test('cnHome without local cache', () async {
      when(mockLocalDataSource.getHome()).thenAnswer((_) async => null);
      when(mockMooncellDataSource.getHome())
          .thenAnswer((_) async => mockHomeEntity);

      final cnHome1 = await dataHomeRepo.cnHome();

      verify(mockLocalDataSource.getHome()).called(1);
      verify(mockMooncellDataSource.getHome()).called(1);
      expect(cnHome1, mockCNHome);

      // read memory cache.
      final cnHome2 = await dataHomeRepo.cnHome();

      verifyNever(mockLocalDataSource.getHome());
      verifyNever(mockMooncellDataSource.getHome());
      expect(cnHome2, mockCNHome);
    });

    test('cnHome with local cache', () async {
      when(mockLocalDataSource.getHome())
          .thenAnswer((_) async => mockHomeEntity);
      when(mockMooncellDataSource.getHome())
          .thenAnswer((_) async => mockHomeEntity);

      final cnHome1 = await dataHomeRepo.cnHome();

      verify(mockLocalDataSource.getHome()).called(1);
      verifyNever(mockMooncellDataSource.getHome());
      expect(cnHome1, mockCNHome);

      // read memory cache.
      final cnHome2 = await dataHomeRepo.cnHome();

      verifyNever(mockLocalDataSource.getHome());
      verifyNever(mockMooncellDataSource.getHome());
      expect(cnHome2, mockCNHome);

      dataHomeRepo.setNeedsUpdate();

      // fetch remote data.
      final cnHome3 = await dataHomeRepo.cnHome();

      verifyNever(mockLocalDataSource.getHome());
      verify(mockMooncellDataSource.getHome()).called(1);
      expect(cnHome3, mockCNHome);
    });
    test('jpHome', () async {
      when(mockLocalDataSource.getHome())
          .thenAnswer((_) async => mockHomeEntity);
      final jpHome = await dataHomeRepo.jpHome();
      expect(jpHome, mockJPHome);
    });
  });
}

class MockHomeLocalDataSource extends Mock implements HomeLocalDataSource {}

class MockHomeMooncellDataSource extends Mock
    implements HomeMooncellDataSource {}

class MockHomeEntity extends Mock implements HomeEntity {}

class MockHome extends Mock implements Home {}

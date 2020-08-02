import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

import 'package:chaldea_data/src/repositories/datasources/home_mooncell_data_source.dart';
import 'package:chaldea_data/src/entities/home_entity.dart';

void main() {
  group('HomeMooncellDataSource', () {
    test('online', () async {
      final dataSource = HomeMooncellDataSource();
      expect(await dataSource.getHome(), isNotNull);
    });

    test('saveHome()', () async {
      final dataSource = HomeMooncellDataSource();
      try {
        await dataSource.saveHome(MockHomeEntity());
      } catch (e) {
        expect(e, TypeMatcher<UnimplementedError>());
      }
    });
  });
}

class MockHomeEntity extends Mock implements HomeEntity {}

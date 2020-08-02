import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:chaldea_data/src/entities/home_entity.dart';
import 'package:chaldea_data/src/repositories/datasources/home_local_data_source.dart';

void main() {
  group('HomeLocalDataSource', () {
    test('with no cache', () async {
      SharedPreferences.setMockInitialValues({});
      final dataSource = HomeLocalDataSource();
      expect(await dataSource.getHome(), null);
    });

    test('with cache', () async {
      SharedPreferences.setMockInitialValues({HOME_ENTITY_KEY: '{}'});
      final dataSource = HomeLocalDataSource();
      expect(await dataSource.getHome(), isNotNull);
    });

    test('saveHome()', () async {
      SharedPreferences.setMockInitialValues({});
      final dataSource = HomeLocalDataSource();
      final entity = MockHomeEntity();
      final testJson = {'TESTKEY': 'TESTVALUE'};
      when(entity.toJson()).thenReturn(testJson);
      await dataSource.saveHome(entity);
      final sp = await SharedPreferences.getInstance();
      expect(sp.getString(HOME_ENTITY_KEY), jsonEncode(testJson));
    });
  });
}

const HOME_ENTITY_KEY = 'HOME_ENTITY_KEY';

class MockHomeEntity extends Mock implements HomeEntity {}

import 'dart:convert';

import '../../entities/home_entity.dart';
import 'home_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLocalDataSource implements IHomeDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<HomeEntity> getHome() {
    return _prefs.then((SharedPreferences prefs) {
      final homeString = prefs.getString(_HOME_ENTITY_KEY);
      if (homeString == null) {
        return null;
      }
      return HomeEntity.fromJson(jsonDecode(homeString));
    });
  }

  @override
  Future<void> saveHome(HomeEntity homeEntity) {
    return _prefs.then((SharedPreferences prefs) {
      prefs.setString(_HOME_ENTITY_KEY, json.encode(homeEntity.toJson()));
    });
  }
}

const _HOME_ENTITY_KEY = 'HOME_ENTITY_KEY';

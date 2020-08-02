import 'dart:async';

import '../../entities/home_entity.dart';

abstract class IHomeDataSource {
  Future<HomeEntity> getHome();
  Future<void> saveHome(HomeEntity homeEntity);
}

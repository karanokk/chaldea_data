import 'package:chaldea_data/src/entities/home_entity.dart';
import 'package:chaldea_domain/entities/home.dart';
import 'package:chaldea_domain/repository_interfaces/home_repository.dart';

import 'datasources/home_data_source.dart';

class DataHomeRepository implements IHomeRepository {
  final IHomeDataSource localHomeDataSource;
  final IHomeDataSource remoteHomeDataSource;

  HomeEntity _cachedHomeEntity;

  bool _cacheIsDirty = false;

  DataHomeRepository(this.localHomeDataSource, this.remoteHomeDataSource);

  @override
  Future<Home> cnHome() =>
      getHomeEntity().then((entity) => entity.toCNDomain());

  @override
  Future<Home> jpHome() =>
      getHomeEntity().then((entity) => entity.toJPDomain());

  Future<HomeEntity> getHomeEntity() async {
    if (_cachedHomeEntity != null && !_cacheIsDirty) {
      return _cachedHomeEntity;
    }

    HomeEntity homeEntity;
    if (_cacheIsDirty) {
      homeEntity = await remoteHomeDataSource.getHome();
    } else {
      homeEntity = await localHomeDataSource.getHome();
    }

    homeEntity ??= await remoteHomeDataSource.getHome();

    _cachedHomeEntity = homeEntity;
    _cacheIsDirty = false;
    return homeEntity;
  }

  @override
  void setNeedsUpdate() => _cacheIsDirty = true;
}

import 'package:http/http.dart' as http;

import '../../entities/home_entity.dart';
import '../../utils/constants.dart';
import 'home_data_source.dart';

class HomeMooncellDataSource implements IHomeDataSource {
  @override
  Future<HomeEntity> getHome() async {
    final response = await http.get(MOONCELL_HOME);
    if (response.statusCode != 200) {}
    return HomeEntity.fromHTML(response.body);
  }

  @override
  Future<void> saveHome(HomeEntity homeEntity) {
    throw UnimplementedError('This method should not be called');
  }
}

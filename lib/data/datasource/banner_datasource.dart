import 'package:dio/dio.dart';
import 'package:shop_app/data/model/banner.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class IBanerDatasource {
  Future<List<BannerCampain>> getBanners();
}

class BannerRemoteDatasource extends IBanerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampain>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data['items']
          .map<BannerCampain>(
              (jsonObject) => BannerCampain.fromMapjson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}

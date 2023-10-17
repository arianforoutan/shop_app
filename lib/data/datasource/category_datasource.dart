import 'package:dio/dio.dart';
import 'package:shop_app/data/model/category.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class ICategoryDatasource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDatasource extends ICategoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio
          .get('http://startflutter.ir/api/collections/category/records');

      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:shop_app/data/model/product.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class ICategoryProductDatasoource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasoource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'category= "$categoryId"',
      };
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get(
          'collections/products/records',
        );
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qparams);
      }

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      print(e.response!.statusCode);
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}

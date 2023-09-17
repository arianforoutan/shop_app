import 'package:dio/dio.dart';
import 'package:shop_app/data/model/product.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
}

class ProductRemoteDataSource extends IProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');

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

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qparams = {
        'filter': 'popularity= "Best Seller"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qparams);

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

  @override
  Future<List<Product>> getHotest() async {
    try {
      Map<String, String> qparams = {
        'filter': 'popularity= "Hotest"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qparams);

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

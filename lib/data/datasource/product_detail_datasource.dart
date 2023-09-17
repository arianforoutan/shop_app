import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_peroperty.dart';
import 'package:shop_app/data/model/product_variant.dart';
import 'package:shop_app/data/model/variant_type.dart';
import 'package:shop_app/di/di.dart';

import '../../util/api_exception.dart';
import '../model/variant.dart';

abstract class IDetailProductRemoteDatasource {
  Future<List<ProductImage>> getGallery(String producId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariant(String producId);
  Future<List<ProductVariant>> getProductVariant(String producId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<ProductProperty>> getProductProperties(String producId);

  getProductByCategoryId() {}
}

class DetailProductDatasource extends IDetailProductRemoteDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String producId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'product_id= "$producId"',
      };
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qparams);

      return response.data['items']
          .map<ProductImage>(
              (jsonObject) => ProductImage.fromMapJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get(
        'collections/variants_type/records',
      );

      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromjson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Variant>> getVariant(String producId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'product_id= "$producId"',
      };
      var response = await _dio.get('collections/variants/records',
          queryParameters: qparams);

      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(
        0,
        'unknown error',
      );
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariant(String producId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariant(producId);

    List<ProductVariant> productvariantlist = [];
    try {
      for (var variantType in variantTypeList) {
        var variantlist = variantList.where((element) {
          return element.typeId == variantType.id;
        }).toList();

        productvariantlist.add(ProductVariant(variantType, variantlist));
      }
      return productvariantlist;
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(
        0,
        'unknown error',
      );
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'id= "$categoryId"',
      };
      var response = await _dio.get('collections/category/records',
          queryParameters: qparams);
      return Category.fromMapJson(response.data['items'][0]);
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(
        0,
        'unknown error',
      );
    }
  }

  @override
  Future<List<ProductProperty>> getProductProperties(String producId) async {
    try {
      Map<String, String> qparams = {
        'filter': 'product_id= "$producId"',
      };
      var response = await _dio.get('collections/properties/records',
          queryParameters: qparams);
      return response.data['items']
          .map<ProductProperty>(
              (jsonObject) => ProductProperty.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (e) {
      throw ApiException(
        0,
        'unknown error',
      );
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/product_detail_datasource.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_peroperty.dart';
import 'package:shop_app/data/model/product_variant.dart';

import 'package:shop_app/data/model/variant_type.dart';
import 'package:shop_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String producId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String producId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
  Future<Either<String, List<ProductProperty>>> getProductProperties(
      String producId);
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductRemoteDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getProductImage(
      String producId) async {
    try {
      var response = await _datasource.getGallery(producId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String producId) async {
    try {
      var response = await _datasource.getProductVariant(producId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductProperty>>> getProductProperties(
      String producId) async {
    try {
      var response = await _datasource.getProductProperties(producId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}

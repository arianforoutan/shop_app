import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/category_product.dart';
import 'package:shop_app/data/model/product.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDatasoource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId) async {
    try {
      var response = await _datasource.getProductByCategoryId(categoryId);

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}

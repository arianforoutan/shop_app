import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/util/api_exception.dart';

import '../datasource/category_datasource.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}

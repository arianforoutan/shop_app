import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/banner_datasource.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/di/di.dart';

import '../../util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampain>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBanerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<BannerCampain>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}

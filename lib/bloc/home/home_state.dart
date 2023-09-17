import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerCampain>> bannerList;
  Either<String, List<Product>> hotestProductlist;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> bestsellerProductlist;

  HomeRequestSuccessState(this.bannerList, this.categoryList, this.productList,
      this.bestsellerProductlist, this.hotestProductlist);
}

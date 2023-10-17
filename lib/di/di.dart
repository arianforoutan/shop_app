import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/basketitem/basket_bloc.dart';
import 'package:shop_app/data/datasource/banner_datasource.dart';
import 'package:shop_app/data/datasource/basketitem_datasource.dart';
import 'package:shop_app/data/datasource/category_datasource.dart';
import 'package:shop_app/data/datasource/category_product.dart';
import 'package:shop_app/data/datasource/comment_datasource.dart';
import 'package:shop_app/data/datasource/product_datasource.dart';
import 'package:shop_app/data/datasource/product_detail_datasource.dart';
import 'package:shop_app/data/repository/banner_repository.dart';
import 'package:shop_app/data/repository/basketItem_repository.dart';
import 'package:shop_app/data/repository/category_repository.dart';
import 'package:shop_app/data/repository/comment_repository.dart';
import 'package:shop_app/data/repository/product_detail_repository.dart';
import 'package:shop_app/data/repository/product_repository.dart';

import '../data/datasource/authentication_datasource.dart';
import '../data/repository/authentication_repository.dart';
import '../data/repository/category_Product_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componenets
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //datasources

  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBanerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDataSource());
  locator.registerFactory<IDetailProductRemoteDatasource>(
      () => DetailProductDatasource());
  locator.registerFactory<ICategoryProductDatasoource>(
      () => CategoryProductRemoteDatasource());
  locator.registerFactory<IBasketItemDataSource>(
      () => BasketItemLocalDataSource());
  locator.registerFactory<ICommentDataSource>(() => CommentRemoteDatasource());

  //repositories

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<IBasketItemRepository>(() => BasketItemRepository());
  locator.registerFactory<ICommentRepository>(() => CommentRepository());

  //bloc
  locator.registerSingleton<BasketBloc>(BasketBloc());
}

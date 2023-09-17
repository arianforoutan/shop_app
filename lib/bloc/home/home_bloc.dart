import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/data/repository/banner_repository.dart';
import 'package:shop_app/data/repository/category_repository.dart';
import 'package:shop_app/data/repository/product_repository.dart';
import 'package:shop_app/di/di.dart';

class HomeBloc extends Bloc<Homeevent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final IProductRepository _productRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitilzeData>((event, emit) async {
      emit(HomeLoadingState());

      var bannerList = await _bannerRepository.getBanners();
      var hotestProductlist = await _productRepository.getHotest();

      var bestsellerProductlist = await _productRepository.getBestSeller();
      var categoryList = await _categoryRepository.getCategories();
      var productList = await _productRepository.getProducts();
      emit(HomeRequestSuccessState(bannerList, categoryList, productList,
          bestsellerProductlist, hotestProductlist));
    });
  }
}

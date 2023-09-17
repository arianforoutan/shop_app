import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/product.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseSuccessState extends CategoryProductState {
  Either<String, List<Product>> productListBycategory;

  CategoryProductResponseSuccessState(this.productListBycategory);
}

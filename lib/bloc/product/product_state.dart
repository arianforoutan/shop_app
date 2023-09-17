import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_peroperty.dart';
import 'package:shop_app/data/model/product_variant.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<ProductProperty>> productproperty;

  ProductDetailResponseState(this.productImages, this.productVariant,
      this.productCategory, this.productproperty);
}

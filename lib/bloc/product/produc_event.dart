import 'package:shop_app/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String producId;
  String categoryId;

  ProductInitializeEvent(this.producId, this.categoryId);
}

class ProductAddToBasket extends ProductEvent {
  Product product;
  ProductAddToBasket(this.product);
}

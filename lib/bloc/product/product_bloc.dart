import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/product/produc_event.dart';
import 'package:shop_app/bloc/product/product_state.dart';
import 'package:shop_app/data/repository/basketItem_repository.dart';

import '../../data/model/basket_item.dart';
import '../../data/repository/product_detail_repository.dart';
import '../../di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IBasketItemRepository _basketItemRepository = locator.get();
  final IDetailProductRepository _productRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      var response = await _productRepository.getProductImage(event.producId);
      var productVariant =
          await _productRepository.getProductVariants(event.producId);
      var productCategory =
          await _productRepository.getProductCategory(event.categoryId);
      var productproperty =
          await _productRepository.getProductProperties(event.producId);
      emit(ProductDetailResponseState(
          response, productVariant, productCategory, productproperty));
    });

    on<ProductAddToBasket>((event, emit) {
      var basketItem = BasketItem(
          event.product.id,
          event.product.collectionId,
          event.product.thumbnail,
          event.product.discountPrice,
          event.product.price,
          event.product.name,
          event.product.categoryId);

      _basketItemRepository.addProducttoBasket(basketItem);
    });
  }
}

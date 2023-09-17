import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/basketitem_datasource.dart';
import 'package:shop_app/data/model/basket_item.dart';

import '../../di/di.dart';

abstract class IBasketItemRepository {
  Future<Either<String, String>> addProducttoBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
}

class BasketItemRepository extends IBasketItemRepository {
  final IBasketItemDataSource _datasource = locator.get();
  @override
  Future<Either<String, String>> addProducttoBasket(
      BasketItem basketItem) async {
    try {
      await _datasource.addProduct(basketItem);

      return right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return left("خطا خطا در افزودن محصول");
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItem() async {
    try {
      var basketItemlist = await _datasource.getAllBasketItem();
      return right(basketItemlist);
    } catch (e) {
      return left("خطا خطا در افزودن محصول");
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _datasource.getBasketFinalPrice();
  }
}

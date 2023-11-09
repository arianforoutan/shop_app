import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/data/model/basket_item.dart';

abstract class IBasketItemDataSource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  Future<void> removeProduct(int index);

  Future<int> getBasketFinalPrice();
}

class BasketItemLocalDataSource extends IBasketItemDataSource {
  var box = Hive.box<BasketItem>('CardBox');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    await box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productlist = box.values.toList();
    var finalPraice = productlist.fold(
        0, (accumulator, product) => accumulator + product.realprice!);
    return finalPraice;
  }

  @override
  Future<void> removeProduct(int index) async {
    await box.deleteAt(index);
  }
}

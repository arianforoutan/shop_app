import 'package:dartz/dartz.dart';
import 'package:shop_app/data/model/basket_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  int basketfinailPrice;
  BasketDataFetchState(this.basketItemList, this.basketfinailPrice);
}

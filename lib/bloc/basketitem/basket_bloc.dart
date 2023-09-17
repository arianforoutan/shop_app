import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/basketitem/basket_event.dart';
import 'package:shop_app/bloc/basketitem/basket_state.dart';
import 'package:shop_app/data/repository/basketItem_repository.dart';
import 'package:shop_app/di/di.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketItemRepository _basketItemRepository = locator.get();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchfromHiveEvent>((event, emit) async {
      var basketitemlist = await _basketItemRepository.getAllBasketItem();
      var basketItemfinalprice =
          await _basketItemRepository.getBasketFinalPrice();
      emit(BasketDataFetchState(basketitemlist, basketItemfinalprice));
    });
  }
}

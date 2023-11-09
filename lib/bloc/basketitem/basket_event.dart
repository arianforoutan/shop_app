abstract class BasketEvent {}

class BasketFetchfromHiveEvent extends BasketEvent {}

class BasketRemoveProductEvent extends BasketEvent {
  int index;

  BasketRemoveProductEvent(this.index);
}

import 'package:hive/hive.dart';
part 'basket_item.g.dart';

@HiveType(typeId: 0)
class BasketItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  String categoryId;
  @HiveField(7)
  int? realprice;
  @HiveField(8)
  num? persent;

  BasketItem(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.name,
    this.categoryId,
  ) {
    realprice = price + discountPrice;
    persent = ((price - realprice!) / price) * 100;
    // this.thumbnail= 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/product/product_bloc.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/di/di.dart';
import 'package:shop_app/widgets/cached_image.dart';

import '../bloc/basketitem/basket_bloc.dart';
import '../constants/colors.dart';
import '../screens/product_detail_screen.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: CustomColors.backgraoundscreencolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                        height: 98,
                        width: 98,
                        child: Cachedimage(
                          imageUrl: product.thumbnail,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child:
                            Image.asset('assets/images/active_fav_product.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          height: 15,
                          width: 25,
                          decoration: BoxDecoration(
                            color: CustomColors.red,
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(
                              '%${product.persent!.round().toString()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10, right: 10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'SM', fontSize: 14),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Container(
              height: 53,
              decoration: const BoxDecoration(
                color: CustomColors.blueIndicator,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                      color: CustomColors.blueIndicator,
                      spreadRadius: -10,
                      blurRadius: 22,
                      offset: Offset(0, 9))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                        fontFamily: 'SM', fontSize: 12, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      Text(
                        product.realprice.toString(),
                        style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/icon_right_arrow_cricle.png',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

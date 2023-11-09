import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/bloc/basketitem/basket_bloc.dart';
import 'package:shop_app/bloc/basketitem/basket_event.dart';
import 'package:shop_app/bloc/basketitem/basket_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/util/extentions/String_extentions.dart';
import 'package:shop_app/util/extentions/double_extention.dart';
import 'package:shop_app/widgets/cached_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

import '../data/model/basket_item.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  PaymentRequest _paymentRequest = PaymentRequest();

  @override
  void initState() {
    super.initState();
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('for test app');
    //set your merchantID
    _paymentRequest.setMerchantID('merchantID');
    _paymentRequest.setCallbackURL('technotpia://shop');
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('CardBox');

    return Scaffold(
      backgroundColor: CustomColors.backgraoundscreencolor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 44, right: 44, top: 10, bottom: 32),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'سبد خرید',
                                        style: TextStyle(
                                            fontFamily: 'SB',
                                            fontSize: 16,
                                            color: CustomColors.blueIndicator),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                          'assets/images/icon_apple_blue.png'),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchState) ...{
                      state.basketItemList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Text(l),
                          );
                        },
                        (basketitemlist) {
                          return SliverList(
                              delegate:
                                  SliverChildBuilderDelegate(((context, index) {
                            return CardItem(basketitemlist[index], index);
                          }), childCount: basketitemlist.length));
                        },
                      )
                    },
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 65),
                    ),
                  ],
                ),
                if (state is BasketDataFetchState) ...{
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44, vertical: 20),
                    child: SizedBox(
                      height: 53,
                      width: MediaQuery.of(context).size.width,
                      child: Positioned(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: (() {
                            ZarinPal().startPayment(_paymentRequest,
                                (status, paymentGatewayUri) {
                              if (state == 100) {
                                launchUrl(Uri.parse(paymentGatewayUri!),
                                    mode: LaunchMode.externalApplication);
                              } else {}
                            });
                          }),
                          child: Text(
                            (state.basketfinailPrice == 0)
                                ? 'سبد خرید خالی است'
                                : state.basketfinailPrice.FormatPrice(),
                            style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final BasketItem basketItem;
  final int index;
  const CardItem(
    this.basketItem,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 44, left: 44, bottom: 20),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          basketItem.name,
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'گارانتی 18 ماهه مدیاپردازش',
                          style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                              color: CustomColors.gray),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColors.red,
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 3),
                                child: Row(
                                  children: [
                                    Text(
                                      '%',
                                      style: TextStyle(
                                          fontFamily: 'SB',
                                          fontSize: 10,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      basketItem.persent!
                                          .roundToDouble()
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'SM',
                                          fontSize: 10,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              basketItem.price.FormatPrice(),
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            OptionCheap(
                              'تومان',
                              color: '4387f5',
                            ),
                            OptionCheap('تومان', color: '4287f5'),
                            OptionCheap('تومان', color: '4287f5'),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<BasketBloc>()
                                    .add(BasketRemoveProductEvent(index));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: CustomColors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'حذف',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: CustomColors.red,
                                          fontFamily: 'SM',
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Image.asset(
                                        'assets/images/icon_trash.png',
                                        color: CustomColors.red,
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      height: 105,
                      width: 100,
                      child: Cachedimage(
                        imageUrl: basketItem.thumbnail,
                      ),
                    ))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              dashRadius: 5,
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColors.lightgray,
              dashGapLength: 3.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  basketItem.realprice.FormatPrice(),
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String? color;
  String title;
  OptionCheap(
    this.title, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: CustomColors.backgraoundscreencolor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                margin: EdgeInsets.only(right: 6),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parstoColor(),
                ),
              )
            },
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

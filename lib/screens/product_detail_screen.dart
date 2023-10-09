import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/bloc/basketitem/basket_bloc.dart';
import 'package:shop_app/bloc/basketitem/basket_event.dart';
import 'package:shop_app/bloc/product/produc_event.dart';
import 'package:shop_app/bloc/product/product_bloc.dart';
import 'package:shop_app/bloc/product/product_state.dart';
import 'package:shop_app/constants/colors.dart';

import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/data/model/product_image.dart';
import 'package:shop_app/data/model/product_variant.dart';
import 'package:shop_app/data/model/variant_type.dart';
import 'package:shop_app/util/extentions/double_extention.dart';

import 'package:shop_app/widgets/cached_image.dart';

import '../data/model/product_peroperty.dart';
import '../data/model/variant.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  Product product;

  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) {
        var bloc = ProductBloc();
        bloc.add(ProductInitializeEvent(
            widget.product.id, widget.product.categoryId));
        return bloc;
      }),
      child: DetailContentWidget(
        parentWidget: widget,
      ),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  const DetailContentWidget({
    Key? key,
    required this.parentWidget,
  }) : super(key: key);

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgraoundscreencolor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: ((context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 44, right: 44, bottom: 32),
                      child: Container(
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Image.asset('assets/images/icon_apple_blue.png'),
                            Expanded(
                                child: state.productCategory.fold((l) {
                              return const Text(
                                'اطلاعات محصول',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 16,
                                    color: CustomColors.blueIndicator),
                              );
                            }, (productCategory) {
                              return Text(
                                productCategory.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'sb',
                                    fontSize: 16,
                                    color: CustomColors.blueIndicator),
                              );
                            })),
                            Image.asset('assets/images/icon_back.png'),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailResponseState) ...{
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productImageList) {
                    return Gallerywidget(
                        parentWidget.product.thumbnail, productImageList);
                  })
                },
                if (state is ProductDetailResponseState) ...{
                  state.productVariant.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productVariantList) {
                    return VariantContainerGenerator(productVariantList);
                  }),
                },
                if (state is ProductDetailResponseState) ...{
                  state.productproperty.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (propertyList) {
                    return ProductProperties(propertyList);
                  })
                },
                if (state is ProductDetailResponseState) ...{
                  ProductDescription(parentWidget.product.description)
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 24, left: 44, right: 44),
                        height: 46,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1, color: CustomColors.gray),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset('assets/images/icon_left_categroy.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 12,
                                  color: CustomColors.blueIndicator),
                            ),
                            const Spacer(),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 26,
                                  width: 26,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 45,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 60,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 26,
                                    width: 26,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      '+10',
                                      style: TextStyle(
                                          fontFamily: 'sb',
                                          fontSize: 12,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              ': نظرات کاربران',
                              style: TextStyle(fontFamily: 'sm'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 36, left: 36, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceTagButton(parentWidget.product),
                          AddToBasketButton(parentWidget.product),
                        ],
                      ),
                    ),
                  )
                }
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product product;
  AddToBasketButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: const BoxDecoration(
                color: CustomColors.blueIndicator,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  context.read<ProductBloc>().add(ProductAddToBasket(product));
                  context.read<BasketBloc>().add(BasketFetchfromHiveEvent());
                },
                child: Container(
                  height: 53,
                  width: 160,
                  child: const Center(
                    child: Text(
                      'افزودن سبد خرید',
                      style: TextStyle(
                          fontFamily: 'sb', fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  Product product;
  PriceTagButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          child: Container(
            height: 60,
            width: 140,
            decoration: const BoxDecoration(
                color: CustomColors.green,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 53,
                width: 160,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'تومان',
                        style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price.FormatPrice(),
                            style: const TextStyle(
                                fontFamily: 'sm',
                                fontSize: 11,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            product.realprice.FormatPrice(),
                            style: const TextStyle(
                              fontFamily: 'sm',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          child: Row(
                            children: [
                              Text(
                                '%',
                                style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 8,
                                    color: Colors.white),
                              ),
                              Text(
                                product.persent!.roundToDouble().toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 8,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProductProperties extends StatefulWidget {
  List<ProductProperty> productperoperty;
  ProductProperties(
    this.productperoperty, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 10),
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: CustomColors.gray),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_left_categroy.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 14,
                              color: CustomColors.blueIndicator),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ':مشخصات فنی',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: CustomColors.gray),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productperoperty.length,
                    itemBuilder: (context, index) {
                      var property = widget.productperoperty[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                '${property.title!}: ${property.value!}',
                                style: const TextStyle(
                                  height: 2,
                                  fontFamily: 'SB',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
        ),
      ],
    ));
  }
}

class ProductDescription extends StatefulWidget {
  String productDescription;
  ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: CustomColors.gray),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_left_categroy.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 14,
                              color: CustomColors.blueIndicator),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ':توضیحات محصول',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: CustomColors.gray),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.productDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 2,
                      fontFamily: 'SB',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productvariantlist;

  VariantContainerGenerator(
    this.productvariantlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productvariantlist) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant)
            }
          }
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  ProductVariant productVariant;
  VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, left: 44, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variantList),
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(productVariant.variantList)
          }
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Gallerywidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String? defaultProductThumnail;

  Gallerywidget(
    this.defaultProductThumnail,
    this.productImageList, {
    super.key,
  });

  @override
  State<Gallerywidget> createState() => _GallerywidgetState();
}

class _GallerywidgetState extends State<Gallerywidget> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/icon_star.png'),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text(
                                '4.5',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                              'assets/images/icon_favorite_deactive.png'),
                        ],
                      ),
                      Positioned(
                        top: 5,
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Cachedimage(
                              fit: BoxFit.fill,
                              imageUrl: (widget.productImageList.isEmpty)
                                  ? widget.defaultProductThumnail
                                  : widget
                                      .productImageList[selectedItem].imageUrl),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productImageList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedItem = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: CustomColors.gray),
                              ),
                              child: Cachedimage(
                                imageUrl:
                                    widget.productImageList[index].imageUrl,
                                radius: 10,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 28,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String variantcolor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(variantcolor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 15),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  border: (_selectedIndex == index)
                      ? Border.all(
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 4,
                          color: Color(hexColor))
                      : Border.all(width: 0, color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  padding: EdgeInsets.all(2),
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    border: (_selectedIndex == index)
                        ? Border.all(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            width: 4,
                            color: Colors.white)
                        : Border.all(width: 0, color: Colors.white),
                    color: Color(hexColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storagevariantList;
  StorageVariantList(this.storagevariantList, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storagevariantList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 26,
                width: 74,
                decoration: BoxDecoration(
                    border: (_selectedIndex == index)
                        ? Border.all(
                            width: 3, color: CustomColors.blueIndicator)
                        : Border.all(width: 1, color: CustomColors.gray),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    widget.storagevariantList[index].value!,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

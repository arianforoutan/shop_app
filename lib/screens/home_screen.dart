import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/data/model/banner.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/data/model/product.dart';
import 'package:shop_app/widgets/loadingAnimation.dart';

import '../constants/colors.dart';

import '../widgets/ProductItem.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgraoundscreencolor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return _getHomeScreenContent(state, context);
        }),
      ),
    );
  }
}

Widget _getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return const Center(
      child: LoadingAnimation(),
    );
  } else if (state is HomeRequestSuccessState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(HomeGetInitilzeData());
      },
      child: CustomScrollView(
        slivers: [
          _getSearchbox(),
          state.bannerList.fold((exeptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exeptionMessage),
            );
          }, (listBanners) {
            return _getbanners(listBanners);
          }),
          _getCategoryListTitle(),
          state.categoryList.fold((exeptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exeptionMessage),
            );
          }, (categorylist) {
            return _getCategoryList(categorylist);
          }),
          const _getBestSellerTitle(),
          state.bestsellerProductlist.fold((exeptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exeptionMessage),
            );
          }, (productList) {
            return _getBestSellerProduct(productList);
          }),
          const _getMostViewedTitle(),
          state.hotestProductlist.fold(
            (exeptionMessage) {
              return SliverToBoxAdapter(child: Text(exeptionMessage));
            },
            (productList) {
              return _getMostViewedProducts(productList);
            },
          ),
        ],
      ),
    );
  } else {
    return const Center(
      child: Text('error'),
    );
  }
}

class _getMostViewedProducts extends StatelessWidget {
  List<Product> productList;
  _getMostViewedProducts(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: SizedBox(
          height: 248,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: ((context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(right: 44, left: 10),
                  child: ProductItem(productList[index]),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ProductItem(productList[index]),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

class _getMostViewedTitle extends StatelessWidget {
  const _getMostViewedTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 15, top: 15),
        child: Row(
          children: [
            const Text(
              "پربازدید ترین ها",
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.gray,
              ),
            ),
            const Spacer(),
            const Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.blueIndicator,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _getBestSellerProduct extends StatelessWidget {
  List<Product> productList;
  _getBestSellerProduct(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 248,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(right: 44, left: 10),
                child: ProductItem(productList[index]),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: ProductItem(productList[index]),
              );
            }
          }),
        ),
      ),
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            const Text(
              "پرفروش ترین ها",
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.gray,
              ),
            ),
            const Spacer(),
            const Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.blueIndicator,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
          ],
        ),
      ),
    );
  }
}

class _getCategoryList extends StatelessWidget {
  List<Category> listCategory;
  _getCategoryList(
    this.listCategory, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCategory.length,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(right: 44, left: 10),
                child: CategoryItemList(listCategory[index]),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: CategoryItemList(listCategory[index]),
              );
            }
          }),
        ),
      ),
    );
  }
}

class _getCategoryListTitle extends StatelessWidget {
  const _getCategoryListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "دسته بندی",
              style: TextStyle(
                fontFamily: 'SB',
                color: CustomColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _getbanners extends StatelessWidget {
  List<BannerCampain> bannerCampain;
  _getbanners(
    this.bannerCampain, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerCampain),
    );
  }
}

class _getSearchbox extends StatelessWidget {
  const _getSearchbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, top: 10, bottom: 32),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'جستجوی محصولات',
                style: TextStyle(
                    fontFamily: 'SM', fontSize: 16, color: CustomColors.gray),
              ),
              const Spacer(),
              Image.asset('assets/images/icon_apple_blue.png'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

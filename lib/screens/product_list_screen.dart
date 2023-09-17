import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/categoryProduct/category_product_event.dart';
import 'package:shop_app/bloc/categoryProduct/category_product_state.dart';
import 'package:shop_app/widgets/ProductItem.dart';

import '../bloc/categoryProduct/category_product_bloc.dart';
import '../constants/colors.dart';
import '../data/model/category.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.backgraoundscreencolor,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 44, right: 44, top: 10),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/images/Group 59.png'),
                          Text(
                            widget.category.title!,
                            style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: CustomColors.blueIndicator),
                          ),
                          Image.asset('assets/images/icon_back.png'),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.productListBycategory.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (productlist) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 32),
                        sliver: SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate(((context, index) {
                            return ProductItem(productlist[index]);
                          }), childCount: productlist.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 2 / 3.3,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
                        ),
                      );
                    },
                  )
                }
              ],
            ),
          ),
        );
      },
    );
  }
}

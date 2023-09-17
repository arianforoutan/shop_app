import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/category/category_bloc.dart';
import 'package:shop_app/bloc/category/category_event.dart';
import 'package:shop_app/bloc/category/category_state.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/data/model/category.dart';

import 'package:shop_app/widgets/cached_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgraoundscreencolor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 44, right: 44, top: 10),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'دسته بندی ',
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
                              Image.asset('assets/images/icon_apple_blue.png'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CategoryResponseState) {
                return state.response.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text(l),
                  );
                }, (r) {
                  return _listCategory(list: r);
                });
              }
              return SliverToBoxAdapter(
                child: Text('error'),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _listCategory extends StatelessWidget {
  List<Category>? list;
  _listCategory({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          return Cachedimage(imageUrl: list?[index].thumbnail);
        }), childCount: list?.length ?? 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20, mainAxisSpacing: 20, crossAxisCount: 2),
      ),
    );
  }
}

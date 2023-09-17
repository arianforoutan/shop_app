import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:shop_app/data/model/category.dart';
import 'package:shop_app/screens/product_list_screen.dart';
import 'package:shop_app/widgets/cached_image.dart';

class CategoryItemList extends StatelessWidget {
  final Category category;
  const CategoryItemList(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(hexColor),
                  shadows: [
                    BoxShadow(
                        color: Color(hexColor),
                        blurRadius: 22,
                        spreadRadius: -10,
                        offset: Offset(0.0, 12))
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Cachedimage(
                  fit: BoxFit.contain,
                  imageUrl: category.icon,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            category.title ?? 'product',
            style: TextStyle(fontFamily: 'SB', fontSize: 12),
          )
        ],
      ),
    );
  }
}

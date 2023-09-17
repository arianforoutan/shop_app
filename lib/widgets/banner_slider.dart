import 'package:flutter/material.dart';
import 'package:shop_app/widgets/cached_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/colors.dart';
import '../data/model/banner.dart';

// ignore: must_be_immutable
class BannerSlider extends StatelessWidget {
  List<BannerCampain> bannerList;
  BannerSlider(this.bannerList, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Cachedimage(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15,
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
                expansionFactor: 6,
                dotHeight: 6,
                dotWidth: 8,
                dotColor: Colors.white,
                activeDotColor: CustomColors.blueIndicator),
          ),
        ),
      ],
    );
  }
}

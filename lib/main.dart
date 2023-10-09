import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/bloc/basketitem/basket_bloc.dart';
import 'package:shop_app/bloc/basketitem/basket_event.dart';

import 'package:shop_app/bloc/category/category_bloc.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/constants/colors.dart';

import 'package:shop_app/di/di.dart';
import 'package:shop_app/screens/card_screen.dart';
import 'package:shop_app/screens/category_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/profile_screen.dart';

import 'data/model/basket_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CardBox');
  await getItInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: BottomNavigationBar(
              currentIndex: selectedBottomNavigationIndex,
              onTap: (int index) {
                setState(() {
                  selectedBottomNavigationIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
              ),
              fixedColor: CustomColors.blueIndicator,
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'SB',
                fontSize: 10,
              ),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/icon_profile.png'),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child:
                          Image.asset('assets/images/icon_profile_active.png'),
                    ),
                    label: 'حساب کاربری'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/icon_basket.png'),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child:
                          Image.asset('assets/images/icon_basket_active.png'),
                    ),
                    label: 'سبد خرید '),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/icon_category.png'),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child:
                          Image.asset('assets/images/icon_category_active.png'),
                    ),
                    label: 'دسته بندی'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/icon_home.png'),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/icon_home_active.png'),
                    ),
                    label: "خانه"),
              ],
            ),
          ),
        ),
        // body: IndexedStack(
        //   index: selectedBottomNavigationIndex,
        //   children: getScreens(),
        // ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      ProfileScreen(),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetchfromHiveEvent());
          return bloc;
        },
        child: CardsScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: CategoryScreen(),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) {
            var bloc = HomeBloc();
            bloc.add(HomeGetInitilzeData());
            return bloc;
          },
          child: HomeScreen(),
        ),
      )
    ];
  }
}

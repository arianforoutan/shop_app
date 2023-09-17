import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgraoundscreencolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                              'حساب کاربری',
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
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 6),
              child: Text(
                'آرین فروتن',
                style: TextStyle(fontFamily: 'SB', fontSize: 16),
              ),
            ),
            const Text(
              '0902*****51',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 40,
                runSpacing: 20,
                children: const [
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                  // CategoryItemList(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                  fontFamily: 'SM', fontSize: 10, color: CustomColors.gray),
            ),
            const Text(
              'V-1 10112',
              style: TextStyle(
                  fontFamily: 'SM', fontSize: 10, color: CustomColors.gray),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                'instagram.com/foroutan.arian',
                style: TextStyle(
                    fontFamily: 'SM', fontSize: 10, color: CustomColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/authentication/auth_bloc.dart';
import 'package:shop_app/bloc/authentication/auth_event.dart';
import 'package:shop_app/bloc/authentication/auth_state.dart';
import 'package:shop_app/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernameTextcontroller = TextEditingController(text: 'Arian44444');
  final _passwordTextcontroller = TextEditingController(text: "12345678");
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              CustomColors.blueIndicator,
              Color.fromARGB(255, 56, 154, 199)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                          fontFamily: 'SB', fontSize: 24, color: Colors.white),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _usernameTextcontroller,
                          decoration: InputDecoration(
                            labelText: 'نام کاربری',
                            labelStyle: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 18,
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CustomColors.blueIndicator, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _passwordTextcontroller,
                          decoration: InputDecoration(
                            labelText: ' رمز عبور',
                            labelStyle: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 18,
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CustomColors.blueIndicator, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                            builder: ((context, state) {
                          if (state is AuthInitiateState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.blueIndicator,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: (() {
                                BlocProvider.of<AuthBloc>(context).add(
                                    AuthloginRequest(
                                        _passwordTextcontroller.text,
                                        _usernameTextcontroller.text));
                              }),
                              child: const Text(
                                'ورود به حساب',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }

                          if (state is AuthLoadingState) {
                            return CircularProgressIndicator();
                          }

                          if (state is AuthResponseState) {
                            Text widget = Text('');
                            state.respons.fold((l) {
                              widget = Text(l);
                            }, (r) {
                              widget = Text(r);
                            });
                            return widget;
                          }

                          return Text('خطای نا مشخص !');
                        })),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

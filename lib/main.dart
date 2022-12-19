import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_app/Network/dio_helper.dart';
import 'package:shoping_app/Network/end_point.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/login_screen/shop_login_screen.dart';
import 'package:shoping_app/screens/categories_screen/categories_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_screen.dart';
import 'package:shoping_app/screens/onbording_screen/onbording_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.Init();
  await SharedPreference.initPreference();
  bool? onBording = SharedPreference.getDataBl(key: "onBording");
  token = SharedPreference.getDatasSt(key: "token");

  // print("======================${onBording}");
  // print("======================${token}");

  Widget? widget;

  if (onBording == true) {
    widget = ShopLoginScreen();
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBorderScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // bool? onBording;
  Widget? startWidget;
  MyApp({@required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>HomeCubit()..getHomeData(),

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}

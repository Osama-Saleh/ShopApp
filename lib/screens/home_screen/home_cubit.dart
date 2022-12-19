// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, unnecessary_brace_in_string_interps

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/categories_model.dart';
import 'package:shoping_app/Models/home_model.dart';
import 'package:shoping_app/Network/dio_helper.dart';
import 'package:shoping_app/Network/end_point.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/screens/categories_screen/categories_screen.dart';
import 'package:shoping_app/screens/categories_screen/categories_states.dart';
import 'package:shoping_app/screens/favorites_screen/favorites_screen.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';
import 'package:shoping_app/screens/products_screen/productes_screen.dart';
import 'package:shoping_app/screens/settings_screen/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screenButtomBar = [
    ProductesScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeButtomBar(int index) {
    currentIndex = index;
    emit(ChangeButtonNavigateBarState());
  }

  HomeModel? homemodel;
  void getHomeData() {
    emit(HomeLoadingState());
    print("Loading");

    DioHelper.getData(url: HOME, token: token).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      // print(value);
      //  print("==========================");
      // print(homemodel);
      // print("==========================");
      emit(HomeSuccessState());
    }).catchError((Error) {
      print("Error...${Error}");
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(CategoriesLoadingState());
    print("***************************");
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value);
      print("***************************");
      print(categoriesModel);
      print("***************************");
    }).catchError((Error) {
      print("Error...$Error");
      emit(CategoriesErrorState());
    });
  }
}

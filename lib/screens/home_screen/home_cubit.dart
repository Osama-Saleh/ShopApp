// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, unnecessary_brace_in_string_interps

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/Models/categories_model.dart';
import 'package:shoping_app/Models/change_favorites_model.dart';
import 'package:shoping_app/Models/favorites_items_model.dart';
import 'package:shoping_app/Models/favorites_items_model.dart';
import 'package:shoping_app/Models/home_model.dart';
import 'package:shoping_app/Models/login_model.dart';
import 'package:shoping_app/Network/dio_helper.dart';
import 'package:shoping_app/Network/end_point.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/screens/categories_screen/categories_screen.dart';
import 'package:shoping_app/screens/favorites_screen/favorites_screen.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';
import 'package:shoping_app/screens/products_screen/productes_screen.dart';
import 'package:shoping_app/screens/settings_screen/settings_screen.dart';

import '../../Models/favorites_items_model.dart';

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
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(HomeLoadingState());
    // print("Loading");

    DioHelper.getData(url: HOME, token: token).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      homemodel!.data.products.forEach((element) {
        favorites!.addAll({element.id: element.inFavorites});
      });

      emit(HomeSuccessState());
    }).catchError((Error) {
      print("Error...${Error}");
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(CategoriesLoadingState());

    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((Error) {
      print("Error...$Error");
      emit(CategoriesErrorState());
    });
  }

  ChangeFavoritesModel? favoritesModel;
  void changeFavorites(int prodictId) {
    favorites![prodictId] = !favorites![prodictId]!;
    emit(FavoritesSuccesState());
    // print(favorites![prodictId]);
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {"product_id": prodictId}).then((value) {
      favoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (favoritesModel!.status == false) {
        favorites![prodictId] = !favorites![prodictId]!;
        Fluttertoast.showToast(
            msg: "${favoritesModel!.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${favoritesModel!.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        getFavoritesData();
      }

      // print("========*===========");
      // print(value.data);
      emit(FavoritesSuccesState());
    }).catchError((Error) {
      print(Error);
      if (favoritesModel!.status == false) {
        favorites![prodictId] = !favorites![prodictId]!;
      }
      emit(FavoritesErrorState());
    });
  }

  FavoritesItemsModel? favoritesItemsModel;
  void getFavoritesData() {
    emit(GetFavoriesLoadingState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesItemsModel = FavoritesItemsModel.fromJson(value.data);
      // print(value.data);
      // print("*******************************");
      emit(FavoritesSuccesState());
    }).catchError((Error) {
      print("Errorffff$Error");
      emit(GetFavoriesErrorState());
    });
  }

  LoginModel? userDatamodel;
  void getUserSettingData() {
    emit(GetUserDataSettingLoadingState());
    print("*******************************");

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userDatamodel = LoginModel.fromMap(value.data);
      print(value.data);
      print(userDatamodel!.data!.name);
      print("*******************************");
      emit(GetUserDataSettingSuccesState(userDatamodel!));
    }).catchError((Error) {
      print("Errorssss$Error");
      emit(GetUserDataSettingErrorState());
    });
  }

  LoginModel? registerdata;
  void registerData({
    @required String? name,
    @required String? phone,
    @required String? email,
    @required String? password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    }).then((value) {
      registerdata = LoginModel.fromMap(value.data);
      print(registerdata!.status);
      if (registerdata!.status == false) {
        Fluttertoast.showToast(
            msg: "${registerdata!.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${registerdata!.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      print("=======================");
      print(registerdata!.data!.email);
      emit(RegisterSuccesState());
    }).catchError((Error) {
      print("@#@#@#@rrrr${Error}");
      emit(RegisterErrorState());
    });
  }
}

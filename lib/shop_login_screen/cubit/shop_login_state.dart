// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shoping_app/Models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  LoginModel? loginModel;
  ShopLoginSuccessState({this.loginModel});
}

class ShopLoginErrorState extends ShopLoginStates {}

class ShopChangePasswordVisibility extends ShopLoginStates {}

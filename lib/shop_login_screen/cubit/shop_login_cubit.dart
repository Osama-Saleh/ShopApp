import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/login_model.dart';
import 'package:shoping_app/Network/dio_helper.dart';
import 'package:shoping_app/Network/end_point.dart';
import 'package:shoping_app/shop_login_screen/cubit/shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());

  // static ShopLoginCubit get(context) => BlocProvider.of(context);
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {"email": email, "password": password})
        .then((value) {
      print(value.data);
      loginModel = LoginModel.fromMap(value.data);
      emit(ShopLoginSuccessState(loginModel: loginModel));
    }).catchError((Error) {
      print(Error);
      emit(ShopLoginErrorState());
    });
  }

  IconData suffix = Icons.visibility_off;
  bool showPassword = true;
  void ChangePasswordVisibility() {
    showPassword = !showPassword;
    suffix = showPassword ? Icons.visibility_off : Icons.visibility;
    emit(ShopChangePasswordVisibility());
  }
}

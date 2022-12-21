import 'package:shoping_app/Models/login_model.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class ChangeButtonNavigateBarState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

class CategoriesLoadingState extends HomeStates {}

class CategoriesSuccesState extends HomeStates {}

class CategoriesErrorState extends HomeStates {}

class FavoritesSuccesState extends HomeStates {}

class FavoritesErrorState extends HomeStates {}

class GetFavoriesLoadingState extends HomeStates {}

class GetFavoriesSuccesState extends HomeStates {}

class GetFavoriesErrorState extends HomeStates {}

class GetUserDataSettingLoadingState extends HomeStates {}

class GetUserDataSettingSuccesState extends HomeStates {
  final LoginModel userSettingData;

  GetUserDataSettingSuccesState(this.userSettingData);
}

class GetUserDataSettingErrorState extends HomeStates {}

class RegisterLoadingState extends HomeStates {}

class RegisterSuccesState extends HomeStates {}

class RegisterErrorState extends HomeStates {}

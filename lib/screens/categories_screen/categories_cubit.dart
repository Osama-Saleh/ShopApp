// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoping_app/Models/categories_model.dart';
// import 'package:shoping_app/Network/dio_helper.dart';
// import 'package:shoping_app/Network/end_point.dart';
// import 'package:shoping_app/screens/categories_screen/categories_states.dart';

// class CategoriesCubit extends Cubit<CategoriesStates> {
//   CategoriesCubit() : super(CategoriesInitState());

//   static CategoriesCubit get(context) => BlocProvider.of(context);

//   CategoriesModel? categoriesModel;

//   // void getCategoriesData() {
//   //   emit(CategoriesLoadingState());
//   //   print("***************************");
//   //   DioHelper.getData(url: CATEGORIES).then((value) {
//   //     categoriesModel = CategoriesModel.fromJson(value.data);
//   //     print(value);
//   //     print("***************************");
//   //     print(categoriesModel);
//   //     print("***************************");
//   //   }).catchError((Error) {
//   //     print("Error...$Error");
//   //     emit(CategoriesErrorState());
//   //   });
//   // }
// }

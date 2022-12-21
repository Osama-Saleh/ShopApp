import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/categories_model.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return catogeriesbuilder(HomeCubit.get(context).categoriesModel!);
      },
    );
  }
}

Widget catogeriesbuilder(CategoriesModel categoriesModel) {
  return ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage("${categoriesModel.data.data[index].image}"),
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "${categoriesModel.data.data[index].name}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => Container(
      color: Color.fromARGB(255, 175, 177, 179),
      height: 1,
    ),
    itemCount: categoriesModel.data.data.length,
  );
}

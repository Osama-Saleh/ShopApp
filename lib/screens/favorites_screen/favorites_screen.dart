// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/favorites_items_model.dart';

import '../home_screen/home_cubit.dart';
import '../home_screen/home_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        FavoritesItemsModel? favoritesItemsModel =
            HomeCubit.get(context).favoritesItemsModel;

        print("-*-*-*-*-*-*-*-**--*-*");
        print("${favoritesItemsModel!.data.data.length}");
      },
      builder: (context, state) {
        var Favo = HomeCubit.get(context).favoritesItemsModel;
        return ConditionalBuilder(
          condition: state is! GetFavoriesLoadingState ,
          builder: (context) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => favoritesbuilder(
                  HomeCubit.get(context).favoritesItemsModel!.data.data[index],
                  context),
              separatorBuilder: (context, index) => Container(
                color: Color.fromARGB(255, 175, 177, 179),
                height: 1,
              ),
              itemCount:
                  HomeCubit.get(context).favoritesItemsModel!.data.data.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ); // return favoritesbuilder(HomeCubit.get(context).favoritesItemsModel!);
      },
    );
  }
}

Widget favoritesbuilder(Datum favModel, context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
            image: NetworkImage("${favModel.product.image}"),
            height: 150,
            // fit: BoxFit.fill,
            width: 200,
          ),
          if (favModel.product.discount != 0)
            Container(
              // ignore: sort_child_properties_last
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("DISCOUNT"),
              ),
              color: Colors.red,
            )
        ],
      ),
      Container(
        // height: 150,
        padding: EdgeInsets.all(10),
        width: 200,
        child: Column(
          children: [
            Text(
              "${favModel.product.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("${favModel.product.price.toInt()}\$ ",
                    style: TextStyle(
                      color: Colors.blue,
                    )),
                SizedBox(
                  width: 20,
                ),
                if (favModel.product.discount != 0)
                  Text(
                    "${favModel.product.oldPrice.toInt()}\$",
                    style: TextStyle(
                        color: Color.fromARGB(255, 102, 100, 100),
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    HomeCubit.get(context).changeFavorites(favModel.product.id);
                  },
                  icon: HomeCubit.get(context).favorites![favModel.product.id]!
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

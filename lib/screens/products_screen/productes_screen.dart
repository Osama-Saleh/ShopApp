// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/categories_model.dart';
import 'package:shoping_app/Models/change_favorites_model.dart';
import 'package:shoping_app/Models/home_model.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';

class ProductesScreen extends StatelessWidget {
  const ProductesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homemodel != null &&
              HomeCubit.get(context).categoriesModel != null ,
          builder: (context) => productBuilder(
            context,
            HomeCubit.get(context).homemodel!,
            HomeCubit.get(context).categoriesModel!,
            
          ),
          fallback: ((context) => Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ))),
        );
      },
    );
  }
}

PageController pageController = PageController();
Widget productBuilder(context, HomeModel model, CategoriesModel categmodel,
   ) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 200,
            width: double.infinity,
            child: CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage("${e.image}"),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            )
            //
            ),
        // *******************************************************************************
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image:
                          NetworkImage("${categmodel.data.data[index].image}"),
                      width: 130,
                    ),
                    Container(
                      width: 130,
                      color: Colors.black.withOpacity(0.8),
                      child: Text("${categmodel.data.data[index].name}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                    ),
                    //
                  ],
                ),
                separatorBuilder: (context, index) => Container(
                  color: Color.fromARGB(255, 175, 177, 179),
                  width: 2,
                ),
                itemCount: categmodel.data.data.length,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Text(
            "New Prouctes",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        // ***********************************************************************************
        Container(
          color: Colors.grey[200],
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: .55,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data.products.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image(
                          image: NetworkImage(
                              "${model.data.products[index].image}"),
                          height: 250,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        if (model.data.products[index].discount != 0)
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "${model.data.products[index].name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                  "${model.data.products[index].price.toInt()}\$ ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              if (model.data.products[index].discount != 0)
                                Text(
                                  "${model.data.products[index].oldPrice.toInt()}\$",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 102, 100, 100),
                                      decoration: TextDecoration.lineThrough),
                                ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                    HomeCubit.get(context).changeFavorites(
                                        model.data.products[index].id);
                                },
                                icon: HomeCubit.get(context).favorites![
                                        model.data.products[index].id]!
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
                ),
              )),
        )
      ],
    ),
  );
}

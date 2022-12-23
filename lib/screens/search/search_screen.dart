// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/home_model.dart';
import 'package:shoping_app/Models/search_model.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Text To Search";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          HomeCubit.get(context)
                              .searchData(searchController.text);
                          print("submit");
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is SearchSuccesState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => searchBuilder(
                                HomeCubit.get(context)
                                    .homemodel!
                                    .data
                                    .products[index],
                                context),
                            separatorBuilder: (context, index) => Container(
                                  color: Color.fromARGB(255, 175, 177, 179),
                                  height: 1,
                                ),
                            itemCount: HomeCubit.get(context)
                                .homemodel!
                                .data
                                .products
                                .length),
                      )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

Widget searchBuilder(Product model, context) {
  return Container(
    width: 150,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              height: 150,
              // fit: BoxFit.fill,
              width: 150,
            ),
            if (model.discount != 0)
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
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("${model.price}\$ ",
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  if (model.discount != 0)
                    Text(
                      "${model.oldPrice}\$",
                      style: TextStyle(
                          color: Color.fromARGB(255, 102, 100, 100),
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeFavorites(model.id);
                    },
                    icon: HomeCubit.get(context).favorites![model.id]!
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
  );
}

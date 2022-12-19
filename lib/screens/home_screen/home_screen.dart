// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';
import 'package:shoping_app/screens/search/search.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData()..getCategoriesData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var myCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Souq"),
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: myCubit.screenButtomBar[myCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.blue,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              currentIndex: myCubit.currentIndex,
              onTap: (index) => myCubit.changeButtomBar(index),
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.heart_broken_sharp), label: "Favorites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],

              // selectedItemColor: Colors.amber[800]
            ),
          );
        },
      ),
    );
  }
}

// TextButton(
//               onPressed: () {
//                 SharedPreference.removeData(key: "token").then((value) {
//                   if (value!) {
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ShopLoginScreen(),
//                         ));
//                   }
//                 });
//               },
//               child: Text("LOGOUT"),

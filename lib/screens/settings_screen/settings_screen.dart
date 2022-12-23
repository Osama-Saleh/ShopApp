// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/Models/login_model.dart';
import 'package:shoping_app/Network/dio_helper.dart';
import 'package:shoping_app/Network/end_point.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/login_screen/shop_login_screen.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';
import 'package:shoping_app/screens/home_screen/home_states.dart';
import 'package:shoping_app/screens/onbording_screen/onbording_screen.dart';
import 'package:shoping_app/screens/register_screen/register_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userSettingData = HomeCubit.get(context).userDatamodel;
        nameController.text = userSettingData!.data!.name!;
        emailController.text = userSettingData.data!.email!;
        phoneController.text = userSettingData.data!.phone!;
        print("=************=${userSettingData.data!.name!}");
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is UpdataLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name must not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Name"),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email must not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone must not be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Phone"),
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      onPressed: () {
                        HomeCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                        print(nameController.text);
                      },
                      child: Text(
                        "Update Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      onPressed: () {
                        SharedPreference.removeData(key: "token").then((value) {
                          if (value!) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopLoginScreen(),
                                ));
                          }
                        });
                        print("LogOut");
                      },
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget logOut(context) => TextButton(
//       onPressed: () {
//         SharedPreference.removeData(key: "token").then((value) {
//           if (value!) {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ShopLoginScreen(),
//                 ));
//           }
//         });
//       },
//       child: Text("LOGOUT"),
//     );

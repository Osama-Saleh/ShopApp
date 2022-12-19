// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/Models/login_model.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/shop_login_screen/cubit/shop_login_cubit.dart';
import 'package:shoping_app/shop_login_screen/cubit/shop_login_state.dart';
import 'package:shoping_app/screens/home_screen/home_screen.dart';
import 'package:shoping_app/screens/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  TextEditingController emailControler = TextEditingController();
  TextEditingController PasswordControler = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        // backgroundColor: Colors.white,
        body: BlocProvider(
            create: (context) => ShopLoginCubit(),
            child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
                listener: (context, state) {
              if (state is ShopLoginSuccessState) {
                if (state.loginModel?.status == true) {
                  Fluttertoast.showToast(
                      msg: "${state.loginModel?.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  SharedPreference.saveData(
                          Key: "token", value: state.loginModel!.data!.token)
                      .then((value) {
                    if (value != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeScreen())));
                    }
                  });

                  print("====================================");
                  print(state.loginModel?.data?.token);
                  print(state.loginModel?.message);
                } else {
                  Fluttertoast.showToast(
                      msg: "${state.loginModel?.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            }, builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "login now to browse our hot offers",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(color: Colors.black38),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailControler,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email Address";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Email",
                                  // hintText: "data",

                                  prefixIcon: Icon(Icons.email),
                                  suffixIcon: Icon(Icons.lock_outline)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: PasswordControler,
                              obscureText:
                                  ShopLoginCubit.get(context).showPassword,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Correct Password";
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailControler.text,
                                      password: PasswordControler.text);
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ShopLoginCubit.get(context)
                                        .ChangePasswordVisibility();
                                  },
                                  icon:
                                      Icon(ShopLoginCubit.get(context).suffix),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: ConditionalBuilder(
                                condition: state is! ShopLoginLoadingState,
                                builder: (context) => ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopLoginCubit.get(context).userLogin(
                                            email: emailControler.text,
                                            password: PasswordControler.text);
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.white),
                                    )),
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don\'t have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black87),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ));
                                  },
                                  child: Text(
                                    "REGISTER",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.blue[600]),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              );

              //
            })));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shoping_app/screens/home_screen/home_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Name";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {}
                  },
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      prefixIcon: Icon(Icons.book),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Email";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {}
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Password";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {}
                  },
                  decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Phone";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {
                      HomeCubit.get(context).registerData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      print("EEEEEEEE${nameController.text}");
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Your phone",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

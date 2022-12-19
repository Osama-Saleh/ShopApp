// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shoping_app/login_screen/cash_helper/shared_preferences.dart';
import 'package:shoping_app/login_screen/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class modelborder {
  String? image;
  String? title;
  String? body;
  modelborder({
    this.image,
    this.title,
    this.body,
  });
}

List<modelborder> border = [
  modelborder(image: "assets/shopping1.png", title: "title1", body: "body1"),
  modelborder(image: "assets/shopping2.png", title: "title2", body: "body2"),
  modelborder(image: "assets/shopping3.png", title: "title3", body: "body3"),
];

class OnBorderScreen extends StatelessWidget {
  OnBorderScreen({super.key});
  PageController pgControler = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  SharedPreference.saveData(Key: "onBording", value: true)
                      .then((value) {
                    if (value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ShopLoginScreen())));
                    }
                  });
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: pgControler,
                  onPageChanged: (int index) {
                    if (index == border.length - 1) {
                      isLast = true;
                      print("last$isLast");
                    } else {
                      isLast = false;
                      print("notlast$isLast");
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: border.length,
                  itemBuilder: ((context, index) {
                    return myBorder(border[index]);
                  })),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pgControler,
                  count: border.length,
                  effect: JumpingDotEffect(
                      spacing: 8.0,
                      // radius: 8.0,
                      // // dotWidth: 24.0,
                      // // dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      // dotColor: Colors.grey,
                      activeDotColor: Colors.indigo),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      SharedPreference.saveData(Key: "onBording", value: true)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopLoginScreen(),
                            ));
                      });
                    }
                    pgControler.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget myBorder(modelborder model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      Expanded(child: Image(image: AssetImage("${model.image}"))),
      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Text(
        "${model.body}",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ],
  );
}

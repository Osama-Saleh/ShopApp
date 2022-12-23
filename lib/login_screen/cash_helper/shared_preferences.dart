import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? sharedPreference;

  static initPreference() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

//في حالة  لو هحط داتا من عندي عشان تتخزن زي صفحة تسجيل الدخول
// Email & Password
// عشان اعرف المستخدم ده دخل قبل كده ولا لا فبيخزن ف الذاكرة المؤقتة
  static Future<bool> saveData(
      {@required String? Key, @required dynamic value}) async {
    if (value is String) return await sharedPreference!.setString(Key!, value);
    if (value is int) return await sharedPreference!.setInt(Key!, value);
    if (value is double) return await sharedPreference!.setDouble(Key!, value);
    return await sharedPreference!.setBool(Key!, value);
  }

  // static Object? getData({@required String? key}) {
  //   return sharedPreference?.get(key!);
  // }
  static bool? getDataBl({@required String? key}) {
    return sharedPreference?.getBool(key!);
  }

  static String? getDatasSt({@required String? key}) {
    return sharedPreference?.getString(key!);
  }

  static Future<bool?> removeData({@required key}) async {
    return await sharedPreference?.remove(key);
  }

  
}

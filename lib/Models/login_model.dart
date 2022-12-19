// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? UserData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory LoginModel.fromJson(String source) =>
  // LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credit': credit,
      'token': token,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      points: map['points'] != null ? map['points'] as int : null,
      credit: map['credit'] != null ? map['credit'] as int : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserData.fromJson(String source) =>
  //     UserData.fromMap(json.decode(source) as Map<String, dynamic>);
}

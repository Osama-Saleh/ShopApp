// To parse this JSON data, do
//
//     final favoritesModel = favoritesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangeFavoritesModel favoritesModelFromJson(String str) => ChangeFavoritesModel.fromJson(json.decode(str));

String favoritesModelToJson(ChangeFavoritesModel data) => json.encode(data.toJson());

class ChangeFavoritesModel {
    ChangeFavoritesModel({
        required this.status,
        required this.message,
       
    });

    bool status;
    String message;
   

    factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) => ChangeFavoritesModel(
        status: json["status"],
        message: json["message"],
       
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        
    };
}



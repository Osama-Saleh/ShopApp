// To parse this JSON data, do
//
//     final favoritesItemsModel = favoritesItemsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavoritesItemsModel favoritesItemsModelFromJson(String str) => FavoritesItemsModel.fromJson(json.decode(str));

String favoritesItemsModelToJson(FavoritesItemsModel data) => json.encode(data.toJson());

class FavoritesItemsModel {
    FavoritesItemsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    bool status;
    dynamic message;
    Data data;

    factory FavoritesItemsModel.fromJson(Map<String, dynamic> json) => FavoritesItemsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    Datum({
       required this.id,
        required this.product,
    });

    int id;
    Product product;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
    };
}

class Product {
    Product({
        required this.id,
        required this.price,
        required this.oldPrice,
        required this.discount,
        required this.image,
        required this.name,
        required this.description,
    });

    int id;
    int price;
    int oldPrice;
    int discount;
    String image;
    String name;
    String description;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
    };
}

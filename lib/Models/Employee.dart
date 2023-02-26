import 'dart:convert';
import 'package:http/http.dart';
import 'Company.dart';

class Employee {
  Employee(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.phone,
      required this.about,
      required this.position,
      required this.company});
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String about;
  final String position;
  final String company;

  Employee copyWith(
      {int? id,
      String? name,
      String? email,
      String? address,
      String? phone,
      String? about,
      String? position,
      String? company}) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      position: position ?? this.position,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'about': about,
      'position': position,
      'company': company
    };
  }

  static Employee fromJson(Map<String, dynamic> json) {
    print(json['company']);
    return Employee(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      about: json['about'] as String,
      position: json['position'] as String,
      company: json['company'] as String,
    );
  }
}

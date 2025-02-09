// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:maya_coding_test/data/models/company.dart';
import 'package:maya_coding_test/data/models/user/user_address.dart';
import 'package:maya_coding_test/data/models/user/abstract_user.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';

class UserDetails extends User {
  final String username;
  final String phone;
  final String website;
  final UserAddress address;
  final Company company;
  UserDetails(
      {required this.address,
      required super.id,
      required super.name,
      required super.email,
      required this.phone,
      required this.username,
      required this.website,
      required this.company});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'phone': phone,
      'website': website,
      'address': address.toMap(),
      'company': company.toMap(),
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      address: UserAddress.fromMap(map['address']),
      id: map['id'],
      name: map['name'],
      company: Company.fromMap(map['company']),
      email: map['email'],
      phone: map['phone'],
      username: map['username'],
      website: map['website'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
  UserModel toUserModel() => UserModel(id: id, name: name, email: email);
}

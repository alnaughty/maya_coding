// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:maya_coding_test/data/models/coordinates.dart';

class UserAddress {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Coordinates coordinates;

  const UserAddress(
      {required this.city,
      required this.coordinates,
      required this.street,
      required this.suite,
      required this.zipcode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'coordinates': coordinates,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      street: map['street'] as String,
      suite: map['suite'] as String,
      city: map['city'] as String,
      zipcode: map['zipcode'] as String,
      coordinates: Coordinates.fromJson(map['geo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddress.fromJson(String source) =>
      UserAddress.fromMap(json.decode(source) as Map<String, dynamic>);
}

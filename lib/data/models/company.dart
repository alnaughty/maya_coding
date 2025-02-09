// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Company {
  final String name;
  final String catchPhrase;
  final String bs;
  const Company(
      {required this.bs, required this.catchPhrase, required this.name});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'] as String,
      catchPhrase: map['catchPhrase'] as String,
      bs: map['bs'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}

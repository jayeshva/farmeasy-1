import 'dart:convert';
import 'dart:ffi';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String aadhar;
  final String pan;
  final String gender;
  final String img;
  final String token;
  final int applied;
  final int approved;
  final int rejected;
  final int underReview;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.mobile,
      required this.aadhar,
      required this.pan,
      required this.gender,
      required this.img,
      required this.token,
      required this.applied,
      required this.approved,
      required this.rejected,
      required this.underReview
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'aaadhar': aadhar,
      'pan': pan,
      'gender': gender,
      'img': img,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['user_name'] ?? '',
        email: map['user_email'] ?? '',
        password: map['user_password'] ?? '',
        mobile: map['user_mobile'] ?? '',
        aadhar: map['user_aaadhar'] ?? '',
        pan: map['user_pan'] ?? '',
        gender: map['user_gender'] ?? '',
        img: map['user_img'] ?? '',
        token: map['token'] ?? '',
        applied: map['applied'] ?? 0,
        approved: map['approved'] ?? 0,
        rejected: map['rejected'] ?? 0,
        underReview: map['underReview'] ?? 0
        );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

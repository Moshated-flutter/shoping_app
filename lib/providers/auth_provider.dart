import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Future<void> signin(String emailAddress, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAKxsIqcLCUtcLkkMApG7Fehn2jdq64Y20';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'email': emailAddress,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(json.decode(response.body));
  }
}

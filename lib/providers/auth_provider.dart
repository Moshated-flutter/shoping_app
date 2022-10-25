import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isauth {
    return token != null;
  }

  String? get userid {
    return _userId;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> login(String emailAddress, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKxsIqcLCUtcLkkMApG7Fehn2jdq64Y20';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': emailAddress,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final reponsedata = json.decode(response.body);
      // ignore: avoid_print
      print(json.decode(response.body).toString());
      if (json.decode(response.body)['error'] != null) {
        print(json.decode(response.body)['error']);
        throw HttpException(json.decode(response.body)['error']['message']);
      }
      _token = reponsedata['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            reponsedata['expiresIn'],
          ),
        ),
      );
      _userId = reponsedata['localId'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String emailAddress, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAKxsIqcLCUtcLkkMApG7Fehn2jdq64Y20';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': emailAddress,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      // print(json.decode(response.body).toString());
      if (json.decode(response.body)['error'] != null) {
        print(json.decode(response.body)['error']);
        throw HttpException(json.decode(response.body)['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}

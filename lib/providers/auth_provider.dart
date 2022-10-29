// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authtimer;

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
      autologout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userdata = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expirydate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userdata);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryautologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expirydate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    autologout();
    return true;
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
        throw HttpException(json.decode(response.body)['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;

    if (_authtimer != null) {
      _authtimer!.cancel();
      _authtimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autologout() {
    if (_authtimer != null) {
      _authtimer!.cancel();
    }
    final durationTime = _expiryDate!.difference(DateTime.now()).inSeconds;

    _authtimer = Timer(
      Duration(seconds: durationTime),
      () => logout(),
    );
  }
}

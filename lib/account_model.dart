import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account with ChangeNotifier{
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _remember = false;
  bool get remember => _remember;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  void toggleRemember(bool value){
    _remember = value;
    notifyListeners();
  }

  late SharedPreferences _preferences;

  Account(){
    _initSharedPreferences();
  }
  
  Future<void> _initSharedPreferences() async{
    _preferences = await SharedPreferences.getInstance();
    String? savedEmail = _preferences.getString("email");
    String? savedPass = _preferences.getString("password");
    bool? savedRemember = _preferences.getBool("remember");

    if(savedEmail != null && savedPass != null && savedRemember == true){
      username.text = savedEmail;
      password.text = savedPass;
      _remember = true;
    }else{
      _remember = false;
    }

    _isLoaded = true;
    notifyListeners();
  }

  
  Future<void> saveCredentials() async{
    if(_remember){
      await _preferences.setString("email", username.text);
      await _preferences.setString("password", password.text);
      await _preferences.setBool("remember", remember);
    }else{
      await _preferences.remove("email");
      await _preferences.remove("password");
      await _preferences.remove("remember");
    }
  }


}
import 'package:farmeasy/models/user.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      mobile: '',
      aadhar: '',
      pan:'',
      img: '',
      token: '',
      gender: '' 
    );

    User get user => _user;

    void setUser(User user) {
    _user = user;
      notifyListeners(); 
    }
  
   void setUserFromModel(User user) {
      _user = user;
      notifyListeners(); 
    }
 
}

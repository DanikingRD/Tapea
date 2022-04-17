import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class AuthProvider  {

  final FirebaseAuth _instance = FirebaseAuth.instance;
  
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    
  }

}
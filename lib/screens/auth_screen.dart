import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_widget/auth_forms_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  void _authFormSubmit(
      String userName, String password, String email, bool isLogin) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': userName,
          'email': email,
        });
       
      }
    } on PlatformException catch (err) {
      var message = 'Please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      // Builder(
      //   builder: Scaffold.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(message),
      //       backgroundColor: Theme.of(context).errorColor,
      //     ),
      //   ),
      // );
      // ;
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
       setState(() {
          _isLoading = false;
        });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_authFormSubmit,_isLoading), //passing pointer
    );
  }
}

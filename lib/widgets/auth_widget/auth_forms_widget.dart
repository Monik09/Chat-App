import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String userName, String password, String email, bool isLogin) formSubmit;
  final bool isLoading;
  AuthForm(this.formSubmit,this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userName = '';
  String _userPAssword = '';
  String _userEmail = '';

  void _trySubmitForm() {
    final isValid = _formKey.currentState.validate();
    //to check or valid data in all field forms using their respective validator properties
    FocusScope.of(context).unfocus(); //closes all the keyboards
    if (isValid) {
      _formKey.currentState.save();
      //it will go to every field any trigger onSaved
      widget.formSubmit(
          _userName.trim(), _userPAssword.trim(), _userEmail.trim(), _isLogin);
      print(_userEmail);
      print(_userName);
      print(_userPAssword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: ValueKey('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty ||
                        !value.contains('@') &&
                            (value.contains('.com') || value.contains('.in'))) {
                      return 'Please Enter valid data';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("UserName"),
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Very small username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('Password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password should be atleast 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _userPAssword = value;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if(widget.isLoading==true)
                  CircularProgressIndicator(),
                
                if(!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                    onPressed: _trySubmitForm,
                  ),
                if(!widget.isLoading)
                  FlatButton(
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'i already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:cowvation/features/login/bloc/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginControl extends StatefulWidget {
  const LoginControl({
    Key key,
  }) : super(key: key);

  @override
  _LoginControlState createState() => _LoginControlState();
}

class _LoginControlState extends State<LoginControl> {
  String usernameInput;
  String passwordInput;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: TextFormField(
              validator: (String v) {
                if(v.isEmpty) {
                  return 'Geben Sie einen Benutzernamen ein!';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Benutzername'),
              onChanged: (username) {
                usernameInput = username;
              },
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: TextFormField(
              validator: (String v) {
                if(v.isEmpty) {
                  return 'Eingabe fehlt.';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Passwort'),
              onChanged: (password) {
                passwordInput = password;
              },
              obscureText: true,
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Login'),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            onPressed: dispatchGetToken, 
          ),
        ],
      ),
    ); 
  }

  void dispatchGetToken() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<TokenBloc>(context)
        .add(GetTokenE(usernameInput, passwordInput));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }    
  }
}
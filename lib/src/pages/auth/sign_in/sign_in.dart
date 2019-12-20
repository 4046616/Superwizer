import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './../../../../global/global.dart';
import './../../../widgets/global_widgets.dart';
import './../../../../theme/style/global_style.dart';
import './../../../../services/api.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Variables
  dynamic _email, _password;
  final _formKey = GlobalKey<FormState>();

  // Classes initialization
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _email = "";
    _password = "";
  }

// Validations
  String _emailValidator(input) =>
      !input.contains('@') ? 'Invalid Email' : null;
  String _passwordValidator(input) =>
      input.length < 6 ? 'Password too short' : null;

  void _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var data = {'email': _email, 'password': _password};
      var response = await apiService.login(data);
      print(response['error']);
      if (response['error']) {
        showAlertDialogOnOkCallback(
            'Un-Verified',
            'Sign In Again!, prees Ok to try Again.',
            DialogType.WARNING,
            context,
            () => null);
      } else {
        Navigator.pushNamed(context, '/home');
      }
    }
  }

  _googleLogin() async {
    print('Google+');
  }

  _emailSave(input) {
    _email = input;
  }

  _passwordSave(input) {
    _password = input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 650,
            child: GlobalWidgets.rotatedBoxStyleraisedButtonWithoutIcon(),
          ),
          ListView(
            children: <Widget>[
              Container(
                height: 400,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0)),
                      GlobalWidgets.inputFieldWidget(
                        'Username',
                        Icons.person,
                        keyboardType: TextInputType.emailAddress,
                        validatorFun: _emailValidator,
                        onSave: _emailSave,
                      ),
                      GlobalWidgets.inputFieldWidget(
                        'Password',
                        Icons.lock,
                        passwordHidden: true,
                        validatorFun: _passwordValidator,
                        onSave: _passwordSave,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: GlobalWidgets.raisedButtonWithoutIcon(
                            'Login', _login,
                            buttonColor: Colors.deepPurple.shade700),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forget_password');
                        },
                        child: Text(
                          "Forgot your password?",
                          style: GlobalStyle.textStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("or, connect with"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: GlobalWidgets.raisedButtonWithIcon(
                              FontAwesomeIcons.google,
                              'Log in with Google',
                              _googleLogin,
                              iconColor: Colors.white70),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        FlatButton(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Colors.indigo,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (_) {
                            //   return SignUpPage();
                            // }));
                            Navigator.pushNamed(context, '/signup');
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

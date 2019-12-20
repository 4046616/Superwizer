import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './../../../../global/global.dart';
import './../../../../services/api.dart';
import './../../../widgets/global_widgets.dart';
import './../../../../theme/style/global_style.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Variables
  double containerHeight = 540;
  String dropdownValue;
  dynamic _first_name, _last_name, _gender, _email, _password;
  final _formKey = GlobalKey<FormState>();

  // Classes initialization
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _first_name = "";
    _last_name = "";
    _gender = "";
    _email = "";
    _password = "";
  }

// Validations
  String _firstNameValidator(input) =>
      input.length < 2 ? 'First Name too short' : null;
  String _lastNameValidator(input) =>
      input.length < 2 ? 'Last Name too short' : null;
  String _genderValidator(input) {
    if (input?.isEmpty ?? true) {
      return 'Please enter a valid type of business';
    }
  }

  // input?.isEmpty ? 'Please select your Gender' : null;
  String _emailValidator(input) =>
      !input.contains('@') ? 'Invalid Email' : null;
  String _passwordValidator(input) =>
      input.length < 6 ? 'Password too short' : null;

  void _signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var data = {
        'first_name': _first_name,
        'last_name': _last_name,
        'gender': _gender,
        'email': _email,
        'password': _password
      };
      print(data);
      var response = await apiService.signUp(data);
      print(response);
      if (response['error']) {
        showAlertDialogOnOkCallback(
            'Un-Verified',
            'Sign Up Again!, prees Ok to try Again.',
            DialogType.WARNING,
            context,
            () => null);
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      setState(() {
        containerHeight = 650;
      });
    }
  }

  _googleLogin() async {
    print('Google+');
  }

  _firstNameSave(input) {
    _first_name = input;
  }

  _lastNameSave(input) {
    _last_name = input;
  }

  _genderSave(input) {
    _gender = input;
  }

  _emailSave(input) {
    _email = input;
  }

  _passwordSave(input) {
    _password = input;
  }

  _dropDownFieldWidget(String newValue) {
    setState(() {
      dropdownValue = newValue;
      print(dropdownValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: containerHeight,
            child: GlobalWidgets.rotatedBoxStyleraisedButtonWithoutIcon(
                heightPercentages: [0.00, 0.07]),
          ),
          ListView(
            children: <Widget>[
              Container(
                height: containerHeight,
                child: Form(
                  key: _formKey,
                  autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          BackButton(color: Colors.white70,),
                          Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0),
                          ),
                        ],
                      ),
                      GlobalWidgets.inputFieldWidget(
                        'First Name',
                        Icons.person,
                        keyboardType: TextInputType.text,
                        validatorFun: _firstNameValidator,
                        onSave: _firstNameSave,
                      ),
                      GlobalWidgets.inputFieldWidget(
                        'Last Name',
                        Icons.person,
                        keyboardType: TextInputType.text,
                        validatorFun: _lastNameValidator,
                        onSave: _lastNameSave,
                      ),
                      GlobalWidgets.dropDownFieldWidget(
                        'Gender',
                        FontAwesomeIcons.venusMars,
                        <String>['Male', 'Female'],
                        _dropDownFieldWidget,
                        dropdownValue,
                        validatorFun: _genderValidator,
                        onSave: _genderSave,
                      ),
                      GlobalWidgets.inputFieldWidget(
                        'Email',
                        Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validatorFun: _emailValidator,
                        onSave: _emailSave,
                      ),
                      GlobalWidgets.inputFieldWidget(
                        'Password',
                        Icons.lock,
                        passwordHidden: true,
                        keyboardType: TextInputType.visiblePassword,
                        validatorFun: _passwordValidator,
                        onSave: _passwordSave,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: GlobalWidgets.raisedButtonWithoutIcon(
                            'Sign Up', _signUp,
                            buttonColor: Colors.deepPurple.shade700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0,
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

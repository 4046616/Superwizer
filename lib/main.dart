import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './src/pages/auth/forget_password/forget_password.dart';
import './src/pages/home/home.dart';
import './src/pages/auth/sign_up/sign_up.dart';
import './src/pages/auth/sign_in/sign_in.dart';
import './theme/style/global_style.dart';


// SSL certificate disabled 
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    HttpClient client = super.createHttpClient(context); //<<--- notice 'super'
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
      useCountryCode: false,
      fallbackFile: 'en',
      path: 'assets/i18n',
      forcedLocale: new Locale('en'));
  WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);
  runApp(new TaskManager(flutterI18nDelegate));
}

class TaskManager extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  TaskManager(this.flutterI18nDelegate);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: GlobalStyle.themeSettings,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        flutterI18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: HomePage(),
      routes: {
        '/signin': (_) => SignInPage(),
        '/signup': (_) => SignUpPage(),
        '/forget_password': (_) => ForgetPasswordPage(),
        '/home': (_) => HomePage(),
      },
    );
  }
}

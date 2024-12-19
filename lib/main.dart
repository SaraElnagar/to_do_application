import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/home/task_list/edit_task_item.dart';
import 'package:to_do_app/my_theme_data.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/app_config_provider_theme.dart';
import 'package:to_do_app/providers/list_provider.dart';

import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyB8GbfxSqfqW6LyQxNBCSQ8enHZD345hhI",
              appId: "com.example.to_do_app",
              messagingSenderId: "96493942876",
              projectId: "todoapp2-52677"))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();

  /// offline => store or cash in local storage in my phone

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ListProvider()),
    ChangeNotifierProvider(create: (context) => AppConfigProvider()),
    ChangeNotifierProvider(create: (context) => AppConfigProviderTheme()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var providerLanguage = Provider.of<AppConfigProvider>(context);
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskItem.routeName: (context) => EditTaskItem(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: providerTheme.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(providerLanguage.appLanguage),
    );
  }
}

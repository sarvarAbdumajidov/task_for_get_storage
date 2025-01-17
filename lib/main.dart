import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_for_get_storage/pages/signin_page.dart';
import 'package:task_for_get_storage/pages/signup_page.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SigninPage(),
      routes: {
        SigninPage.id: (context) => SigninPage(),
        SignupPage.id: (context) => SignupPage()
      },
    );
  }
}

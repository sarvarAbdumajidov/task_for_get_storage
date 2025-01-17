import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_for_get_storage/button/custom_buttons.dart';
import 'package:task_for_get_storage/pages/signup_page.dart';
import 'package:task_for_get_storage/service/get_storage_service.dart';

import '../model/user_model.dart';

class SigninPage extends StatefulWidget {
  static const String id = 'SignInPage';

  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _clear() {
    _nameController.clear();
    _passwordController.clear();
  }

  _deleteUser() {
    if (_passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      GetStorageService.removerUser();
      setState(() {
        _clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'remove user successfully',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No data',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    );
  }

  Future<void> _loadSavedUser() async {
    User? user = GetStorageService.loadUser();
    if (user != null) {
      setState(() {
        _nameController.text = user.name!;
        _passwordController.text = user.password!;
      });
    }
  }

  @override
  void initState() {
    _loadSavedUser();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(24, 27, 49, 1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_1.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 40),
              // Heading
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Welcome Back!\n",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign in to continue',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 80),
              // Login
              universalTextField(_nameController, 'User name',
                  CupertinoIcons.person, TextInputType.name, false),
              SizedBox(height: 30),
              universalTextField(
                  _passwordController,
                  'Password',
                  CupertinoIcons.lock_circle,
                  TextInputType.visiblePassword,
                  true),

              const SizedBox(height: 30),

              // Forgot
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              const SizedBox(height: 30),
              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(_deleteUser),
                  customButton(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'sign in successfully',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    );
                  }),
                ],
              ),

              SizedBox(height: 60),
              // ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupPage.id);
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget universalTextField(TextEditingController controller, String text,
    IconData icon, TextInputType type, bool obscure) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30),
    height: 60,
    child: TextField(
      obscureText: obscure,
      style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          text,
          style: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey.shade400,
          size: 30,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
    ),
  );
}

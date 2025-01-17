import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_for_get_storage/button/custom_buttons.dart';
import 'package:task_for_get_storage/model/user_model.dart';
import 'package:task_for_get_storage/pages/signin_page.dart';
import 'package:task_for_get_storage/service/get_storage_service.dart';
import 'package:task_for_get_storage/service/log_service.dart';

class SignupPage extends StatefulWidget {
  static const String id = 'SignUpPage';

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _clear() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }

  Future<void> _fetchData() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phoneNumber = _phoneController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        password.isNotEmpty) {
      User user = User(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password);
      GetStorageService.storeUser(user);
      LogService.i(user.toJson().toString());

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data saved successfully')));


      await Future.delayed(Duration(seconds: 2));


      Navigator.pushNamed(context, SigninPage.id);
    } else {
      LogService.w('ma\'lumot kiritishda bo\'sh joy aniqlandi');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                const SizedBox(height: 40),
                // Heading
                Text(
                  textAlign: TextAlign.center,
                  'Create\nAccount',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 80),
                // Body
                universalTextField(_nameController, 'User Name',
                    CupertinoIcons.person, TextInputType.name, false),
                const SizedBox(height: 30),
                universalTextField(_emailController, 'E-Mail',
                    CupertinoIcons.mail, TextInputType.emailAddress, false),
                const SizedBox(height: 30),
                universalTextField(_phoneController, 'Phone Number',
                    CupertinoIcons.phone, TextInputType.phone, false),
                const SizedBox(height: 30),
                universalTextField(
                    _passwordController,
                    'Password',
                    CupertinoIcons.lock_circle,
                    TextInputType.visiblePassword,
                    true),
                const SizedBox(height: 60),
                // Button

                customButton(_fetchData),

                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SigninPage.id);
                      },
                      child: Text(
                        'SIGN IN',
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
        ));
  }
}

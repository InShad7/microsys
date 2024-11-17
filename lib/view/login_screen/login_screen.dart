import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/controller/login_controller/login_controller.dart';
import 'package:microsys/view/utils/colors.dart';
import 'package:microsys/view/utils/constants.dart';
import 'package:microsys/view/widget/custom_btn.dart';
import 'package:microsys/view/widget/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: white,
      body: Form(
        key: loginProvider.loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/microsys_logo.png'),
                  kWidth,
                  Text(
                    'Login',
                    style: TextStyle(
                      color: blue,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              kHeight30,
              CustomTextFormField(
                controller: loginProvider.emailController,
                hintText: 'Email',
                isPrefixIcon: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email address is required';
                  }
                  final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              kHeight,
              CustomTextFormField(
                controller: loginProvider.passwordController,
                hintText: 'Password',
                obsecureText: true,
                isPrefixIcon: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == '') {
                    return 'Enter a valid Password';
                  } else if (value.length < 6) {
                    return 'Enter a 6 digit password';
                  }
                },
              ),
              kHeight30,
              CustomBtn(
                title: 'Login',
                onPressed: () {
                  if (loginProvider.loginFormKey.currentState!.validate()) {
                    loginProvider.loginWithFirebase();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please enter a valid login credentials',
                    );
                  }
                },
                color: blue,
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

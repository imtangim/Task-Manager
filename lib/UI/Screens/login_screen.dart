import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/UI/Screens/forgot_password_screen/email_screen.dart';
import 'package:task_manager/UI/Screens/join_us.dart';

import 'package:task_manager/UI/Widget/background.dart';

import 'package:task_manager/UI/Widget/custom_textfield.dart';
import 'package:task_manager/UI/Widget/snack_messager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  bool _signInProgress = false;

  bool _showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackGround(),
          SafeArea(
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get Started With",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            _showError == true
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Password or Email maybe incorrect. Check again.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontSize: 13),
                                      ),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                                _showError = false;
                                if (mounted) {
                                  setState(() {});
                                }
                                log(_email.text);
                              },
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Email cannot be empty";
                                }
                                if (!emailRegExp.hasMatch(value!)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                              controller: _email,
                              hintText: "Email",
                              obsecureText: false,
                              type: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                                _showError = false;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty.";
                                }
                                return null;
                              },
                              icon: const Icon(Icons.visibility_outlined),
                              controller: _password,
                              hintText: "Password",
                              obsecureText: true,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Visibility(
                              visible: _signInProgress == false,
                              replacement: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: JumpingDots(
                                    verticalOffset: 8,
                                    color: Colors.white,
                                    radius: 10,
                                    numberOfDots: 3,
                                  ),
                                ),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  maximumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: signIn,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/ui/arrow.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EmailScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.black87,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void clear() {
    _email.clear();
    _password.clear();
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      _signInProgress = true;
      _showError = false;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse networkResponse = await NetworkCaller().postRequest(
        Urls.login,
        body: {"email": _email.text.trim(), "password": _password.text},
      );
      clear();
      _signInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (networkResponse.isSuccess) {
        if (mounted) {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
          showSnackMessage(context, "Successfull.", Colors.green);
        }
      } else {
        if (networkResponse.statusCode == 401) {
          _showError = true;
          if (mounted) {
            setState(() {});
            _password.clear();
          }
        } else {
          if (mounted) {
            showSnackMessage(
              context,
              "Something went wrong. Try again latter.",
              Colors.red,
            );
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

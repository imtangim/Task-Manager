import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/UI/Widget/background.dart';
import 'package:task_manager/UI/Widget/custom_textfield.dart';
import 'package:task_manager/UI/Widget/snack_messager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextEditingControler =
      TextEditingController();
  final TextEditingController _passwordTextEditingControler =
      TextEditingController();
  final TextEditingController _firstNameTextEditingControler =
      TextEditingController();
  final TextEditingController _lastNameTextEditingControler =
      TextEditingController();
  final TextEditingController _phoneTextEditingControler =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp mobileRegExp = RegExp(r'^01\d{9}$');
  RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!_]{8,}$',
  );
  double height = 20;
  bool _signUpProgress = false;

  void Clear() {
    _emailTextEditingControler.clear();
    _firstNameTextEditingControler.clear();
    _lastNameTextEditingControler.clear();
    _passwordTextEditingControler.clear();
    _phoneTextEditingControler.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackGround(),
          SafeArea(
            child: SingleChildScrollView(
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
                              "Join With Us",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: height,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                              },
                              controller: _emailTextEditingControler,
                              hintText: "Email",
                              obsecureText: false,
                              type: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Email cannot be empty";
                                }
                                if (!emailRegExp.hasMatch(value!)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                              },
                              controller: _firstNameTextEditingControler,
                              hintText: "First Name",
                              obsecureText: false,
                              type: TextInputType.name,
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Enter your first name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                              },
                              controller: _lastNameTextEditingControler,
                              hintText: "Last Name",
                              obsecureText: false,
                              type: TextInputType.name,
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Enter your lastname";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                              },
                              controller: _phoneTextEditingControler,
                              hintText: "Mobile Number",
                              obsecureText: false,
                              type: TextInputType.phone,
                              validator: (String? value) {
                                if (value == null ||
                                    !mobileRegExp.hasMatch(value)) {
                                  return "Enter a valid mobile number'";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: height,
                            ),
                            CustomTextfield(
                              onchanged: (String? value) {
                                _formKey.currentState!.validate();
                              },
                              controller: _passwordTextEditingControler,
                              hintText: "Password",
                              obsecureText: true,
                              validator: (String? value) {
                                if (value == null ||
                                    !passwordRegExp.hasMatch(value) ||
                                    value.length < 8) {
                                  return "Password must contain at least letter, digit and be at least 8 characters long.";
                                }
                                return null;
                              },
                              icon: const Icon(Icons.visibility_outlined),
                            ),
                            SizedBox(
                              height: height,
                            ),
                            Visibility(
                              visible: _signUpProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: signup,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.black87,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Sign in",
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

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      _signUpProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailTextEditingControler.text.trim(),
        "firstName": _firstNameTextEditingControler.text.trim(),
        "lastName": _lastNameTextEditingControler.text.trim(),
        "mobile": _phoneTextEditingControler.text.trim(),
        "password": _passwordTextEditingControler.text,
        "photo": ""
      });
      _signUpProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        if (mounted) {
          showSnackMessage(context, "Account has been created.", Colors.green);
        }
        Clear();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, "Something went wrong. Try again letter.", Colors.red);
          _passwordTextEditingControler.clear();
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTextEditingControler.dispose();
    _firstNameTextEditingControler.dispose();
    _lastNameTextEditingControler.dispose();
    _passwordTextEditingControler.dispose();
    _phoneTextEditingControler.dispose();
    super.dispose();
  }
}

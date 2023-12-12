import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/UI/Widget/background.dart';
import 'package:task_manager/UI/Widget/custom_textfield.dart';

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
                              "Join With Us",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              controller: _emailTextEditingControler,
                              hintText: "Email",
                              obsecureText: false,
                              type: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Enter a valid email address";
                                }
                                if (!emailRegExp.hasMatch(value!)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              controller: _firstNameTextEditingControler,
                              hintText: "First Name",
                              obsecureText: false,
                              type: TextInputType.name,
                              validator: (String? value) {
                                if (value?.trim().isNotEmpty ?? true) {
                                  return "Enter your first name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              controller: _lastNameTextEditingControler,
                              hintText: "Last Name",
                              obsecureText: false,
                              type: TextInputType.name,
                              validator: (String? value) {
                                if (value?.trim().isNotEmpty ?? true) {
                                  return "Enter your lastname";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
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
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextfield(
                              controller: _passwordTextEditingControler,
                              hintText: "Password",
                              obsecureText: true,
                              validator: (String? value) {
                                if (value == null ||
                                    !passwordRegExp.hasMatch(value) ||
                                    value.length < 8) {
                                  return "Password must contain at least letter, digit, andspecial symbol (if desired), and be at least 8 characters long.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/ui/arrow.svg",
                                  fit: BoxFit.fill,
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
}

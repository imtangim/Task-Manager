import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/UI/Screens/login_screen.dart';

import 'package:task_manager/UI/Widget/background.dart';

import 'package:task_manager/UI/Widget/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                            controller: email,
                            hintText: "Email",
                            obsecureText: false,
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: firstName,
                            hintText: "First Name",
                            obsecureText: false,
                            type: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: lastName,
                            hintText: "Last Name",
                            obsecureText: false,
                            type: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: phone,
                            hintText: "Mobile Number",
                            obsecureText: false,
                            type: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: password,
                            hintText: "Password",
                            obsecureText: true,
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

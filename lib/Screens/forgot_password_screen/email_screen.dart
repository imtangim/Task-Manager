import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/Screens/forgot_password_screen/otp_screen.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';

import 'package:task_manager/Widget/background.dart';

import 'package:task_manager/Widget/custom_textfield.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController email = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Email Address",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "A 6 digit verification pin will be send to your email address",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                    ),
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
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OtpScreen(),
                                ),
                              );
                            },
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
                                "Found your password? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.black87,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAll(() =>  LoginScreen());
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

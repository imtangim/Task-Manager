import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/login_controller.dart';
import 'package:task_manager/Screens/forgot_password_screen/email_screen.dart';
import 'package:task_manager/Screens/authentication/join_us.dart';
import 'package:task_manager/Widget/background.dart';
import 'package:task_manager/Widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  void dispose() {
    // Dispose of resources held by the state
    // Call dispose method of super class

    super.dispose();
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: Center(
                child: GetBuilder<LoginController>(builder: (logincontroller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: logincontroller.loginFormKey,
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Get Started With",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              //if error , it will be shown here
                              logincontroller.showSigninError == true
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
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Email cannot be empty";
                                  }
                                  if (!emailRegExp.hasMatch(value!)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                                controller: logincontroller
                                    .signinEmailTextEditingControler,
                                hintText: "Email",
                                obsecureText: false,
                                type: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextfield(
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password cannot be empty.";
                                  }
                                  return null;
                                },
                                icon: const Icon(Icons.visibility_outlined),
                                controller: logincontroller
                                    .signinPasswordTextEditingControler,
                                hintText: "Password",
                                obsecureText: true,
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Visibility(
                                visible: !logincontroller.isLoading,
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
                                    maximumSize:
                                        const Size(double.infinity, 50),
                                  ),
                                  onPressed: () {
                                    logincontroller.signIn(context);
                                  },
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
                                    logincontroller.loginFormKey.currentState
                                        ?.reset();
                                    Get.off(() => const EmailScreen());
                                    logincontroller.signinClear();
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
                                     
                                        Get.offAll(()=> const SignUpScreen());
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
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/auth_controller.dart';
import 'package:task_manager/Widget/custom_textfield.dart';


class SignUpForm extends StatelessWidget {
  final double height;

   SignUpForm({
    super.key,
    required this.height,
  });

  final AuthController _authController = Get.put(AuthController());

  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  final RegExp mobileRegExp = RegExp(r'^01\d{9}$');

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!_]{8,}$',
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Join With Us",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: height,
          ),
          Form(
            key: controller.emailFormKey,
            child: CustomTextfield(
              onchanged: (String? value) {
                controller.emailFormKey.currentState!.validate();
              },
              controller: controller.emailTextEditingControler,
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
          ),
          SizedBox(
            height: height,
          ),
          CustomTextfield(
            onchanged: (String? value) {
              controller.formKey.currentState!.validate();
            },
            controller: controller.firstNameTextEditingControler,
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
              controller.formKey.currentState!.validate();
            },
            controller: controller.lastNameTextEditingControler,
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
          Form(
            key: controller.phoneFormKey,
            child: CustomTextfield(
              onchanged: (String? value) {
                controller.phoneFormKey.currentState!.validate();
              },
              controller: controller.phoneTextEditingControler,
              hintText: "Mobile Number",
              obsecureText: false,
              type: TextInputType.phone,
              validator: (String? value) {
                if (value == null || !mobileRegExp.hasMatch(value)) {
                  return "Enter a valid mobile number'";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: height,
          ),
          Form(
            key: controller.passwordFormKey,
            child: CustomTextfield(
              onchanged: (String? value) {
                controller.passwordFormKey.currentState!.validate();
              },
              controller: controller.passwordTextEditingControler,
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
          ),
          SizedBox(
            height: height,
          ),
          Visibility(
            visible: !controller.isLoading,
            replacement: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
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
              onPressed: () {
                _authController.signup(context);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have account? ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Sign in",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}

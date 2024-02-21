import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/Widget/custom_textfield.dart';

class SignUpForm extends StatefulWidget {
  final double height;
  final GlobalKey<FormState> emailFormkey;
  final GlobalKey<FormState> formkey;
  final GlobalKey<FormState> phoneFormkey;
  final GlobalKey<FormState> passwordFormkey;

  final TextEditingController emailTextEditingControler;
  final TextEditingController firstNameTextEditingControler;
  final TextEditingController lastNameEditingControler;
  final TextEditingController phoneTextEditingControler;
  final TextEditingController passwordTextEditingControler;

  final Function() signup;

  final bool signUpProgress;
  const SignUpForm({
    super.key,
    required this.height,
    required this.emailFormkey,
    required this.formkey,
    required this.phoneFormkey,
    required this.passwordFormkey,
    required this.emailTextEditingControler,
    required this.firstNameTextEditingControler,
    required this.lastNameEditingControler,
    required this.phoneTextEditingControler,
    required this.passwordTextEditingControler,
    required this.signup,
    required this.signUpProgress,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp mobileRegExp = RegExp(r'^01\d{9}$');
  RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!_]{8,}$',
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Join With Us",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: widget.height,
        ),
        Form(
          key: widget.emailFormkey,
          child: CustomTextfield(
            onchanged: (String? value) {
              widget.emailFormkey.currentState!.validate();
            },
            controller: widget.emailTextEditingControler,
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
          height: widget.height,
        ),
        CustomTextfield(
          onchanged: (String? value) {
            widget.formkey.currentState!.validate();
          },
          controller: widget.firstNameTextEditingControler,
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
          height: widget.height,
        ),
        CustomTextfield(
          onchanged: (String? value) {
            widget.formkey.currentState!.validate();
          },
          controller: widget.lastNameEditingControler,
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
          height: widget.height,
        ),
        Form(
          key: widget.phoneFormkey,
          child: CustomTextfield(
            onchanged: (String? value) {
              widget.phoneFormkey.currentState!.validate();
            },
            controller: widget.phoneTextEditingControler,
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
          height: widget.height,
        ),
        Form(
          key: widget.passwordFormkey,
          child: CustomTextfield(
            onchanged: (String? value) {
              widget.passwordFormkey.currentState!.validate();
            },
            controller: widget.passwordTextEditingControler,
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
          height: widget.height,
        ),
        Visibility(
          visible: widget.signUpProgress == false,
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
            onPressed: widget.signup,
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
  }
}

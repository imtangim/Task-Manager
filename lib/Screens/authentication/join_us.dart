import 'package:flutter/material.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Widget/background.dart';
import 'package:task_manager/Widget/signup_form.dart';
import 'package:task_manager/Widget/snack_messager.dart';

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
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  double height = 20;
  bool _signUpProgress = false;

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
                        child: SignUpForm(
                          emailFormkey: _emailFormKey,
                          emailTextEditingControler: _emailTextEditingControler,
                          formkey: _formKey,
                          firstNameTextEditingControler:
                              _firstNameTextEditingControler,
                          lastNameEditingControler:
                              _lastNameTextEditingControler,
                          height: height,
                          passwordFormkey: _passwordFormKey,
                          passwordTextEditingControler:
                              _passwordTextEditingControler,
                          phoneFormkey: _phoneFormKey,
                          phoneTextEditingControler: _phoneTextEditingControler,
                          signUpProgress: _signUpProgress,
                          signup: signup,
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
        clear();
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

  void clear() {
    _emailTextEditingControler.clear();
    _firstNameTextEditingControler.clear();
    _lastNameTextEditingControler.clear();
    _passwordTextEditingControler.clear();
    _phoneTextEditingControler.clear();
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

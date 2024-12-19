import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/auth/register/register_screen.dart';
import 'package:to_do_app/home/home_screen.dart';

import '../../dialog_utils.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";

  TextEditingController emailController =
      TextEditingController(text: "sarasamir123@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Scaffold(),
        Container(
          color: AppColors.backgroundLightColor,
          child: const Image(
            image: AssetImage("assets/images/main_background.png"),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Login',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 20, color: AppColors.whiteColor),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
          ),
          body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Welcome Back!",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Password';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          onPressed: () {
                            login(context);
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.whiteColor),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: Text(
                          'Or Create My Account',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryColor),
                        ))
                  ],
                ),
              )),
        )
      ],
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      ///Login
      DialogUtils.showLoading(context: context, message: "Loading");
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            title: "Success",
            message: "Login Successfully.",
            posActionName: "OK",
            posAction: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            });
        // print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            title: "Error",
            context: context,
            posActionName: "OK",
            message:
                "The supplied auth credential is incorrect, malformed or has expired.",
          );
          // print(
          //   "The supplied auth credential is incorrect, malformed or has expired.",
          // );
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            posActionName: "OK",
            message:
                "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
          );
          // print("network error");
        } else if (e.code == "password-already-exist") {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            posActionName: "OK",
            message: "The Password doesn't correct",
          );
          // print("The Password doesn't correct");
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          title: "Error",
          posActionName: "OK",
          message: e.toString(),
        );
        // print(e.toString());
      }
    }
  }
}

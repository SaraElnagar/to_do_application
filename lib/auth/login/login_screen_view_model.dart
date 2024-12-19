// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:to_do_app/auth/login/login_navigator.dart';
//
// class LoginScreenViewModel extends ChangeNotifier {
//   ///Login
//   /// hold data - handle logic
//   var emailController = TextEditingController(text: 'sarasamir123@gmail.com');
//   var passwordController = TextEditingController(text: '123456s');
//   var formKey = GlobalKey<FormState>();
//   late LoginNavigator navigator;
//
//   void login() async {
//     if (formKey.currentState!.validate() == true) {
//       //todo: show loading
//       navigator.showMyLoading("Waiting...");
//       try {
//         final credential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );
//         //todo: hide loading
//         navigator.hideMyLoading();
//         //todo: show Message
//         navigator.showMyMessage("Login Successfully.");
//         //     context: context,
//         //     title: "Success",
//         //     message: "Login Successfully.",
//         //     posActionName: "OK",
//         //     posAction: () {
//         //       Navigator.pushNamed(context, HomeScreen.routeName);
//         //     });
//         // print(credential.user?.uid ?? "");
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'invalid-credential') {
//           ///todo:hide loading
//           navigator.hideMyLoading();
//
//           ///todo:show message
//           navigator.showMyMessage(
//               "The supplied auth credential is incorrect, malformed or has expired.");
//           //   title: "Error",
//           //   context: context,
//           //   posActionName: "OK",
//           //   message:
//           //   "The supplied auth credential is incorrect, malformed or has expired.",
//           // );
//           // print(
//           //   "The supplied auth credential is incorrect, malformed or has expired.",
//           // );
//         } else if (e.code == 'network-request-failed') {
//           ///todo:hide loading
//           navigator.hideMyLoading();
//
//           ///todo:show message
//           navigator.showMyMessage(
//             "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
//           );
//           //   context: context,
//           //   title: "Error",
//           //   posActionName: "OK",
//           //   message:
//           //   "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
//           // );
//           // print("network error");
//         } else if (e.code == "password-already-exist") {
//           ///todo:hide loading
//           navigator.hideMyLoading();
//
//           ///todo:show message
//           navigator.showMyMessage("The Password doesn't correct");
//           //   context: context,
//           //   title: "Error",
//           //   posActionName: "OK",
//           //   message: "The Password doesn't correct",
//           // );
//           // print("The Password doesn't correct");
//         }
//       } catch (e) {
//         ///todo:hide loading
//         navigator.hideMyLoading();
//
//         ///todo:show message
//         navigator.showMyMessage(e.toString());
//         //   context: context,
//         //   title: "Error",
//         //   posActionName: "OK",
//         //   message: e.toString(),
//         // );
//         // print(e.toString());
//       }
//     }
//   }
// }

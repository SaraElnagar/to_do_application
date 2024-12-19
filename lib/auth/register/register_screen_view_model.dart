// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:to_do_app/auth/register/register_navigator.dart';
//
// class RegisterScreenViewModel extends ChangeNotifier {
//   late RegisterNavigator navigator;
//
//   void Register(String email, String password) async {
//     ///Register
//     /// hold data - handle logic
//     //todo: show loading
//     navigator.showMyLoading("Loading...");
//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       //todo: hide loading
//       navigator.hideMyLoading();
//       //todo: show Message
//       navigator.showMyMessage("Register Successfully.");
//       // DialogUtils.showMessage(
//       //   context: context,
//       //   title: "Success",
//       //   posActionName: "OK",
//       //   message: "Register Successfully.",
//       //   posAction: () {
//       //     Navigator.of(context).pushNamed(HomeScreen.routeName);
//       //   });
//       // print(credential.user?.uid ?? "");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         ///todo:hide loading
//         navigator.hideMyLoading();
//
//         ///todo:show message
//         navigator.showMyMessage("The password provided is too weak.");
// // DialogUtils.showMessage(
// //           context: context,
// //           title: "Error",
// //           posActionName: "OK",
// //           message: "The password provided is too weak.",
// //         );
// //         print("The password provided is too weak.");
//       } else if (e.code == 'email-already-in-use') {
//         ///todo:hide loading
//         navigator.hideMyLoading();
//
//         ///todo:show message
//         navigator.showMyMessage("The account already exists for that email.");
//         // DialogUtils.hideLoading(context: context);
//         // DialogUtils.showMessage(
//         //   context: context,
//         //   title: "Error",
//         //   posActionName: "OK",
//         //   message: "The account already exists for that email.",
//         // );
//         // print("The account already exists for that email.");
//       } else if (e.code == 'network-request-failed') {
//         ///todo:hide loading
//         navigator.hideMyLoading();
//
//         ///todo:show message
//         navigator.showMyMessage(
//             "A network error (such as timeout, interrupted connection or unreachable host) has occurred.");
//         // DialogUtils.hideLoading(context: context);
//         // DialogUtils.showMessage(
//         //   context: context,
//         //   title: "Error",
//         //   posActionName: "OK",
//         //   message:
//         //       "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
//         // );
//         // print("network error");
//       }
//     } catch (e) {
//       ///todo:hide loading
//       navigator.hideMyLoading();
//
//       ///todo:show message
//       navigator.showMyMessage(e.toString());
//       // DialogUtils.showMessage(
//       //   context: context,
//       //   title: "Error",
//       //   posActionName: "OK",
//       //   message: e.toString(),
//       // );
//       // print(e.toString());
//     }
//   }
// }

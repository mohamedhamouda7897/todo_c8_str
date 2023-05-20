import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_str/home_layout/home_layout.dart';
import 'package:todo_c8_str/providers/my_provider.dart';
import 'package:todo_c8_str/screens/signup.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Stack(
      children: [
        Image.asset(
          "assets/images/sign_in_bg.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value == null || value.isEmpty || !emailValid) {
                              return "Please Enter valid Email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text("Email Address"),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter valid Email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text("Password"),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseFunctions.loginAccount(
                                  emailController.text, passwordController.text,
                                  (value) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(value),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes'))
                                    ],
                                  ),
                                );
                              }, () {
                                pro.initUser().then((value) {
                                  Navigator.pushReplacementNamed(
                                      context, HomeLayout.routeName);
                                });
                              });
                            },
                            child: Text("Login")),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.routeName);
                        },
                        child: Text(
                          "Create Account",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

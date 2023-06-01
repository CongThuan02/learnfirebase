import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/components/base_input/text/base_input_text.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import '../../common/validation/form_validation_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final formValidationManager = FormValidationManager();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String? error = null;
  @override
  void dispose() {
    formValidationManager.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future signInUsername() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );
    } catch (e) {
      setState(() {
        error = "Tài khoản hoặc mật khẩu không chính xác";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.android,
                      size: 150,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Hello Again!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Wellcome back, you've been missed!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BaseInputText(
                    rules: "required",
                    controller: username,
                    id: UniqueKey().toString(),
                    name: 'Username',
                    onChanged: () {},
                    title: 'Username',
                  ),
                  BaseInputText(
                    formValidationManager: FormValidationManager(),
                    rules: "required|min_length:6",
                    obscureText: true,
                    controller: password,
                    id: UniqueKey().toString(),
                    name: 'Password',
                    onChanged: () {},
                    title: 'Password',
                  ),
                  if (error != null) ...{
                    const SizedBox(
                      height: 5,
                    ),
                    FadedScaleAnimation(
                      child: Text(
                        "$error",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    )
                  },
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          // _form.currentState!.validate();
                          // if (!_form.currentState!.validate()) {
                          //   formValidationManager.erroredFields.first.focusNode.requestFocus();
                          // }
                          setState(() {
                            error = null;
                          });
                          signInUsername();
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member? "),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Register now"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

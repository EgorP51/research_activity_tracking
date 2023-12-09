import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_activity_tracking/data/auth_service.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthWidget();
  }
}

enum PageState { registration, login }

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  var currentState = PageState.login;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentState == PageState.login
                  ? 'L O G I N'
                  : 'R E G I S T R A T I O N',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (currentState == PageState.login) {
                            currentState = PageState.registration;
                          } else {
                            currentState = PageState.login;
                          }
                        });
                      },
                      child: Text(
                        currentState == PageState.login
                            ? 'No account, create one!'
                            : 'Already have an account?',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CupertinoButton(
                      color: Colors.black,
                      child: Text(
                        currentState == PageState.registration
                            ? 'create account'
                            : 'sign in',
                      ),
                      onPressed: () {
                        if (currentState == PageState.login) {
                          AuthService().signInWithEmail(
                            _emailController.text,
                            _passwordController.text,
                          );
                        } else {
                          AuthService().signUpWithEmail(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

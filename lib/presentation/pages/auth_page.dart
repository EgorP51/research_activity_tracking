import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/user.dart';
import 'main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWidget();
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
                      decoration: const InputDecoration(
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(
                              // TODO: change later!
                              user: User(
                                email: 'cool.man@gmail.com',
                                firstName: 'Cool',
                                lastName: 'Man😎',
                                id: 12,
                                role: 'scientist',
                              ),
                            ),
                          ),
                        );
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

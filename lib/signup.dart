import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_encrypted_instant_message/endpoints.dart';
import 'package:flutter_encrypted_instant_message/home.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
            TextEditingController(text: "client@gmail.com"),
        passwordController = TextEditingController(text: "password"),
        usernameController = TextEditingController(text: "username"),
        fullnameController = TextEditingController(text: "full name");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Signup",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              controller: fullnameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                Uri uri = Uri.parse(
                    "http://192.168.111.130:3000${Endpoints().signup}");
                http.post(uri, body: {
                  "username": usernameController.text,
                  "email": emailController.text,
                  "name": fullnameController.text,
                  "pass": passwordController.text,
                }).then((value) {
                  switch (value.statusCode) {
                    case 200:
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          children: [
                            const Text("Account successfully created!"),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed('/login'),
                              child: const Text("Login"),
                            )
                          ],
                        ),
                      );
                      // Good to go
                      break;
                    default:
                      throw Exception(jsonDecode(value.body)['error']);
                  }
                }).onError(
                  (error, stackTrace) => showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text("Error"),
                      children: [Text(error.toString())],
                    ),
                  ),
                );
              },
              child: const Text("Signup"),
            ),
            const Text("Already have an account?"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}

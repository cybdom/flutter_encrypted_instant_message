import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_encrypted_instant_message/endpoints.dart';
import 'package:flutter_encrypted_instant_message/home.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
            TextEditingController(text: "client@gmail.com"),
        passwordController = TextEditingController(text: "password");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: Theme.of(context).textTheme.titleLarge,
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
                    "http://192.168.111.130:3000${Endpoints().login}");
                http
                    .post(uri, body: {
                      "user": emailController.text,
                      "password": passwordController.text,
                    })
                    .then((value) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              authToken: jsonDecode(value.body)['data']
                                  ['authToken'],
                            ),
                          ),
                        ))
                    .catchError(
                      (onError) => showDialog(
                        context: context,
                        builder: (context) => const SimpleDialog(
                          title: Text("Error"),
                          children: [Text("Error while login in.")],
                        ),
                      ),
                    );
              },
              child: const Text("Login"),
            ),
            const Divider(),
            const Text("No account yet?"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: const Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}

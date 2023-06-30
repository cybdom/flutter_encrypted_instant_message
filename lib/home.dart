import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String authToken;
  const HomeScreen({super.key, required this.authToken});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => showDialog(
          context: context,
          builder: (builder) => SimpleDialog(
            children: [Text("${widget.authToken}")],
          ),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

import 'package:flutter/material.dart';

class TestImage extends StatelessWidget {
  const TestImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 800,
        width: 800,
        child: Image.network(
            "https://raw.githubusercontent.com/anil-s-yadav/stream24news_crm/e14fd7bd2aec22d94c12049721e0455218820cf9/Animex.png"),
      ),
    );
  }
}

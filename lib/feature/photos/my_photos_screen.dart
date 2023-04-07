import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';

class MyPhotosScreen extends StatelessWidget {
  const MyPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              "My photos",
              style: AppTextStyles.s19W700(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

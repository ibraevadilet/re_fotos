import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/photos/widget/widget_photo_container.dart';

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
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 0,
                  mainAxisExtent: 172,
                ),
                itemBuilder: (context, index) => WidgetPhotoContainer(),
                itemCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

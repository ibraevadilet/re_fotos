import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/home/widget/widget_container.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Main",
                style: AppTextStyles.s19W700(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => WidgetContainer(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

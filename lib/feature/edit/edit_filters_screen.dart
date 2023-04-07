import 'dart:io';

import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/widgets/spaces.dart';

class EditFiltersScreen extends StatelessWidget {
  const EditFiltersScreen({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Filtres",
          style: AppTextStyles.s19W700(color: Colors.black),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SizedBox(
            width: getWidth(context),
            child: Image.file(
              File(image),
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 90,
            child: Image.asset(
              AppImages.swipeIcon,
              width: 64,
            ),
          ),
          Positioned(
            bottom: 48,
            child: Text(
              "swipe left to toggle filter",
              style: AppTextStyles.s19W700(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

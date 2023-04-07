import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:re_fotos/config/check_premium.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/auth/premium_screen.dart';
import 'package:re_fotos/feature/edit/only_filter_screen.dart';
import 'package:re_fotos/feature/image_editor/image_editor_plus.dart';
import 'package:re_fotos/widgets/custom_button.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Editor",
                style: AppTextStyles.s19W700(color: Colors.black),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  final XFile? imageFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (imageFile != null) {
                    Uint8List imageData =
                        File(imageFile.path).readAsBytesSync();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageEditor(
                          image: imageData,
                        ),
                      ),
                    );
                  }
                },
                icon: AppImages.editIcon,
                text: "edit manually",
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? imageFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (imageFile != null) {
                    Uint8List imageData =
                        File(imageFile.path).readAsBytesSync();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnlyFilterScreen(
                          image: imageData,
                        ),
                      ),
                    );
                  }
                },
                icon: AppImages.filtersIcon,
                text: "filters",
              ),
              const SizedBox(height: 20),
              CustomButton(
                icon: AppImages.autoIcon,
                text: "auto-editing",
                onPressed: () async {
                  final isBuy = await CheckPremium.getSubscription();
                  if (!isBuy) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumScreen(isPop: true),
                      ),
                    );
                  } else {
                    final ImagePicker picker = ImagePicker();

                    final XFile? imageFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (imageFile != null) {
                      Uint8List imageData =
                          File(imageFile.path).readAsBytesSync();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageEditor(
                            image: imageData,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

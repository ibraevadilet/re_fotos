import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/edit/edit_filters_screen.dart';
import 'package:re_fotos/feature/edit/edit_manually_screen.dart';
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditManuallyScreen(
                          image: imageFile.path,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFiltersScreen(
                          image: imageFile.path,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

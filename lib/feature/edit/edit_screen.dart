import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:re_fotos/utils/check_premium.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/auth/premium_screen.dart';
import 'package:re_fotos/feature/edit/only_filter_screen.dart';
import 'package:re_fotos/feature/image_editor/image_editor_plus.dart';
import 'package:re_fotos/logic/get_pictures_cubit/get_pictures_cubit.dart';
import 'package:re_fotos/widgets/custom_button.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPicturesCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                Builder(builder: (context) {
                  return CustomButton(
                    onPressed: () async {
                      final images =
                          await context.read<GetPicturesCubit>().getPictures();
                      final isBuy = await CheckPremium.getSubscription();
                      if (images.length > 2 && !isBuy) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PremiumScreen(
                              isPop: true,
                            ),
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
                    icon: AppImages.editIcon,
                    text: "edit manually",
                  );
                }),
                const SizedBox(height: 20),
                Builder(builder: (context) {
                  return CustomButton(
                    onPressed: () async {
                      final images =
                          await context.read<GetPicturesCubit>().getPictures();
                      final isBuy = await CheckPremium.getSubscription();
                      if (images.length > 2 && !isBuy) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PremiumScreen(
                              isPop: true,
                            ),
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
                              builder: (context) => OnlyFilterScreen(
                                image: imageData,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: AppImages.filtersIcon,
                    text: "filters",
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

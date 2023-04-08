import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/photos/widget/widget_photo_container.dart';
import 'package:re_fotos/logic/get_pictures_cubit/get_pictures_cubit.dart';
import 'package:re_fotos/widgets/app_error_text.dart';
import 'package:re_fotos/widgets/app_indicator.dart';

class MyPhotosScreen extends StatelessWidget {
  const MyPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPicturesCubit()..getPictures(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "My photos",
                style: AppTextStyles.s19W700(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<GetPicturesCubit, GetPicturesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const AppIndicator(),
                      loading: () => const AppIndicator(),
                      failed: (error) => AppErrorText(error: error),
                      success: (model) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 172,
                          ),
                          itemBuilder: (context, index) => WidgetPhotoContainer(
                            model: model[index],
                          ),
                          itemCount: model.length,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

library image_editor_plus;

import 'dart:io';
import 'dart:typed_data';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:colorfilter_generator/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:re_fotos/core/local_db.dart';
import 'package:re_fotos/feature/image_editor/image_editor_plus.dart';
import 'package:re_fotos/logic/save_image_cubit/save_image_cubit.dart';
import 'package:re_fotos/widgets/app_indicator.dart';
import 'package:re_fotos/widgets/buttom_navigator.dart';
import 'package:re_fotos/widgets/styled_toasts.dart';
import 'package:screenshot/screenshot.dart';

class OnlyFilterScreen extends StatefulWidget {
  final Uint8List image;

  /// apply each filter to given image in background and cache it to improve UX
  final bool useCache;

  const OnlyFilterScreen({
    Key? key,
    required this.image,
    this.useCache = true,
  }) : super(key: key);

  @override
  createState() => _OnlyFilterScreenState();
}

class _OnlyFilterScreenState extends State<OnlyFilterScreen> {
  late img.Image decodedImage;
  ColorFilterGenerator selectedFilter = PresetFilters.none;
  Uint8List resizedImage = Uint8List.fromList([]);
  double filterOpacity = 1;
  Uint8List filterAppliedImage = Uint8List.fromList([]);
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // decodedImage = img.decodeImage(widget.image)!;
    // resizedImage = img.copyResize(decodedImage, height: 64).getBytes();

    super.initState();
  }

  Future<String> onSave() async {
    String pathh = '';
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      final result = await screenshotController.capture();
      if (result != null) {
        final tempDir = await getTemporaryDirectory();
        File file =
            await File('${tempDir.path}/${DateTime.now()}.png').create();
        file.writeAsBytesSync(result);
        await GallerySaver.saveImage(file.path);
        pathh = file.path;
      }
    }
    return pathh;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveImageCubit(),
      child: Theme(
        data: ImageEditor.theme,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              BlocConsumer<SaveImageCubit, SaveImageState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: () {
                      showSuccessSnackBar('Saved');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavigatorScreen(),
                        ),
                        (protected) => false,
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.isLoading
                      ? const AppIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          icon: const Icon(Icons.save_alt),
                          onPressed: () async {
                            final uid = await SavedData.getUserId();
                            if (uid.isEmpty) {
                              await SavedData.setUserId();
                            }
                            final image = await onSave();
                            context.read<SaveImageCubit>().saveImage(image);
                          },
                        );
                },
              ),
            ],
          ),
          body: Center(
            child: Screenshot(
              controller: screenshotController,
              child: Stack(
                children: [
                  Image.memory(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                  FilterAppliedImage(
                    image: widget.image,
                    filter: selectedFilter,
                    fit: BoxFit.cover,
                    opacity: filterOpacity,
                    onProcess: (img) {
                      // print('processing done');
                      filterAppliedImage = img;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 160,
              child: Column(children: [
                SizedBox(
                  height: 40,
                  child: selectedFilter == PresetFilters.none
                      ? Container()
                      : selectedFilter.build(
                          Slider(
                            min: 0,
                            max: 1,
                            divisions: 100,
                            value: filterOpacity,
                            onChanged: (value) {
                              filterOpacity = value;
                              setState(() {});
                            },
                          ),
                        ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      for (int i = 0; i < presetFiltersList.length; i++)
                        filterPreviewButton(
                          filter: presetFiltersList[i],
                          name: presetFiltersList[i].name,
                        ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget filterPreviewButton({required filter, required String name}) {
    return GestureDetector(
      onTap: () {
        selectedFilter = filter;
        setState(() {});
      },
      child: Column(children: [
        Container(
          height: 64,
          width: 64,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: FilterAppliedImage(
              image: widget.image,
              filter: filter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          i18n(name),
          style: const TextStyle(fontSize: 12),
        ),
      ]),
    );
  }
}

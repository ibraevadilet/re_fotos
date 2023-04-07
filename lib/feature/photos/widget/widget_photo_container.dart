import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:re_fotos/feature/home/detail_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shimmer/shimmer.dart';

class WidgetPhotoContainer extends StatefulWidget {
  const WidgetPhotoContainer({Key? key}) : super(key: key);

  @override
  State<WidgetPhotoContainer> createState() => _WidgetPhotoContainerState();
}

class _WidgetPhotoContainerState extends State<WidgetPhotoContainer> {
  final controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailScreen(),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Screenshot(
            controller: controller,
            child: Container(
              width: 120,
              height: 172,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: "https://autodmir.ru/logo/1/2312/photo.jpg",
                placeholder: (_, url) {
                  return SizedBox(
                    width: 120,
                    height: 172,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
                imageBuilder: (_, imageProvider) {
                  return Container(
                    alignment: Alignment.topRight,
                    width: 120,
                    height: 172,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://autodmir.ru/logo/1/2312/photo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 4,
            child: IconButton(
              onPressed: () {
                onSave();
              },
              icon: const Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> onSave() async {
    String pathh = '';
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }

    if (isGranted) {
      final result = await controller.capture();
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:re_fotos/logic/model/image_model.dart';
import 'package:re_fotos/widgets/app_indicator.dart';
import 'package:re_fotos/widgets/styled_toasts.dart';
import 'package:shimmer/shimmer.dart';

class WidgetPhotoContainer extends StatefulWidget {
  const WidgetPhotoContainer({Key? key, required this.model}) : super(key: key);
  final ImageModel model;

  @override
  State<WidgetPhotoContainer> createState() => _WidgetPhotoContainerState();
}

class _WidgetPhotoContainerState extends State<WidgetPhotoContainer> {
  bool isDownload = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: 172,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.model.image,
            placeholder: (_, url) {
              return SizedBox(
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
                height: 172,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.model.image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 4,
          child: isDownload
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: const AppIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    setState(() {
                      isDownload = true;
                    });
                    await ImageDownloader.downloadImage(widget.model.image);
                    showSuccessSnackBar('Saved');
                    setState(() {
                      isDownload = false;
                    });
                  },
                  icon: const Icon(
                    Icons.save_alt,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}

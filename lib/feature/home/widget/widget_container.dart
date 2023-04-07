import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/home/detail_screen.dart';
import 'package:re_fotos/logic/model/info_model.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:shimmer/shimmer.dart';

class WidgetContainer extends StatelessWidget {
  const WidgetContainer({Key? key, required this.model}) : super(key: key);
  final InfoModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(model: model),
          ),
        );
      },
      child: Container(
        width: getWidth(context),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: model.image,
          placeholder: (_, url) {
            return SizedBox(
              width: getWidth(context),
              height: 160,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          },
          imageBuilder: (_, imageProvider) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              width: getWidth(context),
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                model.title,
                style: AppTextStyles.s19W700(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

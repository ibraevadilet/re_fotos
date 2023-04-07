import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/home/detail_screen.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:shimmer/shimmer.dart';

class WidgetContainer extends StatelessWidget {
  const WidgetContainer({Key? key}) : super(key: key);

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
      child: Container(
        width: getWidth(context),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: "https://autodmir.ru/logo/1/2312/photo.jpg",
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
                image: const DecorationImage(
                  image:
                      NetworkImage("https://autodmir.ru/logo/1/2312/photo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "How to edit photos",
                style: AppTextStyles.s19W700(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

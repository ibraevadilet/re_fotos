import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "How to edit photos",
          style: AppTextStyles.s19W700(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: "https://autodmir.ru/logo/1/2312/photo.jpg",
                placeholder: (_, url) {
                  return SizedBox(
                    width: getWidth(context),
                    height: 500,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                imageBuilder: (_, imageProvider) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    width: getWidth(context),
                    height: 500,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://autodmir.ru/logo/1/2312/photo.jpg"),
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
              const SizedBox(height: 12),
              Text(
                "The Center for Artificial Intelligence and",
                style: AppTextStyles.s15W400(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

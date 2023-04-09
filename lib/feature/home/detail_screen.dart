import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/logic/model/info_model.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.model}) : super(key: key);
  final InfoModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'How to edit photos',
          style: AppTextStyles.s19W700(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
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
                      borderRadius: BorderRadius.circular(10),
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
              const SizedBox(height: 12),
              Text(
                model.longDescription,
                style: AppTextStyles.s15W400(color: Colors.black),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/widgets/spaces.dart';
import 'package:share_plus/share_plus.dart';

class EditManuallyScreen extends StatefulWidget {
  const EditManuallyScreen({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<EditManuallyScreen> createState() => _EditManuallyScreenState();
}

class _EditManuallyScreenState extends State<EditManuallyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Edit manually",
          style: AppTextStyles.s19W700(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(widget.image);
              },
              icon: Icon(
                Icons.save_alt,
                color: Colors.black,
              ))
        ],
      ),
      body: SizedBox(
        width: getWidth(context),
        child: Image.file(
          File(widget.image),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

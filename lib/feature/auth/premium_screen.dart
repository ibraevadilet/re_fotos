import 'package:flutter/material.dart';
import 'package:re_fotos/config/app_config.dart';
import 'package:re_fotos/config/check_premium.dart';
import 'package:re_fotos/core/app_colors.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/web_view_screen.dart';
import 'package:re_fotos/widgets/buttom_navigator.dart';
import 'package:re_fotos/widgets/custom_button.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key, this.isPop = false});
  final bool isPop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Image.asset(
              AppImages.premiumImage,
            ),
            Positioned(
              right: 20,
              top: 60,
              child: IconButton(
                onPressed: () {
                  if (isPop) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigatorScreen(),
                      ),
                      (protected) => false,
                    );
                  }
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        const Spacer(),
        Text(
          '• Edit more then 3 photos',
          style: AppTextStyles.s22W700(
            color: AppColors.color029EF1Blue2,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          AppImages.noAds,
          width: 95,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: CustomButton(
            icon: AppImages.autoIcon,
            isGradient: true,
            text: 'Buy Premium for \$0.99',
            onPressed: () async {
              await CheckPremium.setSubscription();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigatorScreen(),
                ),
                (protected) => false,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewScreen(
                      url: AppConfig.privacyPolicy,
                      title: "Privacy Policy",
                    ),
                  ),
                );
              },
              child: Text(
                "privacy policy",
                style: AppTextStyles.s11W400(color: Colors.black),
              ),
            ),
            InkWell(
              child: Text(
                "restore purchases",
                style: AppTextStyles.s11W400(color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewScreen(
                      url: AppConfig.termOfUse,
                      title: "Terms of Use",
                    ),
                  ),
                );
              },
              child: Text(
                "terms of use",
                style: AppTextStyles.s11W400(color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            if (isPop) {
              Navigator.pop(context);
            }
          },
          child: Text(
            "No thanks",
            style: AppTextStyles.s15W400(color: AppColors.color029EF1Blue2),
          ),
        ),
        const Spacer(),
      ],
    ));
  }
}

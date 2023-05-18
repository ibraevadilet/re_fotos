import 'package:flutter/material.dart';
import 'package:re_fotos/utils/check_premium.dart';
import 'package:re_fotos/utils/check_restore.dart';
import 'package:re_fotos/core/app_images.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/auth/premium_screen.dart';
import 'package:re_fotos/web_view_screen.dart';
import 'package:re_fotos/widgets/custom_button.dart';

import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Settings",
                style: AppTextStyles.s19W700(color: Colors.black),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: AppLinks.privacyPolicy,
                        title: "Privacy Policy",
                      ),
                    ),
                  );
                },
                text: "Privacy policy",
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: AppLinks.termOfUse,
                        title: "Terms of Use",
                      ),
                    ),
                  );
                },
                text: "Terms of use",
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: AppLinks.supportForm,
                        title: "Support",
                      ),
                    ),
                  );
                },
                text: "Support",
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () => CheckRestore.checkRestore(context),
                text: "Restore",
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: CheckPremium.getSubscription(),
                builder: (context, AsyncSnapshot<bool?> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return const SizedBox();
                    }
                  }
                  return CustomButton(
                    icon: AppImages.autoIcon,
                    isGradient: true,
                    text: 'Buy Premium for \$0.99',
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PremiumScreen(isPop: true),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

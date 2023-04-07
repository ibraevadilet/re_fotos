import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_fotos/core/app_text_styles.dart';
import 'package:re_fotos/feature/home/widget/widget_container.dart';
import 'package:re_fotos/logic/get_info_cubit/get_info_cubit.dart';
import 'package:re_fotos/widgets/app_error_text.dart';
import 'package:re_fotos/widgets/app_indicator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInfoCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  "Main",
                  style: AppTextStyles.s19W700(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<GetInfoCubit, GetInfoState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => const AppIndicator(),
                        error: (error) => AppErrorText(error: error),
                        success: (model) => ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => WidgetContainer(
                            model: model[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: model.length,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

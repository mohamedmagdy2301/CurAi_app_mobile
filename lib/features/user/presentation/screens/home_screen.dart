import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/banner_home_widget.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/custom_appbar_home.dart';
import 'package:smartcare_app_mobile/features/user/presentation/widgets/title_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: spaceHeight(20)),
          const CustomAppBarHome(),
          SliverToBoxAdapter(child: spaceHeight(20)),
          const SliverToBoxAdapter(child: Center(child: BannerHomeWidget())),
          SliverToBoxAdapter(child: spaceHeight(20)),
          SliverToBoxAdapter(
            child: TitleSectionWidget(
              title: context.translate(LangKeys.doctorSpeciality),
            ),
          ),
          SliverToBoxAdapter(child: spaceHeight(20)),
        ],
      ),
    );
  }
}

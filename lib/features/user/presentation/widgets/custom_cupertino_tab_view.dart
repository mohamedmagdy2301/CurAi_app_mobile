import 'package:flutter/cupertino.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';

class CustomCupertinoTabView extends StatelessWidget {
  const CustomCupertinoTabView({
    required this.screenTap,
    super.key,
  });
  final Widget screenTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(child: screenTap);
      },
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

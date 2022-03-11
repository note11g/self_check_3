import 'package:flutter/cupertino.dart';
import 'package:self_check_3/resource/theme/app_color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.darkBackground,
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,
          color: AppColor.secondary,
        ),
      ),
    );
  }
}

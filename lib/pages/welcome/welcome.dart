import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/utils.dart';
import '../../common/values/values.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _buildHeadTitle() {
    return Container(
        margin: EdgeInsets.only(top: duSetHeight(60)),
        child: const Text(
          'Features',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: AppFonts.primaryFamily,
              fontWeight: FontWeight.w600,
              // duSetFontSize(24)
              fontSize: 24),
        ));
  }

  Widget _buildHeadDesc() {
    return Container(
      width: duSetWidth(242),
      height: duSetHeight(78),
      margin: EdgeInsets.only(top: duSetHeight(14)),
      child: const Text(
          'The best of news channels all in one place. Trusted sources and personalized news for you.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 1.2,
              fontFamily: AppFonts.secondaryFamily)),
    );
  }

  Widget _buildFeatureItem(String imgName, String intro, double marginTop) {
    return SizedBox(
      width: duSetWidth(295),
      height: duSetHeight(80),
      child: Row(
        children: [
          SizedBox(
            width: duSetWidth(80),
            height: duSetHeight(80),
            child: Image.asset(
              "assets/images/$imgName.png",
              fit: BoxFit.none,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: duSetWidth(195),
            child: Text(
              intro,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppFonts.secondaryFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: duSetWidth(295),
      height: duSetHeight(40),
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: MaterialButton(
        onPressed: () {},
        color: AppColors.primaryElement,
        textColor: AppColors.primaryElementText,
        shape: const RoundedRectangleBorder(
            borderRadius: Radii.k6pxRadius),
        child: const Text('Get Started'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  ScreenUtil.init(context, width: 375, height: 812 -44-34, allowFontScaling: true);
    ScreenUtil.init(context, designSize: const Size(375, 812 - 44 - 34));

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildHeadTitle(),
            _buildHeadDesc(),
            _buildFeatureItem(
                'feature-1',
                'Compelling photography and typography provide a beautiful reading',
                duSetHeight(86)),
            _buildFeatureItem(
                'feature-2',
                'Sector news never shares your personal data with advertisers or publishers',
                duSetHeight(40)),
            _buildFeatureItem(
                'feature-3',
                'You can get Premium to unlock hundreds of publications',
                duSetHeight(40)),
            const Spacer(),  // 撑开
            _buildStartButton(),
          ],
        ),
      ),
    );
  }
}

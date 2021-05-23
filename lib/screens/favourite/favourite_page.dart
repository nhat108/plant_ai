import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/configs/assets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HelpIcon extends StatefulWidget {
  @override
  _HelpIconState createState() => _HelpIconState();
}

class _HelpIconState extends State<HelpIcon>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset(
            AppAssets.background,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IntroductionPage(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController();
  Widget _buildItem({String title, String description}) {
    return Column(
      children: [
        Text(
          "$title",
          style: AppStyles.medium(size: 20, color: AppColors.secondaryColor),
        ),
        const SizedBox(
          height: 45,
        ),
        Text(
          "$description",
          textAlign: TextAlign.center,
          style: AppStyles.regular(size: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildItem(
                    title: 'Welcome!',
                    description:
                        'Your presence in my app is our honor.\nIt helps you to identify almost any plants easily.'),
                _buildItem(
                    title: 'Center!',
                    description:
                        'Take centered, will-lit photos of leaf,\nflowers, fruits!'),
                _buildItem(
                    title: 'Focus on the object!',
                    description:
                        'Make sure that the focus is on the photographed organ and not on the background of the image.'),
                _buildItem(
                    title: 'Notice!',
                    description:
                        "Don't snap plants that are too far if frame or plant not belonging to the desired species (pot, ruler, etc.)"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SmoothPageIndicator(
            controller: _pageController, // PageController
            count: 4,

            effect: SlideEffect(
              dotHeight: 10,
              dotWidth: 10,
              dotColor: AppColors.lightColor,
              activeDotColor: AppColors.primaryColor,
            ), // your preferred effect
            onDotClicked: (index) {},
          )
        ],
      ),
    );
  }
}

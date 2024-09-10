import 'package:flutter/material.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/status_bar_view.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/view/OnBoarding/boarding_tile.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<String> lstIcons = [
    "ic_onboarding1.svg",
    "ic_onboarding2.svg",
    "ic_onboarding3.svg",
  ];

  List<String> lstTitle = [
    "onBoardingTitle1",
    "onBoardingTitle1",
    "onBoardingTitle3"
  ];

  List<String> lstSubDesc = [
    "onBoardingDesc1",
    "onBoardingDesc2",
    "onBoardingDesc3"
  ];

  late PageController _pageController;
  int currentPageValue = 0;
  ValueNotifier<bool> vnIsLastIndex = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: currentPageValue, keepPage: false, viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarView(
      isLight: false,
      child: Scaffold(
        body: Builder(
          builder: (context) => Column(
            children: [
              Expanded(
                flex: 1,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: lstIcons.length,
                  onPageChanged: (int page) {
                    getChangedPageAndMoveBar(page);
                    // Log.debug("page = ${page.toString()}");
                    if (page == lstIcons.length - 1) {
                      vnIsLastIndex.value = true;
                    } else {
                      vnIsLastIndex.value = false;
                    }
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return BoardingTile(
                      iconName: lstIcons[index],
                      titleName: lstTitle[index],
                      subDescription: lstSubDesc[index],
                      isLastIndex: index == lstIcons.length - 1,
                      callback: () {
                        // _skipOrGettingStarted();
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(MAIN_PADDING),
                child: ValueListenableBuilder(
                  valueListenable: vnIsLastIndex,
                  builder: (context, value, child) => Visibility(
                    visible: vnIsLastIndex.value,
                    replacement: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.30,
                          child: ButtonView(
                            buttonTextName: buildTranslate(context, "skip"),
                            color: AppColor.appWhiteColor,
                            borderColor: AppColor.appWhiteColor,
                            style: Fonts.buttonStyle
                                .copyWith(color: AppColor.appPrimaryColor),
                            onPressed: () {
                              SharedPref.savePreferenceValue(isFirstTime, true);
                              NavigatorHelper.replace(const LoginScreen());
                            },
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.30,
                          child: ButtonView(
                            buttonTextName: buildTranslate(context, "next"),
                            style: Fonts.buttonStyle,
                            onPressed: () {
                              _next();
                            },
                          ),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SizedBox(
                        width: screenWidth * 0.45,
                        child: ButtonView(
                          buttonTextName: buildTranslate(context, "getStarted"),
                          style: Fonts.buttonStyle,
                          onPressed: () async {
                            SharedPref.savePreferenceValue(isFirstTime, true);
                            NavigatorHelper.replace(const LoginScreen());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      currentPageValue = page;
    });
  }

  void _next() {
    switch (currentPageValue) {
      case 0:
        setState(() {
          _pageController.jumpToPage(1);
        });
        break;
      case 1:
        setState(() {
          _pageController.jumpToPage(2);
        });
        break;
      case 2:
        SharedPref.savePreferenceValue(isFirstTime, true);
        NavigatorHelper.replace(const LoginScreen());
        break;
    }
  }
}

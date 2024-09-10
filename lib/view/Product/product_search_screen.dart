import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/tiles/article_tile.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Product/product_search_controller.dart';

class ProductSearchScreen extends GetView<ProductSearchController>{
  static const route = '/ProductSearchScreen';
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _AppBar(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Obx(
            () => Column(
               children: [
                 CommonWidget.getFieldSpacer(),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                   child: CustomTextField(
                     tecController: controller.searchArticleNoController,
                     focusNode: controller.fnArticle,
                     inputFormatters: [
                       LengthLimitingTextInputFormatter(100)
                     ],
                     hintText: "searchArticleNumber".translate(),
                     prefixIcon: "ic_research.svg",
                     enableSuggestions: true,
                     textInputType: TextInputType.text,
                     textInputAction: TextInputAction.search,
                     onEditingComplete: (val) {
                       if(controller.searchArticleNoController.text.trim().isNotEmpty){
                         controller.currentPage = 0;
                         controller.totalPage = 0;
                         controller.callGetArticlesListAPI(page: 1, searchQuery: val,isFromScroll: true);
                       }
                     },
                     // validator: (value) =>ValidationHelper.checkBlankValidation(context, value!),
                   ),
                 ),
                 CommonWidget.getFieldSpacer(),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                   child: CustomTextField(
                     tecController: controller.searchOEMController,
                     focusNode: controller.fnSearch,
                     inputFormatters: [
                       LengthLimitingTextInputFormatter(100)
                     ],
                     hintText: "searchOEMNumber".translate(),
                     prefixIcon: "ic_research.svg",
                     enableSuggestions: true,
                     textInputType: TextInputType.text,
                     textInputAction: TextInputAction.search,
                     onEditingComplete: (val) {
                        if(controller.searchOEMController.text.trim().isNotEmpty){
                          controller.currentPage = 0;
                          controller.totalPage = 0;
                          controller.callGetArticlesListAPI(page: 1, searchQuery: val,isFromScroll: true);
                        }
                     },
                     // validator: (value) =>ValidationHelper.checkBlankValidation(context, value!),
                   ),
                 ),
                 CommonWidget.getFieldSpacer(),

                 Expanded(
                   child: Visibility(
                     visible: controller.vnIsShowLoader.value && controller.lstArticles.isEmpty,
                     replacement: Visibility(
                       visible: controller.lstArticles.isNotEmpty,
                       replacement: Center(child:Text("dataNoAvailable".translate())),
                       child: Stack(
                         children: [
                           Padding(
                             padding: controller.vnIsShowLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                             child: ListView.builder(
                               itemCount: controller.lstArticles.length,
                               shrinkWrap: true,
                                 controller: controller.scrollController,
                                 padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                                 itemBuilder: (context, index) => Padding(
                                 padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                                 child: ArticleTile(
                                   article: controller.lstArticles[index],
                                 ),
                               )
                             ),
                           ),
                           Visibility(
                             visible: controller.vnIsShowLoader.value,
                             child: Align(
                               alignment: Alignment.bottomCenter,
                               child: CircularProgressIndicator(
                                 strokeWidth: 3.0,
                                 backgroundColor: AppColor.appPrimaryColor,
                                 valueColor: AlwaysStoppedAnimation(AppColor.appWhiteColor),
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                     child: Center(
                       child: CircularProgressIndicator(
                         strokeWidth: 3.0,
                         backgroundColor: AppColor.appPrimaryColor,
                         valueColor:
                         AlwaysStoppedAnimation(AppColor.appWhiteColor),
                       ),
                     ),
                   ),
                 )
               ],
            ),
          ),
        ),
      ),
    );
  }

}

class _AppBar extends AppBar {
  _AppBar(BuildContext context)
      : super(
    automaticallyImplyLeading: false,
    backgroundColor: context.theme.primaryColor, // Status bar color
    titleSpacing: 0.0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.back(result: true);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
          child: SvgPicture.asset(
            AssetsHelper.getSVGIcon('ic_back.svg'),
            height: 25.0,
            width: 25.0,
            colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
          ),
        ),
      ),
    ),
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Text(
        "searchProduct".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
    actions: [

    ],
  );
}
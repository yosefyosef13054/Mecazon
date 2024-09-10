import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/custom/image_picker_bottom_sheet.dart';
import 'package:mecazone/helper/dropdown_search_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/Common/province_data_model.dart';
import 'package:mecazone/view/Store/edit_store_controller.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/model/Common/municipality_data_model.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/tiles/photo_tile.dart';

class EditStoreScreen extends GetView<EditStoreController>{
  static const route = '/EditStoreScreen';
  const EditStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: _AppBar(context),
        body: WillPopScope(
          onWillPop: () async {
            Get.back(result: false);
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Obx(
                  () =>  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// : ADD YOUR STORE
                      Text(
                        "editYourStore".translate(),
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.labelLarge,
                      ),
                      CommonWidget.getFieldSpacer(height: 40.0),

                      /// : STORE NAME
                      CustomTextField(
                        tecController: controller.tecStoreNameController,
                        focusNode: controller.nodes[0],
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        hintText: 'enterStoreName'.translate(),
                        prefixIcon: "ic_store_fill.svg",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "storeNameValidation"),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : PROVINCE
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<ProvinceList>(
                          validator: (value) {
                            if (controller.selectedProvince.value.name == "") {
                              return "provinceValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)
                                ),
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "selectProvince"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecProvinceSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchProvince",
                                  hasFocused: controller.nodes[2].hasFocus
                              ),
                            ),
                            bottomSheetProps:DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                item.name.toString(),
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedProvince.value,
                          dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps:DropDownSearchHelper.getDropDownDecoratorProps(
                              context,
                              hasFocused: controller.nodes[2].hasFocus
                          ),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                                    child: Text(
                                      selectedItem!.name!,
                                      style: context.theme.textTheme.headlineMedium,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstProvince,
                          onChanged: (ProvinceList? data) {
                            controller.selectedProvince.value = data!;
                            controller.callGetMunicipalityListAPI();
                          },
                          itemAsString: (ProvinceList? c) => c!.name!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : MUNICIPALITY
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<MunicipalityList>(
                          validator: (value) {
                            if (controller.selectedMunicipality.value.name == "") {
                              return "municipalityValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                color: AppColor.appWhiteColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "selectMunicipality"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecProvinceSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchMunicipality",
                                  hasFocused: controller.nodes[3].hasFocus
                              ),
                            ),
                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                item.name.toString(),
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedMunicipality.value,
                          dropdownButtonProps:
                          DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps: DropDownSearchHelper.getDropDownDecoratorProps(
                              context,
                              hasFocused: controller.nodes[3].hasFocus
                          ),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                                    child: Text(
                                      selectedItem!.name!,
                                      style: context.theme.textTheme.headlineMedium,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstMunicipality,
                          onChanged: (MunicipalityList? data) {
                            controller.selectedMunicipality.value = data!;
                          },
                          itemAsString: (MunicipalityList? c) => c!.name!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : ADDRESS
                      CustomTextField(
                        tecController: controller.tecAddressController,
                        focusNode: controller.nodes[1],
                        inputFormatters: [LengthLimitingTextInputFormatter(250)],
                        hintText: 'enterStoreAddress'.translate(),
                        prefixIcon: "ic_location_fill.svg",
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.streetAddress,
                        validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "storeAddressValidation"),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : MOBILE NO
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.contactPersonCount.value,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 95.0,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownSearch<CountryData>(
                                    enabled: false,
                                    validator: (value) => (controller.tecStoreMobileNoController[index].text.trim().isEmpty) || (controller.tecStoreMobileNoController[index].text.trim().isNotEmpty == true)
                                        ? ValidationHelper.checkMobileNoValidation(context, controller.tecStoreMobileNoController[index].text,validationMsg: "")
                                        : null,
                                    popupProps: PopupProps.bottomSheet(
                                      showSearchBox: false,
                                      title: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0)
                                          ),
                                          color: AppColor.appWhiteColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                                        width: MediaQuery.of(context).size.width,
                                        height: 70.0,
                                        child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseCountry"),
                                      ),
                                      searchFieldProps: TextFieldProps(
                                        style: context.theme.textTheme.headlineSmall,
                                        controller: controller.tecCountryCodeInputController[index],
                                        decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                            hintText: "searchCountry",
                                            hasFocused: false
                                        ),
                                      ),
                                      bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                                      itemBuilder: (context, item, isSelected) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                                        child: Text(
                                          " +${item.countryCode!} ${item.countryName!}",
                                          style: context.theme.textTheme.bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    selectedItem: controller.selectedCountry.value,
                                    dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                                    dropdownDecoratorProps: DropDownSearchHelper.getDropDownDecoratorProps(context,hasFocused:false /*fnSearchCountry.hasFocus*/),
                                    dropdownBuilder: (context, selectedItem) {
                                      return SizedBox(
                                        height: 35.0,
                                        child: Center(
                                          child: Text(
                                            "+${controller.tecCountryCodeInputController[index].text}",
                                            style: context.theme.textTheme.headlineMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                    items: controller.lstCountry,
                                    onChanged: (CountryData? data) {
                                      controller.selectedCountry.value = data!;
                                      controller.tecCountryCodeInputController[index].text =
                                      data.countryCode!;
                                    },
                                    itemAsString: (CountryData? c) => " +${c!.countryCode!} ${c.countryName!}",
                                  ),
                                ),
                              ),
                              CommonWidget.getFieldSpacer(width: 5.0),
                              Expanded(
                                child: CustomTextField(
                                    tecController: controller.tecStoreMobileNoController[index],
                                    focusNode: controller.fnMobileNo[index],
                                    textInputType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      FilteringTextInputFormatter.allow(Regex.onlyDigits)
                                    ],
                                    prefixIcon: "ic_call.svg",
                                    hintText: "enterMobileNo".translate(),
                                    validator: (value) => (controller.tecStoreMobileNoController[index].text.trim().isEmpty) || (value?.trim().isNotEmpty == true)
                                        ? ValidationHelper.checkMobileNoValidation(context, value ?? '')
                                        : null
                                ),
                              ),
                              CommonWidget.getFieldSpacer(width: 5.0),
                              Container(
                                height: 45.0,
                                width: 45.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(CARD_RADIUS_NORMAL),
                                  border: Border.all(
                                      color: context.theme.primaryColor, width: 1.0),
                                  color: context.theme.canvasColor,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (index == 0) {
                                      controller.addNewContactPerson(context);
                                    } else {
                                      controller.removeContactPerson(index);
                                    }
                                  },
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AssetsHelper.getSVGIcon(index == 0 ? 'ic_add_fill.svg' : 'ic_minus.svg'),
                                      height: 25.0,
                                      width: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// : DESCRIPTION
                      CustomTextField(
                        tecController: controller.tecDescriptionController,
                        focusNode: controller.nodes[4],
                        inputFormatters: [LengthLimitingTextInputFormatter(1500)],
                        hintText: 'enterStoreDescription'.translate(),
                        prefixIcon: "ic_description.svg",
                        maxLines: 5,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "storeDecsValidation"),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : STORE IS VISIBLE
                      LayoutBuilder(
                        builder: (context, constraints) => Obx(
                              () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "yourStoreIsHide".translate(),
                                  style: context.theme.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              CommonWidget.getFieldSpacer(width: 2.0),
                              ButtonView(
                                buttonTextName: "yes".translate(),
                                width: 60,
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: controller.vnIsShowStoreAddress.value
                                      ? context.theme.primaryColor
                                      : context.theme.primaryColorLight,
                                ),
                                borderRadius: 10.0,
                                color: controller.vnIsShowStoreAddress.value
                                    ? context.theme.canvasColor
                                    : context.theme.unselectedWidgetColor,
                                borderColor: controller.vnIsShowStoreAddress.value
                                    ? context.theme.primaryColor
                                    : context.theme.unselectedWidgetColor,
                                onPressed: () {
                                  controller.changeStoreActiveOrHide();
                                },
                              ),
                              CommonWidget.getFieldSpacer(width: 5.0),
                              ButtonView(
                                buttonTextName: "no".translate(),
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: !controller.vnIsShowStoreAddress.value
                                      ? context.theme.primaryColor
                                      : context.theme.primaryColorLight,
                                ),
                                borderRadius: 10.0,
                                width: 60,
                                color: !controller.vnIsShowStoreAddress.value
                                    ? context.theme.canvasColor
                                    : context.theme.unselectedWidgetColor,
                                borderColor: !controller.vnIsShowStoreAddress.value
                                    ? context.theme.primaryColor
                                    : context.theme.unselectedWidgetColor,
                                onPressed: () {
                                  controller.changeStoreActiveOrHide();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : AVAILABLE FOR DELIVERY
                      LayoutBuilder(
                        builder: (context, constraints) => Obx(
                              () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "availableDelivery".translate(),
                                  style: context.theme.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              CommonWidget.getFieldSpacer(width: 2.0),
                              ButtonView(
                                buttonTextName: "yes".translate(),
                                width: 60,
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: controller.vnIsAvailableDelivery.value
                                      ? context.theme.primaryColor
                                      : context.theme.primaryColorLight,
                                ),
                                borderRadius: 10.0,
                                color: controller.vnIsAvailableDelivery.value
                                    ? context.theme.canvasColor
                                    : context.theme.unselectedWidgetColor,
                                borderColor: controller.vnIsAvailableDelivery.value
                                    ? context.theme.primaryColor
                                    : context.theme.unselectedWidgetColor,
                                onPressed: () {
                                  controller.changeStoreAvailableOrNot();
                                },
                              ),
                              CommonWidget.getFieldSpacer(width: 5.0),
                              ButtonView(
                                buttonTextName: "no".translate(),
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: !controller.vnIsAvailableDelivery.value? context.theme.primaryColor
                                      : context.theme.primaryColorLight,
                                ),
                                borderRadius: 10.0,
                                width: 60,
                                color: !controller.vnIsAvailableDelivery.value ? context.theme.canvasColor
                                    : context.theme.unselectedWidgetColor,
                                borderColor: !controller.vnIsAvailableDelivery.value ? context.theme.primaryColor
                                    : context.theme.unselectedWidgetColor,
                                onPressed: () {
                                  controller.changeStoreAvailableOrNot();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : ADD STORE PICTURES
                      SizedBox(
                        width: screenWidth,
                        child: Text(
                            "addStorePictures".translate(),
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.displayLarge
                        ),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.vnStoreImgLength.value + 1,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              itemBuilder: (context, index) {
                                if (index + 1 > controller.vnLstProjectPhotos.value.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 120,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          if (controller.vnStoreImgLength.value + 1 > 3) {
                                            AlertHelper.showToast("maxPhotosValidation".translate());
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ImagePickerBottomSheet(
                                                      callBackImages:(XFile file) {
                                                        if (file.path.isNotEmpty) {
                                                          controller.vnLstProjectPhotos.value.add(file.path);
                                                          controller.vnStoreImgLength.value = controller.vnLstProjectPhotos.value.length;
                                                        }
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(context.theme.canvasColor),
                                            elevation: MaterialStateProperty.all(0.0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
                                                side: BorderSide(width: 1.0,color:context.theme.primaryColor),
                                              ),
                                            )),
                                        icon: SvgPicture.asset(
                                          AssetsHelper.getSVGIcon('ic_add_fill.svg'),
                                          height: 25.0,
                                        ),
                                        label: Text(
                                            "add".translate(),
                                            style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor)),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: PhotoTile(
                                      imageName: controller.vnLstProjectPhotos.value[index],
                                      isRemoveOption: true,
                                      onPressed: () {
                                        controller.vnLstProjectPhotos.value.removeAt(index);
                                        controller.vnStoreImgLength.value--;
                                      },
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : BRANDS
                      SizedBox(
                        width: screenWidth,
                        child: Text(
                            "brands".translate(),
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.displayLarge
                        ),
                      ),
                      Visibility(
                        visible: !controller.vnIsBrandLoader.value,
                        replacement:CircularProgressIndicator(
                          strokeWidth: 3.0,
                          backgroundColor: context.theme.primaryColor,
                          valueColor: AlwaysStoppedAnimation(context.theme.scaffoldBackgroundColor),
                        ),
                        child: SizedBox(
                          height: controller.lstBrand.length >= 5 ? 165 : 120,
                          child: RawScrollbar(
                            thumbColor: context.theme.primaryColor,
                            radius: const Radius.circular(CARD_RADIUS_NORMAL),
                            thickness: 3,
                            interactive: true,
                            thumbVisibility: true,
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 50,
                                crossAxisSpacing: SMALL_PADDING_12,
                                mainAxisSpacing: SMALL_PADDING_12,
                              ),
                              itemCount: controller.lstBrand.length,
                              itemBuilder: (context, index) => SizedBox(
                                  height: 50.0,
                                  width: screenWidth * 0.45,
                                  child: Obx(
                                        () => InkWell(
                                      onTap: () {
                                        controller.changeBrandSelection(index);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child: Visibility(
                                              visible: controller.lstBrand[index].isSelected!.value,
                                              replacement: SvgPicture.asset(
                                                  AssetsHelper.getSVGIcon('ic_radio.svg'),
                                                  height: 25.0,
                                                  width: 25.0,
                                                  colorFilter: ColorFilter.mode(
                                                      context.theme.primaryColorLight,
                                                      BlendMode.srcIn
                                                  )
                                              ),
                                              child: SvgPicture.asset(
                                                AssetsHelper.getSVGIcon('ic_radio_fill.svg'),
                                                height: 25.0,
                                                width: 25.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomMarqueeWidget(
                                              child: Text(
                                                controller.lstBrand[index].brandName ?? "",
                                                style: context.theme.textTheme.bodyLarge,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),

                      /// : EDIT STORE BTN
                      ButtonView(
                        buttonTextName: buildTranslate(context, "editStore"),
                        color: context.theme.primaryColor,
                        borderColor: context.theme.primaryColor,
                        rxIsShowLoader: controller.vnIsShowLoader,
                        onPressed: () {
                          if (controller.vnIsShowLoader.value != true) {
                            controller.callEditStoreAPI();
                          }
                        },
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),
                    ],
                  ),
                ),
              )
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
    titleSpacing: 0.0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              NavigatorHelper.remove();
            },
            child: SvgPicture.asset(
              AssetsHelper.getSVGIcon('ic_back_round.svg'),
              height: 40.0,
              width: 40.0,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: context.theme.scaffoldBackgroundColor,
  );
}
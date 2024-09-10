import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/Product/model_type_data_model.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Request/edit_request_controller.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/custom/keyboard_hide_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/dialog_helper.dart';
import 'package:mecazone/helper/dropdown_search_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Product/manufacturer_data_model.dart';
import 'package:mecazone/model/Product/model_data_model.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/common_widget.dart';

class EditRequestScreen extends GetView<EditRequestController> {
  static const route = '/EditRequestScreen';

  const EditRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _AppBar(context),
      body: KeyboardHideView(
        child: Obx(() => WillPopScope(
              onWillPop: () async {
                NavigatorHelper.remove(value: true);
                return true;
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// : PRODUCT NAME *
                      CustomTextField(
                        tecController: controller.tecNameController,
                        focusNode: controller.fnName,
                        inputFormatters: [LengthLimitingTextInputFormatter(100)],
                        hintText: 'productName'.translate(),
                        prefixIcon: "ic_product.svg",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "productNameValidation"),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : BRAND DROP DOWN *
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<BrandList>(
                          enabled: true,
                          validator: (value) {
                            if (controller.selectedBrands.value.brandName == "") {
                              return "selectBrandValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseBrand"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecBrandSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchBrand",
                                  hasFocused: controller.fnSearchBrand.hasFocus
                              ),
                            ),
                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                "${item.brandName}",
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedBrands.value,
                          dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps: DropDownSearchHelper.getDropDownDecoratorProps(context, hasFocused: controller.fnSearchBrand.hasFocus),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: SvgPicture.asset(
                                      AssetsHelper.getSVGIcon('ic_brand.svg'),
                                      height: 20.0,
                                      colorFilter: ColorFilter.mode(context.theme.primaryColorLight, BlendMode.srcIn)
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                        selectedItem != null ? "${selectedItem.brandName}" : "chooseBrand".translate(),
                                        style: selectedItem != null ? context.theme.textTheme.headlineMedium : context.theme.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstBrand,
                          onChanged: (BrandList? data) {
                            controller.selectedBrands.value = data!;
                            controller.tecBrandNameController.text = data.brandName ?? "";
                            controller.onChangeBrand();
                          },
                          itemAsString: (BrandList? b) => b!.brandName!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : OTHER BRAND NAME
                      Visibility(
                        visible: controller.vnIsShowOtherBrand.value,
                        child: Column(
                          children: [
                            CustomTextField(
                              tecController: controller.tecBrandNameController,
                              focusNode: controller.fnBrandName,
                              inputFormatters: [LengthLimitingTextInputFormatter(100)],
                              hintText: 'brand'.translate(),
                              prefixIcon: "ic_brand.svg",
                              iconHeight: 15.0,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              validator: (value) {
                                if (controller.selectedBrands.value.brandId == 0 && value!.trim().isEmpty) {
                                  return ValidationHelper.checkBlankValidation(context, value, "brandNameValidation");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CommonWidget.getFieldSpacer(height: 15.0),
                          ],
                        ),
                      ),

                      /// : MODEL DROP DOWN *
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<ModelList>(
                          enabled: true,
                          validator: (value) {
                            if (controller.selectedModel.value.modelName == "") {
                              return "selectModelValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseModel"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecModelSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchModel",
                                  hasFocused: controller.fnSearchModel.hasFocus
                              ),
                            ),
                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                "${item.modelName}",
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedModel.value,
                          dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps:
                          DropDownSearchHelper.getDropDownDecoratorProps(context, hasFocused: controller.fnSearchModel.hasFocus),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_12),
                                    child: SvgPicture.asset(
                                      AssetsHelper.getSVGIcon('ic_model.svg'),
                                      height: 20.0,
                                      colorFilter: ColorFilter.mode(context.theme.primaryColorLight, BlendMode.srcIn)
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                        selectedItem != null ? "${selectedItem.modelName}" : "chooseModel".translate(),
                                        style: selectedItem != null ? context.theme.textTheme.headlineMedium : context.theme.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstModel,
                          onChanged: (ModelList? data) {
                            controller.selectedModel.value = data!;
                            controller.tecModelNameController.text = data.modelName ?? "";
                            controller.onChangeModel();
                          },
                          itemAsString: (ModelList? m) => m!.modelName!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : OTHER MODEL NAME
                      Visibility(
                        visible: controller.vnIsShowOtherModel.value,
                        child: Column(
                          children: [
                            CustomTextField(
                              tecController: controller.tecModelNameController,
                              focusNode: controller.fnModelName,
                              inputFormatters: [LengthLimitingTextInputFormatter(100)],
                              hintText: 'model'.translate(),
                              prefixIcon: "ic_model.svg",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              validator: (value) {
                                if (controller.selectedModel.value.modelId == 0 && value!.trim().isEmpty) {
                                  return ValidationHelper.checkBlankValidation(context, value, "modelNameValidation");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CommonWidget.getFieldSpacer(height: 15.0),
                          ],
                        ),
                      ),

                      /// : MODEL TYPE DROP DOWN *
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<ModelTypeList>(
                          enabled: true,
                          validator: (value) {
                            if (controller.selectedModelType.value.typeName == "") {
                              return "selectModelTypeValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseModelType"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecModelTypeSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchModelType",
                                  hasFocused: controller.fnSearchModelType.hasFocus
                              ),
                            ),
                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                "${item.typeName}",
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedModelType.value,
                          dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps:
                          DropDownSearchHelper.getDropDownDecoratorProps(context, hasFocused: controller.fnSearchModel.hasFocus),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_12),
                                    child: SvgPicture.asset(
                                      AssetsHelper.getSVGIcon('ic_model.svg'),
                                      height: 20.0,
                                      colorFilter: ColorFilter.mode(context.theme.primaryColorLight, BlendMode.srcIn)
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                        selectedItem != null ? "${selectedItem.typeName}" : "chooseModelType".translate(),
                                        style: selectedItem != null ? context.theme.textTheme.headlineMedium : context.theme.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstModelType,
                          onChanged: (ModelTypeList? data) {
                            controller.selectedModelType.value = data!;
                            controller.tecModelTypeNameController.text = data.typeName ?? "";
                            controller.onChangeModelType();
                          },
                          itemAsString: (ModelTypeList? m) => m!.typeName!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : OTHER MODEL TYPE NAME
                      Visibility(
                        visible: controller.vnIsShowOtherModelType.value,
                        child: Column(
                          children: [
                            CustomTextField(
                              tecController: controller.tecModelTypeNameController,
                              focusNode: controller.fnModelTypeName,
                              inputFormatters: [LengthLimitingTextInputFormatter(100)],
                              hintText: 'modelType'.translate(),
                              prefixIcon: "ic_model.svg",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              validator: (value) {
                                if (controller.selectedModelType.value.id == 0 && value!.trim().isEmpty) {
                                  return ValidationHelper.checkBlankValidation(context, value, "modelTypeNameValidation");
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CommonWidget.getFieldSpacer(height: 15.0),
                          ],
                        ),
                      ),

                      /// : YEAR *
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime dateTime = DateTime(int.parse(controller.tecYearController.text));
                          DialogHelper.showYearPickerDialog(context, dateTime, (p0) {
                            controller.tecYearController.text = p0.year.toString();
                          });
                        },
                        child: CustomTextField(
                          tecController: controller.tecYearController,
                          focusNode: controller.fnYear,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.allow(Regex.onlyDigits)
                          ],
                          hintText: 'year'.translate(),
                          prefixIcon: "ic_calendar.svg",
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "yearValidation"),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : OE REFERENCE NUMBER
                      CustomTextField(
                        tecController: controller.tecOeReferenceNoController,
                        focusNode: controller.fnOeReferenceNo,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        hintText: 'oeReferenceNo'.translate(),
                        prefixIcon: "ic_description.svg",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : MANUFACTURER DROP DOWN
                      DropdownButtonHideUnderline(
                        child: DropdownSearch<ManufacturerData>(
                          enabled: true,
                          validator: (value) {
                            if (controller.selectedManufacturer.value.mfrName == "") {
                              return "selectManufacturerValidation".translate();
                            } else {
                              return null;
                            }
                          },
                          popupProps: PopupProps.bottomSheet(
                            showSearchBox: true,
                            title: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseManufacturer"),
                            ),
                            searchFieldProps: TextFieldProps(
                              style: context.theme.textTheme.headlineSmall,
                              controller: controller.tecManufacturerSearchController,
                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                  hintText: "searchManufacturer",
                                  hasFocused: controller.fnSearchManufacturer.hasFocus
                              ),
                            ),
                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: MAIN_PADDING),
                              child: Text(
                                "${item.mfrName}",
                                style: context.theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          selectedItem: controller.selectedManufacturer.value,
                          dropdownButtonProps: DropDownSearchHelper.getDropDownButtonProps(),
                          dropdownDecoratorProps:
                          DropDownSearchHelper.getDropDownDecoratorProps(context, hasFocused: controller.fnSearchManufacturer.hasFocus),
                          dropdownBuilder: (context, selectedItem) {
                            return SizedBox(
                              height: 35.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: SvgPicture.asset(
                                      AssetsHelper.getSVGIcon('ic_brand.svg'),
                                      height: 20.0,
                                      colorFilter: ColorFilter.mode(context.theme.primaryColorLight, BlendMode.srcIn)
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                        selectedItem != null ? "${selectedItem.mfrName}" : "chooseManufacturer".translate(),
                                        style: selectedItem != null ? context.theme.textTheme.headlineMedium : context.theme.textTheme.headlineSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          items: controller.lstManufacturer,
                          onChanged: (ManufacturerData? data) {
                            controller.selectedManufacturer.value = data!;
                            controller.tecManufacturerNameController.text = data.mfrName ??"";
                            if (controller.selectedManufacturer.value.id != 0) {
                              controller.vnIsShowOtherManufacturer.value = false;
                            } else {
                              controller.vnIsShowOtherManufacturer.value = true;
                            }
                          },
                          itemAsString: (ManufacturerData? m) => m!.mfrName!,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : OTHER MANUFACTURER NAME
                      Visibility(
                        visible: controller.vnIsShowOtherManufacturer.value,
                        child: Column(
                          children: [
                            CustomTextField(
                              tecController: controller.tecManufacturerNameController,
                              focusNode: controller.fnManufacturer,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100)
                              ],
                              validator: (value) {
                                if (controller.selectedManufacturer.value.id == 0 && value!.trim().isEmpty) {
                                  return ValidationHelper.checkBlankValidation(context, value, "manufacturerNameValidation");
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'manufacturer'.translate(),
                              prefixIcon: "ic_brand.svg",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                            ),
                            CommonWidget.getFieldSpacer(height: 15.0),
                          ],
                        ),
                      ),

                      /// : MOBILE NO *
                      Row(
                        children: [
                          SizedBox(
                            width: 95.0,
                            child: DropdownButtonHideUnderline(
                              child: DropdownSearch<CountryData>(
                                enabled: false,
                                validator: (value) => (controller.tecMobileNoController.text.trim().isEmpty) || (controller.tecMobileNoController.text.trim().isNotEmpty == true)
                                    ? ValidationHelper.checkMobileNoValidation(context, controller.tecMobileNoController.text,validationMsg: "")
                                    : null,
                                popupProps: PopupProps.bottomSheet(
                                  showSearchBox: true,
                                  title: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)),
                                        color: context.theme.scaffoldBackgroundColor,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                                      width: MediaQuery.of(context).size.width,
                                      height: 70.0,
                                      child: DropDownSearchHelper.getBottomSheetHeaderLayout(titleName: "chooseCountry"),
                                  ),
                                  searchFieldProps: TextFieldProps(
                                    style: context.theme.textTheme.headlineSmall,
                                    controller: controller.tecCountrySearchController,
                                    decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                        hintText: "searchCountry",
                                        hasFocused: controller.fnSearchCountry.hasFocus
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
                                dropdownButtonProps:
                                DropDownSearchHelper.getDropDownButtonProps(),
                                dropdownDecoratorProps:
                                DropDownSearchHelper.getDropDownDecoratorProps(
                                    context,
                                    hasFocused: controller.fnSearchCountry.hasFocus),
                                dropdownBuilder: (context, selectedItem) {
                                  return SizedBox(
                                    //Why the height??
                                    height: 35.0,
                                    child: Center(
                                      child: Text(
                                        selectedItem != null
                                            ? "+${selectedItem.countryCode}"
                                            : " + ",
                                        style: context.theme.textTheme.headlineMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                                items: controller.lstCountry,
                                onChanged: (CountryData? data) {
                                  // controller.selectedCountry.value = data;
                                  controller.selectedCountry(data);
                                },
                                itemAsString: (CountryData? c) => " +${c!.countryCode!} ${c.countryName!}",
                              ),
                            ),
                          ),
                          CommonWidget.getFieldSpacer(width: 5.0),
                          Expanded(
                            child: CustomTextField(
                                tecController: controller.tecMobileNoController,
                                focusNode: controller.fnMobileNo,
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                  FilteringTextInputFormatter.allow(Regex.onlyDigits)
                                ],
                                prefixIcon: "ic_call.svg",
                                hintText: "enterMobileNo".translate(),
                                validator: (value) => (controller.tecMobileNoController.text.trim().isEmpty) || (value?.trim().isNotEmpty == true)
                                    ? ValidationHelper.checkMobileNoValidation(context, value ?? '')
                                    : null
                            ),
                          )
                        ],
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),

                      /// : DESCRIPTION
                      CustomTextField(
                          tecController: controller.tecDescriptionController,
                          focusNode: controller.fnDescription,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1500)
                          ],
                          hintText: 'requestDescription'.translate(),
                          prefixIcon: "ic_description.svg",
                          maxLines: 5,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),

                      /// : EDIT REQUEST BTN
                      ButtonView(
                        buttonTextName: "editRequest".translate(),
                        color: AppColor.appPrimaryColor,
                        borderColor: AppColor.appPrimaryColor,
                        rxIsShowLoader: controller.vnIsShowLoader,
                        onPressed: () {
                          if (controller.vnIsShowLoader.value != true) {
                            controller.callEditRequestAPI(context);
                          }
                        },
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),
                    ],
                  ),
                ),
              ),
            )),
      ),
    ));
  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context)
      : super(
    automaticallyImplyLeading: false,
    backgroundColor: AppColor.appPrimaryColor,
    // Status bar color
    titleSpacing: 0.0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          NavigatorHelper.remove(value: true);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
          child: SvgPicture.asset(
            AssetsHelper.getSVGIcon('ic_back.svg'),
            height: 25.0,
            width: 25.0,
            colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn)
          ),
        ),
      ),
    ),
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Text(
        "editRequest".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.displayLarge?.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/borders.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController tecController;
  final FocusNode focusNode;
  final FormFieldValidator<String>? validator;
  final String hintText, prefixIcon, suffixIcon;
  final double? iconHeight;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters = [];
  bool? enableSuggestions = false;
  bool isShowPrefixIcon, isShowSuffixIcon, isSearchField;
  final int? maxLines;
  final int? minLines;
  bool? isPassword = false;
  final Function? onEditingComplete;
  final Function? onChanged;

  CustomTextField(
      {Key? key,
      required this.tecController,
      required this.focusNode,
      required this.hintText,
      this.prefixIcon="",
      this.suffixIcon="",
      this.iconHeight,
      this.validator,
      this.inputFormatters,
      this.textInputType,
      this.enableSuggestions,
      this.isShowPrefixIcon = true,
      this.isShowSuffixIcon = false,
      this.isSearchField = false,
      this.textInputAction,
      this.maxLines,
      this.minLines,
      this.onEditingComplete,
      this.onChanged,
      this.isPassword = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  RxBool rxHasFocus = false.obs, rxShowText = true.obs;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _onFocusChange();
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  _onFocusChange() {
    rxHasFocus(!rxHasFocus.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.none,
          controller: widget.tecController,
          keyboardType: widget.textInputType ?? TextInputType.emailAddress,
          style: context.theme.textTheme.headlineMedium,
          autocorrect: true,
          enableSuggestions: widget.enableSuggestions ?? true,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.isPassword == true ? rxShowText.value : false,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          textAlignVertical: TextAlignVertical.center,
          onEditingComplete: (){
            widget.onEditingComplete!();
          },
          onFieldSubmitted: (value) {
            widget.onEditingComplete!(value);
          },
          onChanged: (value){
            if( widget.isSearchField && (value.length >=3 || value.isEmpty)){
              widget.onChanged!(value);
            }
          },
          decoration: InputDecoration(
              filled: true,
              fillColor: rxHasFocus.value
                  ? context.theme.canvasColor
                  : Get.isDarkMode ? context.theme.canvasColor : context.theme.unselectedWidgetColor,
              hintText: widget.hintText,
              hintStyle: context.theme.textTheme.headlineSmall,
              errorStyle: context.theme.textTheme.labelSmall,
              contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              prefixIcon: widget.isShowPrefixIcon ? Padding(
                padding: const EdgeInsets.only(top: 15, left: 5, right: 0, bottom: 15),
                child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon(widget.prefixIcon),
                  height: widget.iconHeight,
                  colorFilter: ColorFilter.mode(rxHasFocus.value ? context.theme.primaryColorDark : context.theme.primaryColorLight, BlendMode.srcIn)
                ),
              ) : null,
              suffixIcon: (widget.isPassword == true)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 5, right: 0, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          rxShowText(!rxShowText.value);
                        },
                        child: SvgPicture.asset(
                          rxShowText.value
                              ? AssetsHelper.getSVGIcon('ic_eye_off.svg')
                              : AssetsHelper.getSVGIcon('ic_eye.svg'),
                            colorFilter: ColorFilter.mode(rxHasFocus.value ? context.theme.primaryColorDark
                                : context.theme.primaryColorLight, BlendMode.srcIn)
                        ),
                      ),
                    )
                  : widget.isShowSuffixIcon  ? Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 5, right: 5, bottom: 15),
                child: InkWell(
                  onTap: () {
                    widget.onEditingComplete!();
                  },
                  child: SvgPicture.asset(
                      AssetsHelper.getSVGIcon(widget.suffixIcon),
                      colorFilter: ColorFilter.mode(rxHasFocus.value ? context.theme.primaryColorDark : context.theme.primaryColorLight, BlendMode.srcIn)
                  ),
                ),
              ) : null,
              focusedBorder: Borders.focusBorder,
              focusedErrorBorder: Borders.focusBorder,
              enabledBorder: Borders.enableBorder,
              disabledBorder: Borders.disableBorder,
              errorBorder: Borders.errorBorder),
        ));
  }
}

import 'package:get/get.dart';
import 'package:mecazone/localization/language_settings.dart';

extension StringUtils on String {
  String translate() => buildTranslate(Get.context!, this);
  String firstCapitalize() => "${this[0].toUpperCase()}${substring(1)}";
}

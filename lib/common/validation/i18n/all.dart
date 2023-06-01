import '../form_validator.dart';
import 'vi.dart';

const localeMap = <String, FormValidator>{
  'vi': LocaleVi(),
};

final supportedLocales = localeMap.keys.toList();

FormValidator createLocale(String locale) {
  if (locale == 'default') locale = 'vi';

  final result = localeMap[locale];
  if (result != null) return result;

  throw ArgumentError.value(
    locale,
    'locale',
    'Form validation locale is not yet supported.',
  );
}

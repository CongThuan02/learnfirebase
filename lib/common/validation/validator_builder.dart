import 'form_validator.dart';
import 'i18n/all.dart';
import 'validators.dart' as validators;

typedef StringValidationCallback = String? Function(String? value);
typedef Action<T> = Function(T builder);

class ValidationBuilder {
  final bool optional;
  final String? requiredMessage;
  final FormValidator _locale;
  final String filed;
  final List<StringValidationCallback> validations = [];

  static FormValidator globalLocale = createLocale('default');
  static void setLocale(String localeName) {
    globalLocale = createLocale(localeName);
  }

  /// Adds new item to [validations] list, returns this instance
  ValidationBuilder add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  /// Clears validation list and adds required validation if
  /// [optional] is false
  ValidationBuilder reset() {
    validations.clear();
    if (optional != true) {
      required(requiredMessage);
    }
    return this;
  }

  ValidationBuilder({
    String? localeName,
    this.optional = false,
    FormValidator? locale,
    this.requiredMessage,
    this.filed = "",
  }) : _locale = locale ??
            (localeName == null ? globalLocale : createLocale(localeName)) {
    ArgumentError.checkNotNull(_locale, 'locale');
    // Unless a builder is optional, the first thing we do is to add a
    // [required] validator. All subsequent validators should expect
    // a non-null argument.
    if (!optional) required(requiredMessage);
  }

  /// Tests [value] against defined [validations]
  String? test(String? value) {
    for (var validate in validations) {
      // Return null if field is optional and value is null
      if (optional && (value == null || value.isEmpty)) {
        return null;
      }

      // Otherwise execute validations
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// Returns a validator function for FormInput
  StringValidationCallback build() => test;

  /// Throws error only if [left] and [right] validators throw error same time.
  /// If [reverse] is true left builder's error will be displayed otherwise
  /// right builder's error. Because this is default behaviour on most of the
  /// programming languages.
  ValidationBuilder or(
    Action<ValidationBuilder> left,
    Action<ValidationBuilder> right, {
    bool reverse = false,
  }) {
    // Create
    final v1 = ValidationBuilder(locale: _locale);
    final v2 = ValidationBuilder(locale: _locale);

    // Configure
    left(v1);
    right(v2);

    // Build
    final v1cb = v1.build();
    final v2cb = v2.build();

    // Test
    return add((value) {
      final leftResult = v1cb(value);
      if (leftResult == null) {
        return null;
      }
      final rightResult = v2cb(value);
      if (rightResult == null) {
        return null;
      }
      return reverse == true ? leftResult : rightResult;
    });
  }

  /// Value must not be null
  ValidationBuilder required([String? message]) => add((v) =>
      v == null || v.isEmpty ? message ?? _locale.required(filed) : null);

  /// Value length must be greater than or equal to [minLength]
  ValidationBuilder minLength(int minLength, [String? message]) =>
      add((v) => v!.length < minLength
          ? message ?? _locale.minLength(filed, v, minLength)
          : null);

  /// Value length must be less than or equal to [maxLength]
  ValidationBuilder maxLength(int maxLength, [String? message]) =>
      add((v) => v!.length > maxLength
          ? message ?? _locale.maxLength(filed, v, maxLength)
          : null);

  /// Value must match [regExp]
  ValidationBuilder regExp(RegExp regExp, String message) =>
      add((v) => regExp.hasMatch(v!) ? null : message);

  /// Value must be a well formatted email
  ValidationBuilder email([String? message]) => add((v) =>
      validators.isEmail(v!) ? null : message ?? _locale.email(filed, v));

  /// Value must be a well formatted phone number
  ValidationBuilder phone([String? message]) => add((v) =>
      validators.isPhone(v!) ? null : message ?? _locale.phoneNumber(filed, v));

  /// Value must be a well formatted IPv4 address
  ValidationBuilder ip([String? message]) => add(
      (v) => validators.isIP(v!, 4) ? null : message ?? _locale.ip(filed, v));

  /// Value must be a well formatted IPv6 address
  ValidationBuilder ipv6([String? message]) => add(
      (v) => validators.isIP(v!, 6) ? null : message ?? _locale.ipv6(filed, v));

  /// Value must be a well formatted URL address
  ValidationBuilder url([String? message]) => add(
      (v) => validators.isURL(v!) ? null : message ?? _locale.url(filed, v));

  ValidationBuilder fqdn([String? message]) => add(
      (v) => validators.isFQDN(v!) ? null : message ?? _locale.fqdn(filed, v));

  ValidationBuilder alpha([String? message]) => add((v) =>
      validators.isAlpha(v!) ? null : message ?? _locale.alpha(filed, v));

  ValidationBuilder numeric([String? message]) => add((v) =>
      validators.isNumeric(v!) ? null : message ?? _locale.numeric(filed, v));

  ValidationBuilder alphanumeric([String? message]) =>
      add((v) => validators.isAlphanumeric(v!)
          ? null
          : message ?? _locale.alphanumeric(filed, v));

  ValidationBuilder base64([String? message]) => add((v) =>
      validators.isBase64(v!) ? null : message ?? _locale.base64(filed, v));

  ValidationBuilder isInt([String? message]) => add(
      (v) => validators.isInt(v!) ? null : message ?? _locale.isInt(filed, v));

  ValidationBuilder isFloat([String? message]) => add((v) =>
      validators.isFloat(v!) ? null : message ?? _locale.isFloat(filed, v));

  ValidationBuilder hexadecimal([String? message]) =>
      add((v) => validators.isHexadecimal(v!)
          ? null
          : message ?? _locale.hexadecimal(filed, v));

  ValidationBuilder hexColor([String? message]) => add((v) =>
      validators.isHexColor(v!) ? null : message ?? _locale.hexColor(filed, v));

  ValidationBuilder lowercase([String? message]) =>
      add((v) => validators.isLowercase(v!)
          ? null
          : message ?? _locale.lowercase(filed, v));

  ValidationBuilder uppercase([String? message]) =>
      add((v) => validators.isUppercase(v!)
          ? null
          : message ?? _locale.uppercase(filed, v));

  ValidationBuilder divisibleBy(int n, [String? message]) =>
      add((v) => validators.isDivisibleBy(v!, n)
          ? null
          : message ?? _locale.divisibleBy(filed, v, n));

  ValidationBuilder isNull([String? message]) => add((v) =>
      validators.isNull(v!) ? null : message ?? _locale.isNull(filed, v));

  ValidationBuilder length(int n, [String? message]) =>
      add((v) => validators.isLength(v!, n)
          ? null
          : message ?? _locale.length(filed, v, n));

  ValidationBuilder byteLength(int n, [String? message]) =>
      add((v) => validators.isByteLength(v!, n)
          ? null
          : message ?? _locale.byteLength(filed, v, n));

  ValidationBuilder uuid([String? message]) => add(
      (v) => validators.isUUID(v!) ? null : message ?? _locale.uuid(filed, v));

  ValidationBuilder date([String? message]) => add(
      (v) => validators.isDate(v!) ? null : message ?? _locale.date(filed, v));

  ValidationBuilder after([DateTime? date, String? message]) =>
      add((v) => validators.isAfter(v!, date)
          ? null
          : message ?? _locale.after(filed, v, date));

  ValidationBuilder before([DateTime? date, String? message]) =>
      add((v) => validators.isBefore(v!, date)
          ? null
          : message ?? _locale.before(filed, v, date));

  ValidationBuilder creditCard([String? message]) =>
      add((v) => validators.isCreditCard(v!)
          ? null
          : message ?? _locale.creditCard(filed, v));

  ValidationBuilder isbn([String? message]) => add(
      (v) => validators.isISBN(v!) ? null : message ?? _locale.isbn(filed, v));

  ValidationBuilder json([String? message]) => add(
      (v) => validators.isJSON(v!) ? null : message ?? _locale.json(filed, v));

  ValidationBuilder multibyte([String? message]) =>
      add((v) => validators.isMultibyte(v!)
          ? null
          : message ?? _locale.multibyte(filed, v));

  ValidationBuilder ascii([String? message]) => add((v) =>
      validators.isAscii(v!) ? null : message ?? _locale.ascii(filed, v));

  ValidationBuilder fullWidth([String? message]) =>
      add((v) => validators.isFullWidth(v!)
          ? null
          : message ?? _locale.fullWidth(filed, v));

  ValidationBuilder halfWidth([String? message]) =>
      add((v) => validators.isHalfWidth(v!)
          ? null
          : message ?? _locale.halfWidth(filed, v));

  ValidationBuilder variableWidth([String? message]) =>
      add((v) => validators.isVariableWidth(v!)
          ? null
          : message ?? _locale.variableWidth(filed, v));

  ValidationBuilder surrogatePair([String? message]) =>
      add((v) => validators.isSurrogatePair(v!)
          ? null
          : message ?? _locale.surrogatePair(filed, v));

  ValidationBuilder mongoId([String? message]) => add((v) =>
      validators.isMongoId(v!) ? null : message ?? _locale.mongoId(filed, v));

  ValidationBuilder postalCode(String locale, [String? message]) =>
      add((v) => validators.isPostalCode(v!, locale)
          ? null
          : message ?? _locale.postalCode(filed, v));

  ValidationBuilder between(double min, double max, [String? message]) =>
      add((v) => validators.isBetween(double.tryParse(v!), min, max)
          ? null
          : message ?? _locale.between(filed, v, min, max));

  ValidationBuilder maxValue(double max, [String? message]) =>
      add((v) => validators.isMaxValue(double.tryParse(v!), max)
          ? null
          : message ?? _locale.maxValue(filed, v, max));

  ValidationBuilder minValue(double min, [String? message]) =>
      add((v) => validators.isMinValue(double.tryParse(v!), min)
          ? null
          : message ?? _locale.minValue(filed, v, min));

  ValidationBuilder afterOrEqualDate(DateTime afterDate, [String? message]) =>
      add((v) => validators.isAfterOrEqualDate(DateTime.parse(v!), afterDate)
          ? null
          : message ?? _locale.isAfterOrEqualDate(filed, v, afterDate));

  ValidationBuilder beforeOrEqualDate(DateTime beforeDate,
          [String? message]) =>
      add((v) => validators.isBeforeOrEqualDate(DateTime.parse(v!), beforeDate)
          ? null
          : message ?? _locale.isBeforeOrEqualDate(filed, v, beforeDate));

  ValidationBuilder notEqualDate(DateTime equalDate, [String? message]) =>
      add((v) => validators.isNotEqualDate(DateTime.parse(v!), equalDate)
          ? null
          : message ?? _locale.isNotEqualDate(filed, v, equalDate));

  ValidationBuilder notEqualDay(int day, [String? message]) =>
      add((v) => validators.isNotEqualDay(DateTime.parse(v!), day)
          ? null
          : message ?? _locale.isNotEqualDay(filed, v, day));
}

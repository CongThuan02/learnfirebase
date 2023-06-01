import 'package:intl/intl.dart';

import '../form_validator.dart';

class LocaleVi implements FormValidator {
  const LocaleVi();

  @override
  String name() => 'vi';

  @override
  String minLength(String filed, String v, int n) =>
      '$filed phải chứa ít nhất $n ký tự';

  @override
  String maxLength(String filed, String v, int n) =>
      '$filed phải chứa nhiều nhất $n ký tự';

  @override
  String email(String filed, String v) => '$filed không đúng định dạng email';

  @override
  String phoneNumber(String filed, String v) =>
      '$filed Không đúng định dạng số điện thoại';

  @override
  String required(String filed) => '$filed Không được bỏ trống';

  @override
  String ip(String filed, String v) => '$filed không phải là địa chỉ IP';

  @override
  String ipv6(String filed, String v) => '$filed không phải là địa chỉ IPv6';

  @override
  String url(String filed, String v) => '$filed không phải là địa chỉ url';

  @override
  String after(String filed, String v, [DateTime? date]) {
    date ??= DateTime.now();
    return "$filed không sau ngày ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  @override
  String alpha(String filed, String v) =>
      "$filed chỉ có thể chứa các kí tự chữ";

  @override
  String alphanumeric(String filed, String v) =>
      "$filed chỉ có thể chứa các kí tự chữ và số";

  @override
  String ascii(String filed, String v) => "$filed không phải là mã ASCII";

  @override
  String base64(String filed, String v) => "$filed không phải là Base64";

  @override
  String before(String filed, String v, [DateTime? date]) {
    date ??= DateTime.now();
    return "$filed giá trị không trước ngày ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  @override
  String byteLength(String filed, String v, int n) =>
      "$filed độ dài byte phải bằng $n";

  @override
  String creditCard(String filed, String v) =>
      "$filed không phải là credit card";

  @override
  String date(String filed, String v) => "$filed không phải là dạng ngày";

  @override
  String divisibleBy(String filed, String v, int n) =>
      "$filed không chia hết cho $n";

  @override
  String fqdn(String filed, String v) => "$filed không phải là tên miền";

  @override
  String fullWidth(String filed, String v) =>
      "$filed nửa chiều rộng không đúng";

  @override
  String halfWidth(String filed, String v) =>
      "$filed không có độ rộng ký tự phù hợp";

  @override
  String hexColor(String filed, String v) =>
      "$filed không phải là mã Hex Color";

  @override
  String hexadecimal(String filed, String v) =>
      "$filed không phải là mã Hexa decimal";

  @override
  String isFloat(String filed, String v) =>
      "$filed không phải là kiểu dữ liệu số thực";
  @override
  String isInt(String filed, String v) =>
      "$filed không phải là kiểu dữ liệu số nguyên";

  @override
  String isNull(String filed, String v) => "$filed phải để trống";

  @override
  String isbn(String filed, String v) => "$filed không phải là mã code ISBN";

  @override
  String json(String filed, String v) =>
      "$filed không phải là kiểu dữ liệu Json";

  @override
  String length(String filed, String v, int n) =>
      "$filed phải có độ dài bằng $n";

  @override
  String lowercase(String filed, String v) =>
      "$filed các ký tự phải viết thường";

  @override
  String mongoId(String filed, String v) => "$filed không phải là mongoId";

  @override
  String multibyte(String filed, String v) =>
      "$filed không chưa ký tự nhiều byte";

  @override
  String numeric(String filed, String v) => "$filed không phải dạng số";

  @override
  String postalCode(String filed, String v) => "$filed không phải Postal Code";

  @override
  String surrogatePair(String filed, String v) =>
      "$filed không có chứa ký tự thay thế";

  @override
  String uppercase(String filed, String v) => "$filed các ký tự phải viết hoa";

  @override
  String uuid(String filed, String v) => "$filed không phải mã uuid";

  @override
  String variableWidth(String filed, String v) =>
      "$filed chuỗi không có chứa hỗn hợp các ký tự đầy đủ và nửa chiều rộng không đúng";

  @override
  String between(String filed, String v, double min, double max) {
    return "$filed phải có giá trị nằm trong khoảng giữa $min và $max";
  }

  @override
  String maxValue(String filed, String v, double max) {
    return "$filed phải nhỏ hơn hoặc bằng $max";
  }

  @override
  String minValue(String filed, String v, double min) {
    return "$filed phải lớn hơn hoặc bằng $min";
  }

  @override
  String isAfterOrEqualDate(String filed, String v, DateTime afterDate) {
    return "$filed không được trước ngày ${DateFormat('dd/MM/yyyy').format(afterDate)}";
  }

  @override
  String isBeforeOrEqualDate(String filed, String v, DateTime beforeDate) {
    return "$filed không được sau ngày ${DateFormat('dd/MM/yyyy').format(beforeDate)}";
  }

  @override
  String isNotEqualDate(String filed, String v, DateTime equalDate) {
    return "$filed phải khác ngày ${DateFormat('dd/MM/yyyy').format(equalDate)}";
  }

  @override
  String isNotEqualDay(String filed, String v, int day) {
    return "Không được chọn ngày $day";
  }
}

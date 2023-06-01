import 'package:intl/intl.dart';

DateTime? tryParseDateTime(String typeFomat, String value,
    [DateTime? firstDate, DateTime? endDate]) {
  firstDate = firstDate ?? DateTime(1, 1, 1);
  endDate = endDate ?? DateTime.parse("99999-12-31 23:59:59.999");
  try {
    var format = DateFormat(typeFomat).parse(value);
    if (format.isBefore(firstDate) || format.isAfter(endDate)) {
      return null;
    }
    return format;
  } catch (e) {
    return null;
  }
}

int compareDate(DateTime a, DateTime b) {
  var d1 = DateTime.utc(a.year, a.month, a.day);
  var d2 = DateTime.utc(b.year, b.month, b.day);
  if (d1.isBefore(d2)) {
    return -1;
  } else if (d1.isAfter(d2)) {
    return 1;
  } else {
    return 0;
  }
}

import 'validator_builder.dart';

String? Function(String?) checkValidation(String filed, String rules) {
  final _rules = rules.split("|");
  final _valid = ValidationBuilder(filed: filed);
  for (final _rule in _rules) {
    switch (_rule.toLowerCase().trim()) {
      case "required":
        _valid.required();
        break;
      case "email":
        _valid.email();
        break;
      case "phone":
        _valid.phone();
        break;
      case "ip":
        _valid.ip();
        break;
      case "ipv6":
        _valid.ipv6();
        break;
      case "url":
        _valid.url();
        break;
      case "fqdn":
        _valid.fqdn();
        break;
      case "alpha":
        _valid.alpha();
        break;
      case "numeric":
        _valid.numeric();
        break;
      case "alphanumeric":
        _valid.alphanumeric();
        break;
      case "base64":
        _valid.base64();
        break;
      case "float":
        _valid.isFloat();
        break;
      case "hexadecimal":
        _valid.hexadecimal();
        break;
      case "hex_color":
        _valid.hexColor();
        break;
      case "lowercase":
        _valid.lowercase();
        break;
      case "isbn":
        _valid.isbn();
        break;
      case "uppercase":
        _valid.uppercase();
        break;
      case "null":
        _valid.isNull();
        break;
      case "uuid":
        _valid.uuid();
        break;
      case "date":
        _valid.date();
        break;
      case "credit_card":
        _valid.creditCard();
        break;
      case "json":
        _valid.json();
        break;
      case "multibyte":
        _valid.multibyte();
        break;
      case "ascii":
        _valid.ascii();
        break;
      case "full_width":
        _valid.fullWidth();
        break;
      case "half_width":
        _valid.halfWidth();
        break;
      case "variable_width":
        _valid.variableWidth();
        break;
      case "surrogate_pair":
        _valid.surrogatePair();
        break;
      case "mongo_id":
        _valid.mongoId();
        break;
      default:
        final subs = _rule.split(":");
        if (subs.length >= 2) {
          final _rights = subs[1].split(",");
          switch (subs[0].toLowerCase().trim()) {
            case "postal_code":
              _valid.postalCode(_rights[0].trim());
              break;
            case "min_length":
              _valid.minLength(int.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "max_length":
              _valid.maxLength(int.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "divisible_by":
              _valid.divisibleBy(int.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "byte_length":
              _valid.byteLength(int.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "after":
              _valid.after(
                  DateTime.tryParse(_rights[0].trim()) ?? DateTime.now());
              break;
            case "not_equal_date":
              _valid.notEqualDate(
                  DateTime.tryParse(_rights[0].trim()) ?? DateTime.now());
              break;
            case "not_equal_day":
              _valid.notEqualDay(int.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "after_or_equal_date":
              _valid.afterOrEqualDate(
                  DateTime.tryParse(_rights[0].trim()) ?? DateTime.now());
              break;
            case "before_or_equal_date":
              _valid.beforeOrEqualDate(
                  DateTime.tryParse(_rights[0].trim()) ?? DateTime.now());
              break;
            case "before":
              _valid.before(
                  DateTime.tryParse(_rights[0].trim()) ?? DateTime.now());
              break;
            case "max_value":
              _valid.maxValue(double.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "min_value":
              _valid.minValue(double.tryParse(_rights[0].trim()) ?? 0);
              break;
            case "between":
              if (_rights.length == 2) {
                _valid.between(double.tryParse(_rights[0].trim()) ?? 0,
                    double.tryParse(_rights[1].trim()) ?? 0);
              }
              break;
            default:
              break;
          }
        }
        break;
    }
  }

  return _valid.build();
}

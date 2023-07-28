import 'package:intl/intl.dart';

final dateFormat = DateFormat('dd/MM/y');

String appDateFormat(DateTime? value) {
  return value == null ? 'Não informada.' : dateFormat.format(value);
}

final dateTimeFormat = DateFormat('dd/MM/y HH:mm');

String appDateTimeFormat(DateTime? value) {
  return value == null ? 'Não informada.' : dateTimeFormat.format(value);
}

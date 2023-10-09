import 'package:intl/intl.dart';

extension PriceParsing on int? {
  String FormatPrice() {
    final formatter = NumberFormat("#,##0", "en_US");

    return formatter.format(this);
  }
}

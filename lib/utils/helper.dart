import 'package:intl/intl.dart';

class HelperMethod {
  static formatMoneyTextField(double amt) {
    ArgumentError.checkNotNull(amt, 'value');
    amt = amt / 100;
    final formatCurrency = NumberFormat.currency(symbol: '');

    return formatCurrency.format(amt);
  }

  static formatDate(String? selDate, {pattern = 'dd MMM, yyyy'}) {
    String formattedDate;
    if (selDate != null) {
      var date1 = DateTime.parse(selDate);
      formattedDate = DateFormat(pattern).format(date1);
    } else {
      DateTime now = DateTime.now();
      formattedDate = DateFormat(pattern).format(now);
    }

    return formattedDate;
  }

  static const String apiKey = "AIzaSyCihd5llNTsip2H1TwjjPCZ-90d0lEdJgA";
}

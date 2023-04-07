import 'package:intl/intl.dart';

class HelperMethod {
  //Just format money here
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

  static List<String> dayOfWeek() {
    final now = DateTime.now();

    final List<String> dates =[];

    // Calculate the start date of the current week.
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Calculate the end date of the current week.
    // final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Loop through the days of the week and print them.
    for (var i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final String l =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

      dates.add(l);
    }

    return dates;
  }

  // static const String apiKey = "AIzaSyCihd5llNTsip2H1TwjjPCZ-90d0lEdJgA";
}

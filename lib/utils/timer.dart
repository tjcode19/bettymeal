import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';

class DateWay {
  DateWay(
    this.date,
  );

  final DateTime date;

  get tDay => HelperMethod.formatDate(date.toIso8601String(), pattern: 'EEE');
  get tMon => HelperMethod.formatDate(date.toIso8601String(), pattern: 'MMM');
  get tDate => HelperMethod.formatDate(date.toIso8601String(), pattern: 'dd');
}

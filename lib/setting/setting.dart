import 'package:intl/intl.dart' show DateFormat;

class Setting {

  static DateTime convertDate(int time){
    return DateTime.fromMillisecondsSinceEpoch(time * 1000);
  }

  static String getDateFromTime(int time,
      {bool day = true, bool month = false}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    var format = DateFormat(!month? "EEEE" : "d MMM");
    String data = format.format(date);
    return data.toString();
  }
}

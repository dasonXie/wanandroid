import 'package:date_format/date_format.dart';

class TimeUtils {
  //时间戳转1990-12-10格式年月日
  static String getDateTime(int data) {
    var now = new DateTime.fromMillisecondsSinceEpoch(data);
    var a = now.millisecondsSinceEpoch; //时间戳

    return formatDate(
        DateTime.fromMillisecondsSinceEpoch(a), [yyyy, '-', mm, '-', dd]);
  }
}

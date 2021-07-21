import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();

  static final ONE_DAY_MILLIS = 24 * 60 * 60 * 1000;

  static String format(int timestamp, String pattern) {
    var formatter = DateFormat(pattern);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return formatter.format(date);
  }

  ///根据时间戳获取12小时制时间
  static String get12hrsTime(int timestamp) {
    var timeOfDay = TimeOfDay(
        hour: DateTime.fromMillisecondsSinceEpoch(timestamp).hour, minute: 0);
    if (timeOfDay.period == DayPeriod.am) {
      return '上午${timeOfDay.hourOfPeriod}时';
    } else {
      return '下午${timeOfDay.hourOfPeriod}时';
    }
  }

  static String getWeekday(int timestamp) {
    int weekday = DateTime.fromMillisecondsSinceEpoch(timestamp).weekday;
    switch (weekday) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
        return '周日';
      default:
        return '--';
    }
  }

  static int getStartTimeOfDate(int timestamp) {
    DateTime origin = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime result = DateTime(origin.year, origin.month, origin.day);
    return result.millisecondsSinceEpoch;
  }
}

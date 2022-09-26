extension DatetimeStringify on DateTime {
  bool isSameDay(DateTime dateTime) {
    if (day == dateTime.day &&
        month == dateTime.month &&
        year == dateTime.year) {
      return true;
    } else {
      return false;
    }
  }

  String getMonthAndDay() {
    return '${getMonth()} $day';
  }

  String getMonth() {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        throw Exception("Unmatched month");
    }
  }

  DateTime calendarBack(int day) {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - 24 * 60 * 60 * 1000 * day);
  }
}

extension TimeFrameCompare on DateTime? {
  bool isSameTimeZone(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.timeZoneName == other.timeZoneName;
  }

  bool isSameMonth(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.year == other.year && this!.month == other.month;
  }

  bool isSameWeek(DateTime? other) {
    if (this == null || other == null) return false;
    DateTime startOfWeek = other.subtract(Duration(days: other.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // if it is before the start of the week or after the end of the week, it is not in the same week
    if (this!.isBefore(startOfWeek) && this!.isAfter(endOfWeek)) return false;
    return true;
  }

  bool isSameDay(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.year == other.year && this!.month == other.month && this!.day == other.day;
  }

  bool isSameHour(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.year == other.year &&
        this!.month == other.month &&
        this!.day == other.day &&
        this!.hour == other.hour;
  }

  bool isSameMinute(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.year == other.year &&
        this!.month == other.month &&
        this!.day == other.day &&
        this!.hour == other.hour &&
        this!.minute == other.minute;
  }
}

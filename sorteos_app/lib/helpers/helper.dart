class Helper {
  static String getDateToString(DateTime date) {
    if (date != null) {
      return '${date.day}/${date.month}/${date.year}';
    } else {
      return '';
    }
  }
}

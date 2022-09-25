extension DurationEx on Duration {
  String toStringDuration() {
    if (inDays > 0) {
      if (inDays >= 365) {
        return "${inDays ~/ 365} tahun";
      } else if (inDays >= 30) {
        return "${inDays ~/ 30} bulan";
      }
      return "$inDays hari";
    } else if (inHours > 0) {
      return "$inHours jam";
    } else if (inMinutes > 0) {
      return "$inMinutes menit";
    } else {
      return "$inSeconds detik";
    }
  }
}

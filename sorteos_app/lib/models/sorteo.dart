class Sorteo {
  final int id;
  final String title;
  final DateTime? date;
  final String type;
  final following = [];

  Sorteo(this.id, this.title, this.date, this.type);

  get getId {
    return this.id;
  }

  get getTitle {
    return this.title;
  }

  get getDate {
    return this.date;
  }

  getDateToString() {
    if (date != null) {
      return '${this.date!.day}/${this.date!.month}/${this.date!.year}';
    } else {
      return '';
    }
  }
}

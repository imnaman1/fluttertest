class CartItem {
  final String date;
  final String seat;
  final DateTime firstDayOfWeek;

  CartItem(this.date, this.seat, this.firstDayOfWeek);
  @override
  String toString() => 'firstDayofWeek: $firstDayOfWeek';
}

enum BookingScope {
  upcoming('upcoming'),
  past('past');

  const BookingScope(this.queryValue);

  final String queryValue;
}

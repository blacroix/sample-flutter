class Book {
  final String title;
  final String cover;
  final String synopsis;
  final String isbn;
  final double price;

  Book(this.title, this.cover, this.synopsis, this.isbn, this.price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          cover == other.cover &&
          synopsis == other.synopsis &&
          isbn == other.isbn &&
          price == other.price;

  @override
  int get hashCode =>
      title.hashCode ^
      cover.hashCode ^
      synopsis.hashCode ^
      isbn.hashCode ^
      price.hashCode;
}

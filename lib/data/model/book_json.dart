import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/book.dart';

part 'book_json.g.dart';

@JsonSerializable()
class BookJson {
  final String title;
  final String cover;
  final List<String> synopsis;
  final String isbn;
  final double price;

  BookJson(this.title, this.cover, this.synopsis, this.isbn, this.price);

  factory BookJson.fromJson(Map<String, dynamic> json) =>
      _$BookJsonFromJson(json);

  Map<String, dynamic> toJson() => _$BookJsonToJson(this);

  Book toBook() => Book(
        title,
        cover,
        synopsis[0],
        isbn,
        price,
      );
}

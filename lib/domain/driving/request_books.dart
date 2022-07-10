import '../model/book.dart';

abstract class RequestBooks {
  Future<List<Book>> getBooks();
}

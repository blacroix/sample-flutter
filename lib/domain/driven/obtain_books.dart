import '../model/book.dart';

abstract class ObtainBooks {
  Future<List<Book>> getBooks();
}

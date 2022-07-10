import '../model/book.dart';

abstract class AddBook {
  List<Book> addBook(List<Book> books, Book book);
}
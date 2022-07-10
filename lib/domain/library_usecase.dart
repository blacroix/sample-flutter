import 'package:sample/domain/driven/obtain_books.dart';
import 'package:sample/domain/driving/request_books.dart';
import 'package:sample/domain/model/book.dart';

class LibraryUsecase implements RequestBooks {
  final ObtainBooks _obtainBooks;

  LibraryUsecase(this._obtainBooks);

  @override
  Future<List<Book>> getBooks() => _obtainBooks.getBooks();
}

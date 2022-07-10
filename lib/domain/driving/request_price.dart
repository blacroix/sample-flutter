import '../model/book.dart';
import '../model/price.dart';

abstract class RequestPrice {
  Future<Price> getPrice(List<Book> books);
}

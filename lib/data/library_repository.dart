import 'package:injectable/injectable.dart';
import 'package:sample/data/library_client_api.dart';
import 'package:sample/domain/driven/obtain_books.dart';
import 'package:sample/domain/driven/obtain_offers.dart';
import 'package:sample/domain/model/book.dart';
import 'package:sample/domain/model/offer.dart';

@injectable
class LibraryRepository implements ObtainBooks, ObtainOffers {
  final LibraryClientApi _clientApi;

  LibraryRepository(this._clientApi);

  @override
  Future<List<Book>> getBooks() async => (await _clientApi.getBooks())
      .map((bookJson) => bookJson.toBook())
      .toList();

  @override
  Future<List<Offer>> getOffers(List<String> isbns) async =>
      (await _clientApi.getOffers(isbns.join(','))).toOffers();
}

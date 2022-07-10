import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/book_json.dart';
import 'model/offers_json.dart';

part 'library_client_api.g.dart';

@RestApi(baseUrl: 'https://henri-potier.techx.fr/')
abstract class LibraryClientApi {
  factory LibraryClientApi(Dio dio, {String baseUrl}) = _LibraryClientApi;

  @GET("books")
  Future<List<BookJson>> getBooks();

  @GET("books/{isbns}/commercialOffers")
  Future<OffersJson> getOffers(@Path("isbns") String isbns);
}

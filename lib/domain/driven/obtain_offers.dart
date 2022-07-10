import '../model/offer.dart';

abstract class ObtainOffers {
  Future<List<Offer>> getOffers(List<String> isbns);
}

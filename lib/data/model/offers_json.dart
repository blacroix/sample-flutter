import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/offer.dart';

part 'offers_json.g.dart';

@JsonSerializable()
class OffersJson {
  final List<OfferJson> offers;

  OffersJson(this.offers);

  factory OffersJson.fromJson(Map<String, dynamic> json) =>
      _$OffersJsonFromJson(json);

  List<Offer> toOffers() => offers.map((e) => e.toOffer()).toList();
}

@JsonSerializable()
class OfferJson {
  final String type;
  final double value;
  final double? sliceValue;

  OfferJson(this.type, this.value, this.sliceValue);

  factory OfferJson.fromJson(Map<String, dynamic> json) =>
      _$OfferJsonFromJson(json);

  Offer toOffer() => Offer(
        Promotion.values.byName(type),
        value,
        sliceValue,
      );
}

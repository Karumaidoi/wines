class Wines {
  final String winery;
  final String wine;
  final Rating rating;
  final String location;
  final String image;
  final int? id;

  Wines(
      {required this.winery,
      required this.wine,
      required this.rating,
      required this.location,
      required this.image,
      required this.id});

  static Wines fromJson(json) => Wines(
        winery: json['winery'],
        wine: json['wine'],
        rating: Rating.fromJson(json['rating']),
        location: json['location'],
        image: json['image'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['winery'] = winery;
    data['wine'] = wine;
    data['rating'] = rating.toJson();
    data['location'] = location;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}

class Rating {
  String? average;
  String? reviews;

  Rating({this.average, this.reviews});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    data['reviews'] = reviews;
    return data;
  }
}

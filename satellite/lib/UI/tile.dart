class Product {
  final String satId;
  // final int noradCatId;
  // final int? noradFollowId; // Optional since it can be null
  final String name;
  // final String names;
  final String image;
  // final String status;
  // final DateTime? decayed; // Optional since it can be null
  // final DateTime launched;
  // final DateTime? deployed; // Optional since it can be null
  // final String website;
  // final String operator;
  final String countries;
  // final List<dynamic> telemetries;
  // final DateTime updated;
  // final String citation;
  // final bool isFrequencyViolator;
  // final List<dynamic> associatedSatellites;

  Product({
    required this.satId,
    // required this.noradCatId,
    // this.noradFollowId,
    required this.name,
    // required this.names,
    required this.image,
    // required this.status,
    // this.decayed,
    // required this.launched,
    // this.deployed,
    // required this.website,
    // required this.operator,
    required this.countries,
    // required this.telemetries,
    // required this.updated,
    // required this.citation,
    // required this.isFrequencyViolator,
    // required this.associatedSatellites,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      satId: json['sat_id'] as String,
      // noradCatId: json['norad_cat_id'] as int,
      // noradFollowId: json['norad_follow_id'] as int?,
      name: json['name'] as String,
      // names: json['names'] as String,
      image: json['image'] as String,
      // status: json['status'] as String,
      // decayed: json['decayed'] != null ? DateTime.parse(json['decayed']) : null,
      // launched: DateTime.parse(json['launched']),
      // deployed: json['deployed'] != null ? DateTime.parse(json['deployed']) : null,
      // website: json['website'] as String,
      // operator: json['operator'] as String,
      countries: json['countries'] as String,
      // telemetries: json['telemetries'] as List<dynamic>,
      // updated: DateTime.parse(json['updated']),
      // citation: json['citation'] as String,
      // isFrequencyViolator: json['is_frequency_violator'] as bool,
      // associatedSatellites: json['associated_satellites'] as List<dynamic>,
    );
  }
}

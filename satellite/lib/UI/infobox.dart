class Info {
  final String tle0;
  final String tle1;
  final String tle2;
  final String tleSource;
  final String satId;
  final int noradCatId;
  final DateTime updated;

  Info({
    required this.tle0,
    required this.tle1,
    required this.tle2,
    required this.tleSource,
    required this.satId,
    required this.noradCatId,
    required this.updated,
  });

  // Factory constructor to create Info objects from JSON data
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      tle0: json['tle0'],
      tle1: json['tle1'],
      tle2: json['tle2'],
      tleSource: json['tle_source'],
      satId: json['sat_id'],
      noradCatId: json['norad_cat_id'],
      updated: DateTime.parse(json['updated']),
    );
  }
}

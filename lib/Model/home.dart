class HomeSection {
  final String uniqueId;
  final String homeBanner;
  final String exclusivePartner;
  final String campBanner;

  HomeSection({
    required this.uniqueId,
    required this.homeBanner,
    required this.exclusivePartner,
    required this.campBanner,
  });

  factory HomeSection.fromJson(Map<String, dynamic> json) {
    return HomeSection(
      uniqueId: json['uniqueid'] as String,
      homeBanner: json['Home Banner'] as String,
      exclusivePartner: json['Exclusive Parmersup'] as String,
      campBanner: json['Top Perpermag Compoign'] as String,
    );
  }
}

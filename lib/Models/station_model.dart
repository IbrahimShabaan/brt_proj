class StationModel {
  final int id;            // لازم تضيف الـ id هنا
  final String nameAr;
  final String cityAr;
  final String stationTypeAr;

  StationModel({
    required this.id,
    required this.nameAr,
    required this.cityAr,
    required this.stationTypeAr,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'],        // خلي بالك من نوع البيانات، غالبا بيكون int
      nameAr: json['nameAr'] ?? '',
      cityAr: json['cityAr'] ?? '',
      stationTypeAr: json['stationTypeAr'] ?? '',
    );
  }
}
class TicketHistoryModel {
  final String number;
  final String createdAt;
  final int price;
  final int count;
  final String nameAr;
  final String nameEn;
  final String color;
  final String hexCode;
  final String tripDate;

  TicketHistoryModel({
    required this.number,
    required this.createdAt,
    required this.price,
    required this.count,
    required this.nameAr,
    required this.nameEn,
    required this.color,
    required this.hexCode,
    required this.tripDate,
  });

  factory TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    return TicketHistoryModel(
      number: json['number'],
      createdAt: json['createdAt'],
      price: json['price'],
      count: json['count'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      color: json['color'],
      hexCode: json['hexCode'],
      tripDate: json['tripDate'],
    );
  }
}
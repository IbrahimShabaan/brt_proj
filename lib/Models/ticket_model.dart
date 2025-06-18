class TicketCategory {
  final String? color;
  final String hexCode;
  final int stationCount;
  final double price;
  final int? ticketTypeId;
  final dynamic? ticketType;
  final int? maxCount;
  final bool? isDeleted;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final int? id;

  TicketCategory({
     this.color,
     required this.hexCode,
     required this.stationCount,
     required this.price,
     this.ticketTypeId,
    this.ticketType,
     this.maxCount,
     this.isDeleted,
     this.nameAr,
     this.nameEn,
     this.createdAt,
     this.modifiedAt,
     this.id,
  });

  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(
      color: json['color'],
      hexCode: json['hexCode'],
      stationCount: json['stationCount'],
      price: json['price'],
      ticketTypeId: json['ticketTypeId'],
      ticketType: json['ticketType'],
      maxCount: json['maxCount'],
      isDeleted: json['isDeleted'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      modifiedAt: json['modifiedAt'] != null ? DateTime.parse(json['modifiedAt']) : null,
      id: json['id'],
    );
  }

  // إضافات لتسهيل الاستخدام في UI

  String get ticketColorHex => hexCode;

  double get ticketPrice => price;
}
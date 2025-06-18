import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/transaction_model_details.dart';
import '../const/constants.dart';

class CustomTicket extends StatelessWidget {
  final DateTime createdAt;
  final TransactionDetailModel detail;

  const CustomTicket({
    super.key,
    required this.createdAt,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    String issueDate = createdAt.toString().split(' ')[0];
    String issueTime = createdAt.toString().split(' ')[1].split('.')[0];
    String ticketColorHex = detail.ticketCategory.hexCode;

    return Container(
      width: 334.w,
      height: 260.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // BRT Header
            Column(
              children: [
                SizedBox(
                  width: 300.w,
                  height: 20.h,
                  child: Image.asset('assets/images/Info.png'),
                ),
                Text(
                  'BRT',
                  style: TextStyle(
                    color: ConstColors.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Bus Rapid Transit',
                  style: TextStyle(
                    color: ConstColors.kPrimaryColor,
                  ),
                ),
              ],
            ),

            Divider(color: Colors.grey),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // Date & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('وقت الاصدار : $issueTime',
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 4.w),
                      Text('تاريخ الاصدار : $issueDate',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),

                  // Color & Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              color: _parseHexColor(ticketColorHex),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(' : لون التذكرة',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('${detail.count}',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          Text(' : عدد التذاكر',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            // QR Code
            SizedBox(
              height: 70.h,
              width: 70.w,
              child: Image.asset('assets/images/QR.png'),
            ),

            SizedBox(height: 14.h),

            // Price
            Row(
              children: [
                Text('ج.م',
                    style: TextStyle(
                        color: ConstColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                Text('${detail.price.toStringAsFixed(0)}',
                    style: TextStyle(
                        color: ConstColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                SizedBox(width: 10.w),
                Text(': سعر التذكرة', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ دالة لحماية قراءة كود اللون
  Color _parseHexColor(String hexCode) {
    try {
      hexCode = hexCode.replaceAll('#', '').toUpperCase();
      if (hexCode.length == 6) {
        return Color(int.parse('0xFF$hexCode'));
      } else if (hexCode.length == 8) {
        return Color(int.parse('0x$hexCode'));
      } else {
        return Colors.grey; // default fallback
      }
    } catch (e) {
      return Colors.grey;
    }
  }
}
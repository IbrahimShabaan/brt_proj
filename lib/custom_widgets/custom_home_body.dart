import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../Models/station_model.dart';
import '../Screens/brt_ticket_screen.dart';

import '../features/auth_bloc/transaction_bloc.dart';
import '../features/auth_event/transaction_event.dart';
import '../features/auth_state/transaction_state.dart';
import '../features/repo/fetch_station.dart';
import '../features/repo/ticket_category_repo.dart';
import 'auth_widget.dart';
import 'custom_datepicker.dart';

class CustomHomeBody extends StatefulWidget {
  const CustomHomeBody({super.key});

  @override
  State<CustomHomeBody> createState() => _CustomHomeBodyState();
}

class _CustomHomeBodyState extends State<CustomHomeBody> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController ticketCountController = TextEditingController();

  StationModel? fromStation;
  StationModel? toStation;

  String? ticketColorHex;
  int? stationCount;
  double? ticketPrice;
  int? ticketCategoryId;

  final TicketCategoryRepository ticketRepo = TicketCategoryRepository();

  Future<void> selectStation(bool isFrom) async {
    final selectedStation = await showMaterialModalBottomSheet<StationModel>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return FutureBuilder<List<StationModel>>(
          future: fetchStations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text('خطأ أثناء تحميل المحطات: ${snapshot.error}'),
              );
            } else {
              final stations = snapshot.data!;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: stations.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final station = stations[index];
                  return ListTile(
                    title: Text(station.nameAr),
                    subtitle: Text('المدينة: ${station.cityAr} - النوع: ${station.stationTypeAr}'),
                    onTap: () => Navigator.pop(context, station),
                  );
                },
              );
            }
          },
        );
      },
    );

    if (selectedStation != null) {
      setState(() {
        if (isFrom) {
          fromStation = selectedStation;
        } else {
          toStation = selectedStation;
        }
      });

      // بعد اختيار المحطتين، جلب بيانات التذكرة
      if (fromStation != null && toStation != null) {
        await fetchTicketCategoryData();
      }
    }
  }

  Future<void> fetchTicketCategoryData() async {
    print('From Station ID: ${fromStation!.id}, To Station ID: ${toStation!.id}');

    try {
      final result = await ticketRepo.fetchTicketCategory(
        fromStationId: fromStation!.id,
        toStationId: toStation!.id,
      );
      print('Fetched Ticket: Color = ${result.ticketColorHex}, Count = ${result.stationCount}, Price = ${result.ticketPrice}');

      setState(() {
        ticketColorHex = result.ticketColorHex;
        stationCount = result.stationCount;
        ticketPrice = result.ticketPrice.toDouble();
        ticketCategoryId = result.id; // ✅ أهم نقطة
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل جلب بيانات التذكرة: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      height: 670.h,
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
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.linear_scale_sharp),
            SizedBox(height: 5.h),
            Text("Available lines", style: TextStyle(color: Colors.grey[400], fontSize: 14.sp)),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  buildStationSelector(
                    label: 'From'.tr(),
                    station: fromStation,
                    onTap: () => selectStation(true),
                  ),
                  Icon(Icons.switch_right_sharp, size: 30, color: Colors.blue[500]),
                  buildStationSelector(
                    label: 'To'.tr(),
                    station: toStation,
                    onTap: () => selectStation(false),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            AuthButton(buttonText: 'Find Transportation'.tr(), onPressed: () {}),
            SizedBox(height: 20.h),
            buildTextField(
              label: 'Ticket Color'.tr(),
              hint: 'Ticket Color',
              showGreenSquare: true,
              isReadOnly: true,
              isEnabled: false,
             // hexColorCode: ticketCategory.hexCode,
              hexColorCode: ticketColorHex?.toString() ?? '',


            ),
            SizedBox(height: 10.h),
            buildTextField(
              label:  stationCount?.toString() ?? 'Station Count',
              hint: stationCount?.toString() ?? 'Station Count',
              isReadOnly: true,
              isEnabled: false,
            ),
            SizedBox(height: 10.h),
            buildTextField(
              label: ticketPrice != null ? '${ticketPrice!.toStringAsFixed(2)} EGP' : '0 EGP',
              hint: ticketPrice != null ? '${ticketPrice!.toStringAsFixed(2)} EGP' : '0 EGP',
              isReadOnly: true,
              isEnabled: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDatePickerFormField(
                labelText: "Reserve Date".tr(),
                hintText: "example : 16, Jan 2023".tr(),
                controller: dateController,
                textColor: Colors.black,
                borderColor: Colors.grey,
              ),
            ),
            buildTextField(
              label: 'Number of Tickets'.tr(),
              hint: 'Number of Tickets'.tr(),
              controller: ticketCountController,
            ),
            SizedBox(height: 20.h),
            BlocListener<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is TransactionSuccess) {
                  final transaction = state;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BrtTicketScreen(

                      ticketNumber: '2',
                      issueDate: '02/12/2026',
                      issueTime: '02:35',
                      station: fromStation?.nameAr ?? '',
                      stationCount: stationCount ?? 0,
                      ticketPrice: ticketPrice ?? 0.0,

                    )),
                  );
                } else if (state is TransactionFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state is TransactionSuccess) {
                    final transaction = state.transaction;

                    // استخراج أول عنصر من تفاصيل التذكرة
                    final detail = transaction.transactionDetails.first;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrtTicketScreen(
                          ticketNumber: detail.number,
                          issueDate: transaction.createdAt != null
                              ? DateFormat('yyyy-MM-dd').format(transaction.createdAt!)
                              : 'غير متاح',
                          issueTime: transaction.createdAt != null
                              ? DateFormat('HH:mm').format(transaction.createdAt!)
                              : 'غير متاح',
                          station: fromStation?.nameAr ?? '',
                          stationCount: detail.ticketCategory.stationCount ?? 0,
                          ticketPrice: detail.price,
                        ),
                      ),
                    );
                  } else if (state is TransactionFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    return AuthButton(
                      buttonText: 'Book Ticket'.tr(),
                      onPressed: () {
                        if (fromStation == null ||
                            toStation == null ||
                            ticketCategoryId == null ||
                            dateController.text.isEmpty ||
                            ticketCountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("يرجى ملء جميع الحقول")),
                          );
                          return;
                        }

                        final count = int.tryParse(ticketCountController.text);
                        if (count == null || count <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("عدد التذاكر غير صالح")),
                          );
                          return;
                        }

                        context.read<TransactionBloc>().add(
                          CreateTransactionPressed(
                            profileId: 1,
                            shiftId: 2,
                            ticketCategoryId: ticketCategoryId!,
                            tripDate: dateController.text,
                            count: count,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStationSelector({
    required String label,
    required StationModel? station,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 143.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200, width: 3.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              Text(
                station?.nameAr ?? 'اختيار المحطة',
                style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    Widget? prefix,
    TextEditingController? controller,
    bool showGreenSquare = false,
    bool isReadOnly = false,
    bool isEnabled = true,
    String? hexColorCode,
  }) {
    Color? hexToColor(String? code) {
      if (code == null || code.isEmpty) return null;
      final hex = code.replaceAll("#", "");
      return Color(int.parse("FF$hex", radix: 16));
    }

    return IgnorePointer(
      ignoring: !isEnabled,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          enabled: isEnabled,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            fillColor: !isEnabled ? Colors.white : null,
            hintStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(color: Colors.black),
            filled: !isEnabled,
            prefixIcon: showGreenSquare
                ? Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, bottom: 3),
              child: Container(
                width: 40,
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: hexToColor(hexColorCode) ?? Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
                : prefix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        ),
      ),
    );
  }
}
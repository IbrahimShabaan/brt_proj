import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Models/ticket_model.dart';
import '../Models/transaction_model_details.dart';
import '../const/constants.dart';
import '../custom_widgets/custom_home_body.dart';
import '../custom_widgets/custom_ticket.dart';
import '../features/auth_bloc/ticket_history_bloc.dart';
import '../features/auth_state/ticket_history_state.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool showAllTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Appbar_Widget(),
          appbar_Text_Widget(),
          Positioned.fill(
            top: 180,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomHomeBody(),
                  SizedBox(height: 10.h),
                  Padding(
                    padding:  EdgeInsets.only(left: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'My Trips',
                          style: TextStyle(
                            color: ConstColors.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              showAllTickets = !showAllTickets;
                            });
                          },
                          child: Text(
                            showAllTickets ? 'Hide' : 'Show All',
                            style: TextStyle(color: ConstColors.kPrimaryColor),
                          ),
                        ),
                        SizedBox(width: 20.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (showAllTickets)
                    BlocBuilder<TicketHistoryBloc, TicketHistoryState>(
                      builder: (context, state) {
                        if (state is TicketHistoryLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is TicketHistoryLoaded) {
                          return Column(
                            children: state.tickets.map((ticket) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: CustomTicket(
                                  createdAt: DateTime.now(),
                                  detail: TransactionDetailModel(
                                    count: ticket.count,
                                    price: ticket.price.toDouble(),
                                    number: ticket.number,
                                    ticketCategory: TicketCategory(
                                      hexCode: ticket.hexCode,
                                      price: 25,
                                      stationCount: 0,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        } else if (state is TicketHistoryError) {
                          return Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned appbar_Text_Widget() {
    return Positioned(
      top: 80.h,
      left: 20.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Morning Dear,",
            style: TextStyle(color: Colors.white38, fontSize: 14.sp),
          ),
          Text(
            "Where are you\nGoing Today?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Positioned Appbar_Widget() {
    return Positioned(
      top: 0,
      child: Container(
        color: ConstColors.kPrimaryColor,
        width: 375.w,
        height: 308.h,
        child: Image.asset(
          'assets/desgin/img1design.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
import 'package:brt_proj/Screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import 'features/auth_bloc/auth_bloc.dart';
import 'features/auth_bloc/ticket_history_bloc.dart';
import 'features/auth_bloc/transaction_bloc.dart';
import 'features/auth_event/ticket_history_event.dart';
import 'features/repo/auth_repo.dart';
import 'features/repo/ticket_history_repo.dart';
import 'features/repo/transaction_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<TransactionRepository>(create: (_) => TransactionRepository()),
        RepositoryProvider<TicketHistoryRepository>(create: (_) => TicketHistoryRepository()), // ✅ جديد
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc(
              repository: context.read<TransactionRepository>(),
            ),
          ),
          BlocProvider<TicketHistoryBloc>(
            create: (context) => TicketHistoryBloc(
              context.read<TicketHistoryRepository>(),
            )..add(FetchTicketHistory()),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: StartScreen(),
            );
          },
        ),
      ),
    );
  }
}
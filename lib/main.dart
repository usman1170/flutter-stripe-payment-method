import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payments/provider/local_auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments/screens/notifications/notification_service.dart';
import 'package:payments/screens/notifications/schedule_notification.dart';
import 'package:payments/screens/splash.dart';
import 'package:payments/theme/app_theme.dart';
import 'package:payments/theme/bloc/theme_cubit.dart';
import 'package:payments/utils/consts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await ScheduleNotification.init();
  await NotificationService().initNotification();
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatgorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => LocalAuthProvider(),
          child: MaterialApp(
            title: 'Payments',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      }),
    );
  }
}

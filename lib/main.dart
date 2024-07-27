import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payments/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments/theme/app_theme.dart';
import 'package:payments/theme/bloc/theme_cubit.dart';
import 'package:payments/utils/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  Stripe.publishableKey = stripePublishableKey;
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state,
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //     seedColor: Colors.deepPurple,
          //   ),
          //   useMaterial3: true,
          // ),
          home: const HomeScreen(),
        );
      }),
    );
  }
}

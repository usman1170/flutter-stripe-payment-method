import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments/screens/notifications/notification.dart';
import 'package:payments/services/stripe_service.dart';
import 'package:payments/theme/app_colors.dart';
import 'package:payments/theme/bloc/theme_cubit.dart';
import 'package:payments/theme/theme_mode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? AppColors.darkColor : Colors.white,
      appBar: AppBar(
        title: const Text("Payments"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            onPressed: () {
              if (context.isDarkMode) {
                context.read<ThemeCubit>().updateTheme(ThemeMode.light);
              } else {
                context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
              }
            },
            icon: Icon(
              context.isDarkMode
                  ? Icons.brightness_4
                  : Icons.brightness_6_outlined,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notification_important,
              ),
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              StripeService.stripeService.makePayment();
            },
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                  child: Text(
                "Payment",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ],
      )),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:payments/provider/local_auth_provider.dart';
import 'package:payments/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  late LocalAuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider = Provider.of<LocalAuthProvider>(context, listen: false);
      authProvider.authenticate().then((value) {
        if (value) {
          log(authProvider.authStatus.toString());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LocalAuthProvider>(builder: (context, value, child) {
          return value.isAuth
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        value.authenticate().then((value) {
                          if (value) {
                            log(authProvider.authStatus.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          }
                        });
                      },
                      child: const Text("Retry"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Visibility(
                      visible: value.msg != "notAvailable",
                      child: const Text(
                        "Please Verify first...",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Visibility(
                      visible: value.msg == "notAvailable",
                      child: Text(
                        "please enable the security credentials in settings and try again"
                            .allWordsCapitilize(),
                        textAlign: TextAlign.center,
                      ).px20().py12(),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}

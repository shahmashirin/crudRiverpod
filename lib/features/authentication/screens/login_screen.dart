import 'package:crudriverpod/features/authentication/screens/sign_in_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/auth_image_constants.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLoading=ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 30,
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Skip",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Dive into anything',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Image.asset(
              Constants.loginEmotePath,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
           const SigninButton()
        ],
      ),
    );
  }
}

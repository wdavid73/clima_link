import 'package:flutter/material.dart';
import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/views/views.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: RegisterView(),
      ),
    );
  }
}

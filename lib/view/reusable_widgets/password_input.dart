import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isTap,
      decoration: InputDecoration(
        hintText: '••••••••',
        prefixIcon: Icon(Icons.lock_outline, color: scheme.primary),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isTap = !isTap;
            });
          },
          child: Icon(
            isTap ? Icons.visibility_off : Icons.remove_red_eye_outlined,
            color: scheme.primary,
          ),
        ),
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

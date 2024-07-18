import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui.dart';
import 'login_webview.dart';

class AccountModal extends ConsumerWidget {
  const AccountModal({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextWithPadding(
            text: 'Login Riot Account',
            style: textTitle,
            top: 0,
            bottom: 0,
          ),
          const TextWithPadding(
            text:
                'You will be redirected to the official Riot Games website 😀',
            style: textNormal,
          ),
          ButtonCustomBackground(
              text: 'Login',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginWebView(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class InputCustom extends StatelessWidget {
  const InputCustom({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType,
    this.autofocus = false,
    this.onChanged,
  });

  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dividerGrey,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: secondaryGrey!, width: 1.0),
      ),
      child: TextFormField(
        onChanged: onChanged,
        autofocus: autofocus,
        obscureText: isPassword,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';
import 'login_webview.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

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
          ),
          const SizedBox(height: 10),
          InputCustom(
            hintText: 'User',
            // autofocus: true,
            onChanged: (value) =>
                ref.read(accountProvider.notifier).setUsername(value),
          ),
          const SizedBox(height: 20),
          InputCustom(
            hintText: 'Password',
            isPassword: true,
            onChanged: (value) =>
                ref.read(accountProvider.notifier).setPassword(value),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          ButtonCustomBackground(
            text: 'Login',
            onPressed: () async {
              await ref.read(accountProvider.notifier).login().then((value) {
                Navigator.of(context).pop();
              });
            },
          ),
          const SizedBox(height: 5),
          TextWithPadding(
            text:
                'Your account have a multifactor authentication or other method to login? ',
            style: subTitleGrey,
          ),
          CupertinoButton(
              child: Text('Try here', style: buttonWithoutBackground),
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

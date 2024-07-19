import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../ui.dart';

class AccountModal extends ConsumerWidget {
  const AccountModal({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final settingsState = ref.watch(settingsProvider);
    return Stack(
      children: [
        Container(
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
              const TextWithPadding(
                text:
                    'Use this method to save all accounts and switch between them.',
                left: 0,
                right: 0,
                style: textNormal,
              ),

              InputCustom(
                hintText: 'User',
                // autofocus: true,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).setUsername(value),
              ),
              const SizedBox(height: 20),
              InputCustom(
                hintText: 'Password',
                isPassword: true,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).setPassword(value),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              ButtonCustomBackground(
                text: 'Login',
                onPressed: () async {
                  if (settingsState.accounts?.isEmpty ?? true) {
                    await ref
                        .read(settingsProvider.notifier)
                        .login()
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                    return;
                  }
                  await ref
                      .read(settingsProvider.notifier)
                      .addAccount()
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                  return;
                },
              ),
              const SizedBox(height: 5),
              TextWithPadding(
                text: 'YOUR ACCOUNT SHOULD NOT ASK FOR A CODE FOR THIS METHOD.',
                left: 0,
                right: 0,
                // top: 0,
                style: textNormalGrey,
              ),
              // TextWithPadding(
              //   text:
              //       'Your account have a multifactor authentication or other method to login?',
              //   left: 0,
              //   right: 0,
              //   style: subTitleGrey,
              // ),
              // CupertinoButton(
              //     child: Text('Try here', style: buttonWithoutBackground),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => const LoginWebView(),
              //         ),
              //       );
              //     }),
            ],
          ),
        ),
        if (settingsState.isLoading)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const CircularLoad(),
            ),
          )
      ],
    );
  }
}

class InputCustom extends StatefulWidget {
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
  InputCustomState createState() => InputCustomState();
}

class InputCustomState extends State<InputCustom> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dividerGrey,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: secondaryGrey!, width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: widget.onChanged,
              autofocus: widget.autofocus,
              obscureText: _obscureText,
              autocorrect: false,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.white),
              ),
              keyboardType: widget.keyboardType,
            ),
          ),
          if (widget.isPassword)
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: primaryGrey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
        ],
      ),
    );
  }
}

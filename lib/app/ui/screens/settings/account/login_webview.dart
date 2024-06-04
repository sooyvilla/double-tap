import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insane_bolt/app/config/constants/valorant_urls.dart';
import 'package:insane_bolt/app/ui/providers/account/account_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends ConsumerStatefulWidget {
  const LoginWebView({super.key});

  @override
  ConsumerState<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends ConsumerState<LoginWebView> {
  static String userAgent =
      "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36";

  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          if (!request.url.contains("https://playvalorant.com/")) {
            return NavigationDecision.navigate;
          }
          await ref
              .read(accountProvider.notifier)
              .loginWebView(request.url.split('=')[1].split('&')[0])
              .then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });

          return NavigationDecision.prevent;
        },
      ))
      ..loadRequest(
        Uri.parse(ValorantUrls.urlLoginWebView),
      )
      ..clearLocalStorage()
      ..clearCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}

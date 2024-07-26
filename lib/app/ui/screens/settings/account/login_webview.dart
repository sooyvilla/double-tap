import 'package:double_tap/app/config/constants/urls/valorant_urls.dart';
import 'package:double_tap/app/ui/providers/settings/settings_provider.dart';
import 'package:double_tap/app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends ConsumerStatefulWidget {
  const LoginWebView({super.key});

  @override
  ConsumerState<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends ConsumerState<LoginWebView> {
  static String userAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';

  late WebViewController controller;
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          if (!request.url.contains('https://playvalorant.com/')) {
            return NavigationDecision.navigate;
          }
          await ref
              .read(settingsAccountProvider.notifier)
              .loginWebView(request.url)
              .then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });

          return NavigationDecision.prevent;
        },
        onProgress: (progress) {
          progress == 100 ? isLoading.value = false : isLoading.value = true;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: textTitle,
        ),
        centerTitle: true,
        backgroundColor: primaryGrey,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              if (loading) {
                return const Center(
                  child: CircularLoad(),
                );
              }
              return const SizedBox
                  .shrink(); // Widget vacío si no está cargando
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }
}
